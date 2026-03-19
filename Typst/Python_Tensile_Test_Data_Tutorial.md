# Python Tutorial: Processing and Visualizing Tensile Test Data

> **Dataset**: Nylon 6 (PA6) tensile test — BG205, gauge length 100 mm, width 10 mm, thickness 4 mm, crosshead speed 5 mm/min.
> **Environment**: Obsidian + Code Emitter plugin (runs each code block independently via Jupyter kernel).

---

Nylon 6 (PA6) tensile test — BG205_GaugeLength-100 mm_Width-10 mm_Thickness-4 mm_CrossheadSpeed-5-mm-per-min.

Nylon 6 (PA6) tensile test — BG205 GaugeLength 100 mm Width 10 mm Thickness 4 mm Crosshead Speed 5 mm per min.
## Table of Contents

1. [Setup and Environment](#1-setup-and-environment)
2. [Reading Excel Data with pandas](#2-reading-excel-data-with-pandas)
3. [Data Inspection and Cleaning](#3-data-inspection-and-cleaning)
4. [Key Mechanical Properties](#4-key-mechanical-properties)
5. [Basic Visualization with matplotlib](#5-basic-visualization-with-matplotlib)
6. [Advanced Plots](#6-advanced-plots)
7. [Statistical Analysis](#7-statistical-analysis)
8. [Exporting Results](#8-exporting-results)
9. [Full Pipeline Script](#9-full-pipeline-script)

---

## 1. Setup and Environment

### 1.1 Installing Required Libraries

Open a terminal and run:

```bash
pip install pandas openpyxl matplotlib scipy numpy
```

| Library      | Purpose                                                      |
| ------------ | ------------------------------------------------------------ |
| `pandas`     | Data loading, manipulation, and analysis                     |
| `openpyxl`   | Engine for reading `.xlsx` files                             |
| `matplotlib` | Plotting and visualization                                   |
| `scipy`      | Scientific computations (e.g., finding peaks, interpolation) |
| `numpy`      | Numerical array operations                                   |


### 1.2 Code Emitter Notes

Because **Code Emitter** in Obsidian runs each code block as an independent cell in a shared Jupyter kernel (within one note session), variables defined in an earlier block are available in later blocks — exactly like a Jupyter notebook. However, you must **run the blocks in order from top to bottom** when you open the note fresh.

---

## 2. Reading Excel Data with pandas 

### 2.1 Understanding `pd.read_excel()`  

```run-python
import pandas as pd

# Load the file — adjust the path to match where you saved the .xlsx
FILE_PATH = r"C:\Users\hexio\Documents\Obsidian\Typst\Data\湖北彰宸科技-BG205-尼龙6-拉伸测试-5mm每min-标距100mm-宽度10mm-厚度4mm.xlsx"

# Read the first (and only) sheet; row 0 is used as column headers by default
df_raw = pd.read_excel(FILE_PATH, sheet_name=0, header=0, engine="openpyxl")

print(df_raw.shape)        # (rows, columns)
print(df_raw.columns.tolist())
```


**Key parameters of `pd.read_excel()`** 

| Parameter | What it controls |
|---|---|
| `sheet_name` | Sheet index (int) or name (str); `None` loads all sheets as a dict |
| `header` | Row number to use as column names (0-indexed); `None` means no header |
| `engine` | Parser backend; use `"openpyxl"` for `.xlsx` |
| `usecols` | List of column letters or names to load (e.g., `"A:E"`) |
| `skiprows` | Number of rows to skip before reading |
| `nrows` | Maximum number of data rows to read |

### 2.2 Renaming Columns for Convenience

The original column names contain Chinese characters and trailing spaces, which can be inconvenient. Rename them to clean ASCII names:

```run-python
import pandas as pd

FILE_PATH = r"C:\Users\hexio\Documents\Obsidian\Typst\Data\湖北彰宸科技-BG205-尼龙6-拉伸测试-5mm每min-标距100mm-宽度10mm-厚度4mm.xlsx"
df_raw = pd.read_excel(FILE_PATH, header=0, engine="openpyxl")

# Map old names → new names
column_map = {
    "No.":        "index",
    "时间( s) ":  "time_s",
    "变形( mm) ": "displacement_mm",
    "力( kgf) ":  "force_kgf",
    "应力( MPa) ":"stress_MPa",
    "应变( %) ":  "strain_pct",
}
df = df_raw.rename(columns=column_map)

print(df.columns.tolist())
print(df.head(5))
```

---

## 3. Data Inspection and Cleaning

### 3.1 Inspecting the DataFrame

```run-python
# (Assumes df is defined from Section 2)

# Shape
print("Shape:", df.shape)

# Data types and non-null counts
print(df.info())

# Descriptive statistics for every numeric column
print(df.describe())
```



**Reading `df.describe()` output**

| Statistic | Meaning |
|---|---|
| `count` | Number of non-null values |
| `mean` | Arithmetic average |
| `std` | Standard deviation |
| `min` / `max` | Range extremes |
| `25%` / `50%` / `75%` | Quartiles |

### 3.2 Checking for Missing Values

```run-python
# Count NaN in each column
print(df.isnull().sum())

# Drop any rows that contain NaN
df = df.dropna()

# Reset the integer index after dropping rows
df = df.reset_index(drop=True)

print("Rows after cleaning:", len(df))
```

### 3.3 Removing the Pre-Load Zero Region

At the start of a tensile test the specimen is being gripped and force is effectively zero. Including this region can distort calculations. Filter it out by keeping only rows where force exceeds a small threshold:

```run-python
FORCE_THRESHOLD_KGF = 0.05   # adjust if needed

df_clean = df[df["force_kgf"] >= FORCE_THRESHOLD_KGF].copy()
df_clean = df_clean.reset_index(drop=True)

print(f"Rows after removing pre-load region: {len(df_clean)}")
print(df_clean.head(3))
```

### 3.4 Unit Conversion — kgf → N and MPa

The force column is in **kgf** (kilogram-force). Convert to Newtons for SI compliance. Stress is already in MPa; strain is in percent — convert to dimensionless ratio for calculations:

```python
KGF_TO_N = 9.80665   # 1 kgf = 9.80665 N

df_clean["force_N"]    = df_clean["force_kgf"] * KGF_TO_N
df_clean["strain_frac"] = df_clean["strain_pct"] / 100.0  # fraction, not percent

print(df_clean[["force_kgf", "force_N", "strain_pct", "strain_frac"]].head())
```

---

## 4. Key Mechanical Properties

### 4.1 Tensile Strength (Ultimate Tensile Strength, UTS)

The **UTS** is the maximum stress recorded during the test. In formula: $sigma_"UTS" = max(sigma)$.

```python
uts_MPa     = df_clean["stress_MPa"].max()
uts_idx     = df_clean["stress_MPa"].idxmax()
uts_strain  = df_clean.loc[uts_idx, "strain_pct"]

print(f"UTS:              {uts_MPa:.3f} MPa")
print(f"  at strain:      {uts_strain:.3f} %")
print(f"  at time:        {df_clean.loc[uts_idx, 'time_s']:.2f} s")
```

### 4.2 Elastic Modulus (Young's Modulus)

Young's modulus $E$ is the slope of the linear (elastic) region of the stress–strain curve:

$E = (Delta sigma) / (Delta epsilon)$

We fit a straight line through the initial linear portion. A reliable approach is to use the first segment where strain is below a small upper bound:

```python
import numpy as np

# Use the region where strain < 0.5 % for the linear fit
LINEAR_STRAIN_LIMIT = 0.5   # percent

mask_linear = df_clean["strain_pct"] <= LINEAR_STRAIN_LIMIT
df_linear   = df_clean[mask_linear]

# np.polyfit(x, y, deg) fits a polynomial of degree `deg`
# deg=1 → straight line: y = slope * x + intercept
coeffs = np.polyfit(df_linear["strain_frac"], df_linear["stress_MPa"], deg=1)
E_MPa  = coeffs[0]   # slope = Young's modulus in MPa

print(f"Young's Modulus E ≈ {E_MPa:.1f} MPa  ({E_MPa/1000:.2f} GPa)")
```

### 4.3 Yield Strength — 0.2 % Offset Method

The **0.2 % offset yield strength** is the stress at which the offset line (same slope as elastic modulus, shifted by 0.2 % strain) crosses the stress–strain curve:

$sigma_y : "where" : sigma = E (epsilon - 0.002)$

```python
OFFSET = 0.002   # 0.2 % expressed as a fraction

# The offset line: stress_offset = E * (strain_frac - OFFSET)
df_clean["stress_offset_line"] = E_MPa * (df_clean["strain_frac"] - OFFSET)

# Find where the actual stress curve crosses the offset line from below
# i.e., where (stress_MPa - offset_line) changes sign from negative to positive
diff = df_clean["stress_MPa"] - df_clean["stress_offset_line"]

# Locate sign change
sign_changes = np.where(np.diff(np.sign(diff)))[0]

if len(sign_changes) > 0:
    i = sign_changes[0]   # first crossing
    yield_stress = df_clean.loc[i, "stress_MPa"]
    yield_strain = df_clean.loc[i, "strain_pct"]
    print(f"0.2% Offset Yield Strength: {yield_stress:.3f} MPa at {yield_strain:.3f} %")
else:
    print("No crossing found — consider adjusting the strain range or offset value.")
```

### 4.4 Elongation at Break

The **elongation at break** is the strain value at the last data point (fracture):

```python
elongation_at_break = df_clean["strain_pct"].iloc[-1]
print(f"Elongation at Break: {elongation_at_break:.3f} %")
```

### 4.5 Collecting Results into a Summary Dictionary

```python
results = {
    "UTS (MPa)":                round(uts_MPa, 3),
    "Strain at UTS (%)":        round(uts_strain, 3),
    "Young's Modulus (MPa)":    round(E_MPa, 1),
    "Young's Modulus (GPa)":    round(E_MPa / 1000, 3),
    "0.2% Yield Strength (MPa)":round(yield_stress, 3),
    "Elongation at Break (%)":  round(elongation_at_break, 3),
}

for key, val in results.items():
    print(f"  {key:<35} {val}")
```

---

## 5. Basic Visualization with matplotlib

### 5.1 matplotlib Fundamentals

```python
import matplotlib.pyplot as plt

# The standard idiom: create a Figure and one or more Axes objects
fig, ax = plt.subplots(figsize=(8, 5))   # figsize = (width_inches, height_inches)

# Plot on the Axes
ax.plot([0, 1, 2], [0, 1, 4], color="steelblue", linewidth=2, label="y = x²")

# Labels and title
ax.set_xlabel("X Axis Label")
ax.set_ylabel("Y Axis Label")
ax.set_title("My First Plot")
ax.legend()           # show the legend
ax.grid(True)         # gridlines

plt.tight_layout()    # prevent label clipping
plt.show()
```

**The `fig, ax = plt.subplots()` idiom** gives you explicit control over the figure and each subplot (Axes). This is preferred over using `plt.plot()` directly when you want fine-grained customisation.

### 5.2 Stress–Strain Curve

```python
import matplotlib.pyplot as plt

fig, ax = plt.subplots(figsize=(9, 5))

# Main curve
ax.plot(df_clean["strain_pct"], df_clean["stress_MPa"],
        color="steelblue", linewidth=1.5, label="Stress–Strain")

# Mark UTS
ax.scatter([uts_strain], [uts_MPa], color="red", zorder=5,
           label=f"UTS = {uts_MPa:.1f} MPa @ {uts_strain:.2f}%")

# Mark yield point
ax.scatter([yield_strain], [yield_stress], color="orange", zorder=5,
           label=f"Yield = {yield_stress:.1f} MPa @ {yield_strain:.2f}%")

# Axis labels, title, legend
ax.set_xlabel("Strain (%)")
ax.set_ylabel("Stress (MPa)")
ax.set_title("Nylon 6 (PA6) — Tensile Stress–Strain Curve\n"
             "BG205 | 5 mm/min | GL=100 mm | 10×4 mm")
ax.legend()
ax.grid(True, linestyle="--", alpha=0.5)

plt.tight_layout()
plt.savefig("stress_strain_curve.png", dpi=150)
plt.show()
```

### 5.3 Force vs. Displacement Curve

```python
fig, ax = plt.subplots(figsize=(9, 5))

ax.plot(df_clean["displacement_mm"], df_clean["force_N"],
        color="teal", linewidth=1.5)

ax.set_xlabel("Displacement (mm)")
ax.set_ylabel("Force (N)")
ax.set_title("Force–Displacement Curve — Nylon 6 BG205")
ax.grid(True, linestyle="--", alpha=0.5)

plt.tight_layout()
plt.savefig("force_displacement_curve.png", dpi=150)
plt.show()
```

---

## 6. Advanced Plots

### 6.1 Multi-Panel Figure with `plt.subplots()`

```python
fig, axes = plt.subplots(1, 2, figsize=(14, 5))
fig.suptitle("Nylon 6 BG205 — Tensile Test Summary", fontsize=13, fontweight="bold")

# --- Left panel: Stress–Strain ---
ax1 = axes[0]
ax1.plot(df_clean["strain_pct"], df_clean["stress_MPa"],
         color="steelblue", linewidth=1.5)
ax1.scatter([uts_strain], [uts_MPa], color="red", zorder=5,
            label=f"UTS {uts_MPa:.1f} MPa")
ax1.scatter([yield_strain], [yield_stress], color="orange", zorder=5,
            label=f"Yield {yield_stress:.1f} MPa")
ax1.set_xlabel("Strain (%)")
ax1.set_ylabel("Stress (MPa)")
ax1.set_title("Stress–Strain")
ax1.legend(fontsize=8)
ax1.grid(True, linestyle="--", alpha=0.4)

# --- Right panel: Force–Displacement ---
ax2 = axes[1]
ax2.plot(df_clean["displacement_mm"], df_clean["force_N"],
         color="teal", linewidth=1.5)
ax2.set_xlabel("Displacement (mm)")
ax2.set_ylabel("Force (N)")
ax2.set_title("Force–Displacement")
ax2.grid(True, linestyle="--", alpha=0.4)

plt.tight_layout()
plt.savefig("tensile_test_summary.png", dpi=150)
plt.show()
```

### 6.2 Highlighting the Elastic Region

```python
fig, ax = plt.subplots(figsize=(9, 5))

# Full curve in light colour
ax.plot(df_clean["strain_pct"], df_clean["stress_MPa"],
        color="lightsteelblue", linewidth=1.2, label="Full curve")

# Elastic region highlighted
df_elastic = df_clean[df_clean["strain_pct"] <= LINEAR_STRAIN_LIMIT]
ax.plot(df_elastic["strain_pct"], df_elastic["stress_MPa"],
        color="steelblue", linewidth=2.5, label=f"Elastic region (≤{LINEAR_STRAIN_LIMIT}%)")

# Overlay the fitted line
strain_fit   = np.linspace(0, LINEAR_STRAIN_LIMIT / 100, 100)
stress_fit   = E_MPa * strain_fit
ax.plot(strain_fit * 100, stress_fit,
        color="red", linestyle="--", linewidth=1.5,
        label=f"Linear fit: E = {E_MPa:.0f} MPa")

ax.set_xlabel("Strain (%)")
ax.set_ylabel("Stress (MPa)")
ax.set_title("Elastic Region and Young's Modulus Fit")
ax.legend()
ax.grid(True, linestyle="--", alpha=0.4)

plt.tight_layout()
plt.savefig("elastic_region.png", dpi=150)
plt.show()
```

### 6.3 Stress vs. Time

```python
fig, ax = plt.subplots(figsize=(9, 4))

ax.plot(df_clean["time_s"], df_clean["stress_MPa"],
        color="darkorange", linewidth=1.2)

ax.axhline(uts_MPa, color="red", linestyle="--", linewidth=1,
           label=f"UTS = {uts_MPa:.1f} MPa")

ax.set_xlabel("Time (s)")
ax.set_ylabel("Stress (MPa)")
ax.set_title("Stress vs. Time")
ax.legend()
ax.grid(True, linestyle="--", alpha=0.4)

plt.tight_layout()
plt.show()
```

---

## 7. Statistical Analysis

### 7.1 Rolling Average (Smoothing Noisy Data)

If the raw data is noisy, a **rolling mean** smooths it without distorting the overall trend:

```python
WINDOW = 20   # number of consecutive rows to average over

df_clean["stress_smooth"] = (
    df_clean["stress_MPa"]
    .rolling(window=WINDOW, center=True, min_periods=1)
    .mean()
)

fig, ax = plt.subplots(figsize=(9, 5))
ax.plot(df_clean["strain_pct"], df_clean["stress_MPa"],
        color="lightsteelblue", linewidth=0.8, label="Raw")
ax.plot(df_clean["strain_pct"], df_clean["stress_smooth"],
        color="steelblue", linewidth=2, label=f"Rolling mean (w={WINDOW})")
ax.set_xlabel("Strain (%)")
ax.set_ylabel("Stress (MPa)")
ax.set_title("Raw vs. Smoothed Stress–Strain Curve")
ax.legend()
ax.grid(True, linestyle="--", alpha=0.4)
plt.tight_layout()
plt.show()
```

### 7.2 Toughness — Area Under the Curve

**Toughness** is the energy absorbed per unit volume up to fracture. It equals the area under the stress–strain curve:

$U_T = integral_0^(epsilon_f) sigma d epsilon quad ["MPa" dot % = "kJ/m"^3 / 10]$

Use the **trapezoidal rule** (`numpy.trapz`) to numerically integrate:

```python
import numpy as np

# trapz(y, x) integrates y with respect to x using the trapezoidal rule
toughness = np.trapz(df_clean["stress_MPa"], df_clean["strain_frac"])

print(f"Toughness (area under σ–ε): {toughness:.3f} MPa")
print(f"  ≈ {toughness * 1e6 / 1000:.1f} kJ/m³")   # MPa = MJ/m³, convert to kJ/m³
```

### 7.3 Descriptive Statistics per Phase

Split the test into elastic and plastic regions and compare statistics:

```python
df_elastic_region  = df_clean[df_clean["strain_pct"] <= LINEAR_STRAIN_LIMIT]
df_plastic_region  = df_clean[df_clean["strain_pct"] > LINEAR_STRAIN_LIMIT]

print("=== Elastic Region ===")
print(df_elastic_region["stress_MPa"].describe())

print("\n=== Plastic Region ===")
print(df_plastic_region["stress_MPa"].describe())
```

### 7.4 Stress Rate (d σ / d t)

The rate of stress change over time can indicate test stability:

```python
# pandas .diff() computes the difference between consecutive rows
df_clean["d_stress_dt"] = (
    df_clean["stress_MPa"].diff() / df_clean["time_s"].diff()
)

fig, ax = plt.subplots(figsize=(9, 4))
ax.plot(df_clean["time_s"], df_clean["d_stress_dt"],
        color="purple", linewidth=0.8, alpha=0.7)
ax.axhline(0, color="black", linewidth=0.8, linestyle="--")
ax.set_xlabel("Time (s)")
ax.set_ylabel("dσ/dt (MPa/s)")
ax.set_title("Stress Rate vs. Time")
ax.grid(True, linestyle="--", alpha=0.4)
plt.tight_layout()
plt.show()
```

---

## 8. Exporting Results

### 8.1 Save the Cleaned DataFrame to a New Excel File

```python
OUTPUT_XLSX = "tensile_results_cleaned.xlsx"

df_clean.to_excel(OUTPUT_XLSX, index=False, sheet_name="Cleaned Data")
print(f"Saved: {OUTPUT_XLSX}")
```

### 8.2 Save a Summary Table

```python
summary_df = pd.DataFrame(list(results.items()), columns=["Property", "Value"])
summary_df.to_excel("tensile_summary.xlsx", index=False)
print(summary_df.to_string(index=False))
```

### 8.3 Export a Plot at High Resolution

```python
fig, ax = plt.subplots(figsize=(9, 5))
ax.plot(df_clean["strain_pct"], df_clean["stress_MPa"],
        color="steelblue", linewidth=1.5)
ax.set_xlabel("Strain (%)")
ax.set_ylabel("Stress (MPa)")
ax.set_title("Nylon 6 BG205 — Stress–Strain Curve")
ax.grid(True, linestyle="--", alpha=0.4)
plt.tight_layout()

# dpi=300 is standard for publications; bbox_inches="tight" prevents clipping
plt.savefig("stress_strain_HQ.png", dpi=300, bbox_inches="tight")
plt.show()
print("Figure saved as stress_strain_HQ.png")
```

### 8.4 Export to CSV

```python
df_clean.to_csv("tensile_results_cleaned.csv", index=False, encoding="utf-8-sig")
# utf-8-sig adds a BOM so Chinese characters display correctly in Excel
print("CSV saved.")
```

---

## 9. Full Pipeline Script

The block below is a self-contained pipeline that runs end-to-end. Copy it into a single code block in Obsidian to execute everything at once.

```python
# ============================================================
# Full Pipeline — Nylon 6 Tensile Test Analysis
# ============================================================
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

# ── 1. Configuration ─────────────────────────────────────────
FILE_PATH           = "湖北彰宸科技-BG205-尼龙6-拉伸测试-5mm每min-标距100mm-宽度10mm-厚度4mm.xlsx"
FORCE_THRESHOLD_KGF = 0.05
LINEAR_STRAIN_LIMIT = 0.5    # % — upper bound of elastic region
KGF_TO_N            = 9.80665
ROLLING_WINDOW      = 20
OFFSET              = 0.002   # 0.2 % offset for yield strength

# ── 2. Load and Rename ────────────────────────────────────────
df_raw = pd.read_excel(FILE_PATH, header=0, engine="openpyxl")
column_map = {
    "No.":        "index",
    "时间( s) ":  "time_s",
    "变形( mm) ": "displacement_mm",
    "力( kgf) ":  "force_kgf",
    "应力( MPa) ":"stress_MPa",
    "应变( %) ":  "strain_pct",
}
df = df_raw.rename(columns=column_map)

# ── 3. Clean ──────────────────────────────────────────────────
df = df.dropna().reset_index(drop=True)
df_clean = df[df["force_kgf"] >= FORCE_THRESHOLD_KGF].copy().reset_index(drop=True)
df_clean["force_N"]      = df_clean["force_kgf"] * KGF_TO_N
df_clean["strain_frac"]  = df_clean["strain_pct"] / 100.0
df_clean["stress_smooth"]= df_clean["stress_MPa"].rolling(ROLLING_WINDOW, center=True, min_periods=1).mean()

# ── 4. Mechanical Properties ──────────────────────────────────
uts_MPa   = df_clean["stress_MPa"].max()
uts_idx   = df_clean["stress_MPa"].idxmax()
uts_strain= df_clean.loc[uts_idx, "strain_pct"]

mask_linear = df_clean["strain_pct"] <= LINEAR_STRAIN_LIMIT
coeffs  = np.polyfit(df_clean.loc[mask_linear, "strain_frac"],
                     df_clean.loc[mask_linear, "stress_MPa"], 1)
E_MPa   = coeffs[0]

df_clean["stress_offset_line"] = E_MPa * (df_clean["strain_frac"] - OFFSET)
diff = df_clean["stress_MPa"] - df_clean["stress_offset_line"]
sign_changes = np.where(np.diff(np.sign(diff)))[0]
if len(sign_changes) > 0:
    i = sign_changes[0]
    yield_stress = df_clean.loc[i, "stress_MPa"]
    yield_strain = df_clean.loc[i, "strain_pct"]
else:
    yield_stress = yield_strain = float("nan")

elongation_at_break = df_clean["strain_pct"].iloc[-1]
toughness = np.trapz(df_clean["stress_MPa"], df_clean["strain_frac"])

results = {
    "UTS (MPa)":                 round(uts_MPa, 3),
    "Strain at UTS (%)":         round(uts_strain, 3),
    "Young's Modulus (MPa)":     round(E_MPa, 1),
    "Young's Modulus (GPa)":     round(E_MPa / 1000, 3),
    "0.2% Yield Strength (MPa)": round(yield_stress, 3),
    "Elongation at Break (%)":   round(elongation_at_break, 3),
    "Toughness (MPa)":           round(toughness, 3),
}

print("=" * 45)
print("  Mechanical Properties Summary")
print("=" * 45)
for k, v in results.items():
    print(f"  {k:<35} {v}")

# ── 5. Plot ───────────────────────────────────────────────────
fig, axes = plt.subplots(1, 2, figsize=(14, 5))
fig.suptitle("Nylon 6 (PA6) BG205 — Tensile Test", fontsize=13, fontweight="bold")

# Stress–Strain
ax1 = axes[0]
ax1.plot(df_clean["strain_pct"], df_clean["stress_MPa"],
         color="lightsteelblue", linewidth=0.8, label="Raw")
ax1.plot(df_clean["strain_pct"], df_clean["stress_smooth"],
         color="steelblue", linewidth=2, label="Smoothed")
ax1.scatter([uts_strain], [uts_MPa], color="red", zorder=5,
            label=f"UTS {uts_MPa:.1f} MPa")
ax1.scatter([yield_strain], [yield_stress], color="orange", zorder=5,
            label=f"Yield {yield_stress:.1f} MPa")
ax1.set_xlabel("Strain (%)")
ax1.set_ylabel("Stress (MPa)")
ax1.set_title("Stress–Strain Curve")
ax1.legend(fontsize=8)
ax1.grid(True, linestyle="--", alpha=0.4)

# Force–Displacement
ax2 = axes[1]
ax2.plot(df_clean["displacement_mm"], df_clean["force_N"],
         color="teal", linewidth=1.5)
ax2.set_xlabel("Displacement (mm)")
ax2.set_ylabel("Force (N)")
ax2.set_title("Force–Displacement Curve")
ax2.grid(True, linestyle="--", alpha=0.4)

plt.tight_layout()
plt.savefig("tensile_test_full_summary.png", dpi=150, bbox_inches="tight")
plt.show()

# ── 6. Export ─────────────────────────────────────────────────
df_clean.to_excel("tensile_results_cleaned.xlsx", index=False)
pd.DataFrame(list(results.items()), columns=["Property", "Value"]).to_excel(
    "tensile_summary.xlsx", index=False)
print("\nFiles saved: tensile_results_cleaned.xlsx, tensile_summary.xlsx")
```

---

## Appendix: Key Concepts Reference

### pandas Cheat Sheet

| Operation | Code |
|---|---|
| Load Excel | `pd.read_excel("file.xlsx", header=0)` |
| View first rows | `df.head(n)` |
| Column names | `df.columns.tolist()` |
| Select column | `df["col"]` or `df.col` |
| Filter rows | `df[df["col"] > value]` |
| Drop NaN | `df.dropna()` |
| Reset index | `df.reset_index(drop=True)` |
| New column | `df["new"] = df["a"] * 2` |
| Rolling mean | `df["col"].rolling(window=20).mean()` |
| Max value | `df["col"].max()` |
| Index of max | `df["col"].idxmax()` |
| Save to Excel | `df.to_excel("out.xlsx", index=False)` |

### numpy Cheat Sheet

| Operation | Code |
|---|---|
| Array from list | `np.array([1, 2, 3])` |
| Linspace | `np.linspace(start, stop, num)` |
| Polynomial fit | `np.polyfit(x, y, deg=1)` |
| Trapezoidal integral | `np.trapz(y, x)` |
| Sign of array | `np.sign(arr)` |
| Find where diff | `np.where(np.diff(signs))[0]` |

### matplotlib Cheat Sheet

| Operation | Code |
|---|---|
| Create figure | `fig, ax = plt.subplots(figsize=(w, h))` |
| Multiple panels | `fig, axes = plt.subplots(1, 2)` |
| Line plot | `ax.plot(x, y, color=, linewidth=, label=)` |
| Scatter | `ax.scatter(x, y, color=, zorder=)` |
| Horizontal line | `ax.axhline(y_val, linestyle=, color=)` |
| X label | `ax.set_xlabel("text")` |
| Y label | `ax.set_ylabel("text")` |
| Title | `ax.set_title("text")` |
| Legend | `ax.legend()` |
| Grid | `ax.grid(True, linestyle="--", alpha=0.5)` |
| Save figure | `plt.savefig("file.png", dpi=300, bbox_inches="tight")` |
| Show | `plt.show()` |
