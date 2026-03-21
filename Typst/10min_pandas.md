# 10 Minutes to pandas

> Source: https://pandas.pydata.org/docs/user_guide/10min.html  
> This is a short introduction to pandas, geared mainly for new users.  
> You can see more complex recipes in the [Cookbook](https://pandas.pydata.org/docs/user_guide/cookbook.html).

---

## Basic data structures in pandas

pandas provides two types of classes for handling data: 

1. **`Series`**: a one-dimensional labeled array holding data of any type (integers, strings, Python objects, etc.)
2. **`DataFrame`**: a two-dimensional data structure that holds data like a two-dimensional array or a table with rows and columns. 

---

## Object creation

See the [Intro to data structures section](https://pandas.pydata.org/docs/user_guide/dsintro.html).

Creating a `Series` by passing a list of values, letting pandas create a default `RangeIndex`: 

```run-python
import numpy as np
import pandas as pd

s = pd.Series([1, 3, 5, np.nan, 6, 8])
print(s)
```


Creating a `DataFrame` by passing a NumPy array with a datetime index using `date_range()` and labeled columns: 


```run-python
import numpy as np
import pandas as pd

dates = pd.date_range("20130101", periods=6)
print(dates)

df = pd.DataFrame(np.random.randn(6, 4), index=dates, columns=list("ABCD"))
print(df)
```






```
numpy.random.randn
random.randn(d0, d1, ..., dn)
Return a sample (or samples) from the “standard normal” distribution.

Note: This is a convenience function for users porting code from Matlab, and wraps standard_normal. That function takes a tuple to specify the size of the output, which is consistent with other NumPy functions like numpy.zeros and numpy.ones.

Note: New code should use the standard_normal method of a Generator instance instead; please see the Quick start.
If positive int_like arguments are provided, randn generates an array of shape (d0, d1, ..., dn), filled with random floats sampled from a univariate “normal” (Gaussian) distribution of mean 0 and variance 1. A single float randomly sampled from the distribution is returned if no argument is provided. 

Parameters: d0, d1, …, dn     int, optional
The dimensions of the returned array, must be non-negative. If no argument is given a single Python float is returned.

Returns:Z  ndarray or float
A (d0, d1, ..., dn)-shaped array of floating-point samples from the standard normal distribution, or a single such float if no parameters were supplied.
```


```run-python

import numpy as np
import pandas as pd
print( np.random.randn() )
print("------------------------------------------------------------------------------")

print( np.random.randn(2) )
print("------------------------------------------------------------------------------")

print( np.random.randn(2,3) )
print("------------------------------------------------------------------------------")
print( np.random.randn(2,3,2) )
print("------------------------------------------------------------------------------")
print( np.random.randn(2,3,2,2) )
```



```

random.Generator.standard_normal(size=None, dtype=np.float64, out=None) 
Draw samples from a standard Normal distribution (mean=0, stdev=1).

Parameters:

size:int or tuple of ints, optional 
Output shape. If the given shape is, e.g., (m, n, k), then m * n * k samples are drawn. Default is None, in which case a single value is returned. 

dtype:dtype, optional
Desired dtype of the result, only float64 and float32 are supported. Byteorder must be native. The default value is np.float64.

out:ndarray, optional
Alternative output array in which to place the result. If size is not None, it must have the same shape as the provided size and must match the type of the output values. 

Returns:
out:float or ndarray 
A floating-point array of shape size of drawn samples, or a single sample if size was not specified. 

```



```

mu + sigma * rng.standard_normal(size=...)
rng.normal(mu, sigma, size=...)
```


```run-python
import numpy as np
s=np.random.default_rng()
a=s.standard_normal()
b=np.random.standard_normal()
c=s.standard_normal(size=(3,4))
d=np.random.standard_normal(20)
e=np.random.normal(loc=1.3, scale=2.3, size=(2,3))
f=np.mean(e)
g=np.mean(e, axis=0)
h=np.mean(e, axis=1)
i=np.random.normal(loc=1.2, scale=2, size=5)
print(a, '\n', '\n', b, '\n', '\n', c, '\n', '\n', d, '\n', '\n', e,'\n', '\n', f, '\n', '\n', g, '\n', '\n', h, '\n', '\n', i)
```



```python
import numpy as np
import matplotlib.pyplot as plt

# Adjustable parameters (change these and re-run)
mu = 0.0
sigma = 1.0

# Generate data
x = np.linspace(mu - 4*sigma, mu + 4*sigma, 1000)
def normal_pdf(x, mu, sigma):
    return (1 / (sigma * np.sqrt(2 * np.pi))) * np.exp( - (x - mu)**2 / (2 * sigma**2) )
pdf = normal_pdf(x, mu, sigma)
samples = np.random.normal(mu, sigma, 500)

fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(9, 4))

# Left: PDF with 3-sigma regions filled in different colors
ax1.plot(x, pdf, 'b-', linewidth=2, label='PDF')
# ±1σ region (~68%)
x_1 = np.linspace(mu - sigma, mu + sigma, 200)
ax1.fill_between(x_1, 0, normal_pdf(x_1, mu, sigma), color='blue', alpha=0.4, label='±1σ (~68%)')
# 1σ to 2σ regions (~27%)
x_2_low = np.linspace(mu - 2*sigma, mu - sigma, 200)
x_2_high = np.linspace(mu + sigma, mu + 2*sigma, 200)
ax1.fill_between(x_2_low, 0, normal_pdf(x_2_low, mu, sigma), color='green', alpha=0.4)
ax1.fill_between(x_2_high, 0, normal_pdf(x_2_high, mu, sigma), color='green', alpha=0.4, label='1σ–2σ (~27%)')
# 2σ to 3σ regions (~4.5%)
x_3_low = np.linspace(mu - 3*sigma, mu - 2*sigma, 200)
x_3_high = np.linspace(mu + 2*sigma, mu + 3*sigma, 200)
ax1.fill_between(x_3_low, 0, normal_pdf(x_3_low, mu, sigma), color='orange', alpha=0.4)
ax1.fill_between(x_3_high, 0, normal_pdf(x_3_high, mu, sigma), color='orange', alpha=0.4, label='2σ–3σ (~4.5%)')
# Outside ±3σ (~0.3%)
x_tail_low = np.linspace(mu - 4*sigma, mu - 3*sigma, 100)
x_tail_high = np.linspace(mu + 3*sigma, mu + 4*sigma, 100)
ax1.fill_between(x_tail_low, 0, normal_pdf(x_tail_low, mu, sigma), color='red', alpha=0.3)
ax1.fill_between(x_tail_high, 0, normal_pdf(x_tail_high, mu, sigma), color='red', alpha=0.3, label='Outside ±3σ (~0.3%)')

ax1.set_title('Normal Distribution PDF - 3-Sigma Rule')
ax1.set_xlabel('x')
ax1.set_ylabel('Probability Density')
ax1.legend(loc='upper right')
# Sigma tick marks
ticks = [mu-3*sigma, mu-2*sigma, mu-sigma, mu, mu+sigma, mu+2*sigma, mu+3*sigma]
ax1.set_xticks(ticks)
ax1.set_xticklabels(['μ−3σ', 'μ−2σ', 'μ−σ', 'μ', 'μ+σ', 'μ+2σ', 'μ+3σ'])

# Right: PDF + histogram + formula
ax2.hist(samples, bins=30, density=True, alpha=0.6, color='gray', label='Histogram (500 samples)')
ax2.plot(x, pdf, 'r-', linewidth=2, label='PDF')
ax2.set_title('PDF with Histogram of 500 Random Samples')
ax2.set_xlabel('x')
ax2.set_ylabel('Density')
ax2.legend()

# Normal distribution formula (English)
formula = r'$f(x)=\frac{1}{\sigma\sqrt{2\pi}}\exp\left(-\frac{(x-\mu)^2}{2\sigma^2}\right)$'
ax2.text(0.02, 0.85, formula, transform=ax2.transAxes, fontsize=9)

plt.tight_layout()
plt.show()
```



In probability theory and statistics, a normal distribution or Gaussian distribution is a type of continuous probability distribution for a real-valued random variable. The general form of its probability density function is $f (x)= frac(1, sqrt(2 pi sigma^(2)))exp (- frac((x - mu)^(2), 2 sigma^(2))) thin$ 

The parameter ⁠$mu$ is the mean or expectation of the distribution (and also its median and mode), while the parameter  $sigma^2$ 
 is the variance. The standard deviation of the distribution is the positive value ⁠$sigma$. A random variable with a Gaussian distribution is said to be normally distributed and is called a normal deviate.  

Normal distributions are important in statistics and are often used in the natural and social sciences to represent real-valued random variables whose distributions are not known. Their importance is partly due to the central limit theorem.

Creating a `DataFrame` by passing a dictionary of objects where the keys are the column labels and the values are the column values: 



```python
import numpy as np
import pandas as pd

df2 = pd.DataFrame(
    {
        "A": 1.0,
        "B": pd.Timestamp("20130102"),
        "C": pd.Series(1, index=list(range(4)), dtype="float32"),
        "D": np.array([3] * 4, dtype="int32"),
        "E": pd.Categorical(["test", "train", "test", "train"]),
        "F": "foo",
    }
)
print(df2)
```

Expected output:
```
     A          B    C  D      E    F
0  1.0 2013-01-02  1.0  3   test  foo
1  1.0 2013-01-02  1.0  3  train  foo
2  1.0 2013-01-02  1.0  3   test  foo
3  1.0 2013-01-02  1.0  3  train  foo
```

The columns of the resulting `DataFrame` have different [dtypes](https://pandas.pydata.org/docs/user_guide/basics.html#basics-dtypes):

```python
import numpy as np
import pandas as pd

df2 = pd.DataFrame(
    {
        "A": 1.0,
        "B": pd.Timestamp("20130102"),
        "C": pd.Series(1, index=list(range(4)), dtype="float32"),
        "D": np.array([3] * 4, dtype="int32"),
        "E": pd.Categorical(["test", "train", "test", "train"]),
        "F": "foo",
    }
)
print(df2.dtypes)
```

Expected output:
```
A           float64
B    datetime64[us]
C           float32
D             int32
E          category
F               str
dtype: object
```

---

## Viewing data

See the [Essential basic functionality section](https://pandas.pydata.org/docs/user_guide/basics.html).

Use `DataFrame.head()` and `DataFrame.tail()` to view the top and bottom rows of the frame respectively:

```python
import numpy as np
import pandas as pd

dates = pd.date_range("20130101", periods=6)
df = pd.DataFrame(np.random.randn(6, 4), index=dates, columns=list("ABCD"))

print(df.head())
print("---")
print(df.tail(3))
```

Display the `DataFrame.index` or `DataFrame.columns`:

```run-python
import numpy as np
import pandas as pd

dates = pd.date_range("20130101", periods=6)
df = pd.DataFrame(np.random.randn(6, 4), index=dates, columns=list("ABCD"))

print(df.index)
print(df.columns)
```

Return a NumPy representation of the underlying data with `DataFrame.to_numpy()` without the index or column labels:

```python
import numpy as np
import pandas as pd

dates = pd.date_range("20130101", periods=6)
df = pd.DataFrame(np.random.randn(6, 4), index=dates, columns=list("ABCD"))

print(df.to_numpy())
```

> **Note:** NumPy arrays have one dtype for the entire array while pandas DataFrames have one dtype per column. When you call `DataFrame.to_numpy()`, pandas will find the NumPy dtype that can hold *all* of the dtypes in the DataFrame. If the common data type is `object`, `DataFrame.to_numpy()` will require copying data.

```run-python
import numpy as np
import pandas as pd

df2 = pd.DataFrame(
    {
        "A": 1.0,
        "B": pd.Timestamp("20130102"),
        "C": pd.Series(1, index=list(range(4)), dtype="float32"),
        "D": np.array([3] * 4, dtype="int32"),
        "E": pd.Categorical(["test", "train", "test", "train"]),
        "F": "foo",
    }
)
print(df2.dtypes)
print(df2.to_numpy())
```

`describe()` shows a quick statistic summary of your data:

```python
import numpy as np
import pandas as pd

dates = pd.date_range("20130101", periods=6)
df = pd.DataFrame(np.random.randn(6, 4), index=dates, columns=list("ABCD"))

print(df.describe())
```

Transposing your data:

```python
import numpy as np
import pandas as pd

dates = pd.date_range("20130101", periods=6)
df = pd.DataFrame(np.random.randn(6, 4), index=dates, columns=list("ABCD"))

print(df.T)
```

`DataFrame.sort_index()` sorts by an axis:

```python
import numpy as np
import pandas as pd

dates = pd.date_range("20130101", periods=6)
df = pd.DataFrame(np.random.randn(6, 4), index=dates, columns=list("ABCD"))

print(df.sort_index(axis=1, ascending=False))
```

`DataFrame.sort_values()` sorts by values:

```python
import numpy as np
import pandas as pd

dates = pd.date_range("20130101", periods=6)
df = pd.DataFrame(np.random.randn(6, 4), index=dates, columns=list("ABCD"))

print(df.sort_values(by="B"))
```

---

## Selection

> **Note:** While standard Python / NumPy expressions for selecting and setting are intuitive and come in handy for interactive work, for production code, we recommend the optimized pandas data access methods: `DataFrame.at()`, `DataFrame.iat()`, `DataFrame.loc()` and `DataFrame.iloc()`.

See the indexing documentation [Indexing and Selecting Data](https://pandas.pydata.org/docs/user_guide/indexing.html) and [MultiIndex / Advanced Indexing](https://pandas.pydata.org/docs/user_guide/advanced.html).

### Getitem (`[]`)

For a `DataFrame`, passing a single label selects a column and yields a `Series`:

```python
import numpy as np
import pandas as pd

dates = pd.date_range("20130101", periods=6)
df = pd.DataFrame(np.random.randn(6, 4), index=dates, columns=list("ABCD"))

print(df["A"])
```

If the label only contains letters, numbers, and underscores, you can alternatively use the column name attribute:

```python
import numpy as np
import pandas as pd

dates = pd.date_range("20130101", periods=6)
df = pd.DataFrame(np.random.randn(6, 4), index=dates, columns=list("ABCD"))

print(df.A)
```

Passing a list of column labels selects multiple columns, which can be useful for getting a subset/rearranging:

```python
import numpy as np
import pandas as pd

dates = pd.date_range("20130101", periods=6)
df = pd.DataFrame(np.random.randn(6, 4), index=dates, columns=list("ABCD"))

print(df[["B", "A"]])
```

For a `DataFrame`, passing a slice `:` selects matching rows:

```python
import numpy as np
import pandas as pd

dates = pd.date_range("20130101", periods=6)
df = pd.DataFrame(np.random.randn(6, 4), index=dates, columns=list("ABCD"))

print(df[0:3])
print("---")
print(df["20130102":"20130104"])
```

### Selection by label

See more in [Selection by Label](https://pandas.pydata.org/docs/user_guide/indexing.html#indexing-label) using `DataFrame.loc()` or `DataFrame.at()`.

Selecting a row matching a label:

```python
import numpy as np
import pandas as pd

dates = pd.date_range("20130101", periods=6)
df = pd.DataFrame(np.random.randn(6, 4), index=dates, columns=list("ABCD"))

print(df.loc[dates[0]])
```

Selecting all rows (`:`) with select column labels:

```python
import numpy as np
import pandas as pd

dates = pd.date_range("20130101", periods=6)
df = pd.DataFrame(np.random.randn(6, 4), index=dates, columns=list("ABCD"))

print(df.loc[:, ["A", "B"]])
```

For label slicing, both endpoints are *included*:

```python
import numpy as np
import pandas as pd

dates = pd.date_range("20130101", periods=6)
df = pd.DataFrame(np.random.randn(6, 4), index=dates, columns=list("ABCD"))

print(df.loc["20130102":"20130104", ["A", "B"]])
```

Selecting a single row and column label returns a scalar:

```python
import numpy as np
import pandas as pd

dates = pd.date_range("20130101", periods=6)
df = pd.DataFrame(np.random.randn(6, 4), index=dates, columns=list("ABCD"))

print(df.loc[dates[0], "A"])
```

For getting fast access to a scalar (equivalent to the prior method):

```python
import numpy as np
import pandas as pd

dates = pd.date_range("20130101", periods=6)
df = pd.DataFrame(np.random.randn(6, 4), index=dates, columns=list("ABCD"))

print(df.at[dates[0], "A"])
```

### Selection by position

See more in [Selection by Position](https://pandas.pydata.org/docs/user_guide/indexing.html#indexing-integer) using `DataFrame.iloc()` or `DataFrame.iat()`.

Select via the position of the passed integers:

```python
import numpy as np
import pandas as pd

dates = pd.date_range("20130101", periods=6)
df = pd.DataFrame(np.random.randn(6, 4), index=dates, columns=list("ABCD"))

print(df.iloc[3])
```

Integer slices act similar to NumPy/Python:

```python
import numpy as np
import pandas as pd

dates = pd.date_range("20130101", periods=6)
df = pd.DataFrame(np.random.randn(6, 4), index=dates, columns=list("ABCD"))

print(df.iloc[3:5, 0:2])
```

Lists of integer position locations:

```python
import numpy as np
import pandas as pd

dates = pd.date_range("20130101", periods=6)
df = pd.DataFrame(np.random.randn(6, 4), index=dates, columns=list("ABCD"))

print(df.iloc[[1, 2, 4], [0, 2]])
```

For slicing rows explicitly:

```python
import numpy as np
import pandas as pd

dates = pd.date_range("20130101", periods=6)
df = pd.DataFrame(np.random.randn(6, 4), index=dates, columns=list("ABCD"))

print(df.iloc[1:3, :])
```

For slicing columns explicitly:

```python
import numpy as np
import pandas as pd

dates = pd.date_range("20130101", periods=6)
df = pd.DataFrame(np.random.randn(6, 4), index=dates, columns=list("ABCD"))

print(df.iloc[:, 1:3])
```

For getting a value explicitly:

```python
import numpy as np
import pandas as pd

dates = pd.date_range("20130101", periods=6)
df = pd.DataFrame(np.random.randn(6, 4), index=dates, columns=list("ABCD"))

print(df.iloc[1, 1])
```

For getting fast access to a scalar (equivalent to the prior method):

```python
import numpy as np
import pandas as pd

dates = pd.date_range("20130101", periods=6)
df = pd.DataFrame(np.random.randn(6, 4), index=dates, columns=list("ABCD"))

print(df.iat[1, 1])
```

### Boolean indexing

Select rows where `df.A` is greater than `0`:

```python
import numpy as np
import pandas as pd

dates = pd.date_range("20130101", periods=6)
df = pd.DataFrame(np.random.randn(6, 4), index=dates, columns=list("ABCD"))

print(df[df["A"] > 0])
```

Selecting values from a `DataFrame` where a boolean condition is met:

```python
import numpy as np
import pandas as pd

dates = pd.date_range("20130101", periods=6)
df = pd.DataFrame(np.random.randn(6, 4), index=dates, columns=list("ABCD"))

print(df[df > 0])
```

Using `isin()` method for filtering:

```python
import numpy as np
import pandas as pd

dates = pd.date_range("20130101", periods=6)
df = pd.DataFrame(np.random.randn(6, 4), index=dates, columns=list("ABCD"))

df2 = df.copy()
df2["E"] = ["one", "one", "two", "three", "four", "three"]
print(df2)
print("---")
print(df2[df2["E"].isin(["two", "four"])])
```

### Setting

Setting a new column automatically aligns the data by the indexes:

```python
import numpy as np
import pandas as pd

dates = pd.date_range("20130101", periods=6)
df = pd.DataFrame(np.random.randn(6, 4), index=dates, columns=list("ABCD"))

s1 = pd.Series([1, 2, 3, 4, 5, 6], index=pd.date_range("20130102", periods=6))
df["F"] = s1
print(df)
```

Setting values by label:

```python
import numpy as np
import pandas as pd

dates = pd.date_range("20130101", periods=6)
df = pd.DataFrame(np.random.randn(6, 4), index=dates, columns=list("ABCD"))

df.at[dates[0], "A"] = 0
print(df)
```

Setting values by position:

```python
import numpy as np
import pandas as pd

dates = pd.date_range("20130101", periods=6)
df = pd.DataFrame(np.random.randn(6, 4), index=dates, columns=list("ABCD"))

df.iat[0, 1] = 0
print(df)
```

Setting by assigning with a NumPy array:

```python
import numpy as np
import pandas as pd

dates = pd.date_range("20130101", periods=6)
df = pd.DataFrame(np.random.randn(6, 4), index=dates, columns=list("ABCD"))

df.loc[:, "D"] = np.array([5] * len(df))
print(df)
```

A `where` operation with setting (combining several setting operations):

```python
import numpy as np
import pandas as pd

dates = pd.date_range("20130101", periods=6)
df = pd.DataFrame(np.random.randn(6, 4), index=dates, columns=list("ABCD"))

# Apply multiple setting operations first
s1 = pd.Series([1, 2, 3, 4, 5, 6], index=pd.date_range("20130102", periods=6))
df["F"] = s1
df.at[dates[0], "A"] = 0
df.iat[0, 1] = 0
df.loc[:, "D"] = np.array([5] * len(df))

print("df after all settings:")
print(df)

# where operation: set positive values to their negatives
df2 = df.copy()
df2[df2 > 0] = -df2
print("\ndf2 after where operation:")
print(df2)
```

---

## Missing data

For NumPy data types, `np.nan` represents missing data. It is by default not included in computations. See the [Missing Data section](https://pandas.pydata.org/docs/user_guide/missing_data.html).

Reindexing allows you to change/add/delete the index on a specified axis. This returns a copy of the data:

```python
import numpy as np
import pandas as pd

dates = pd.date_range("20130101", periods=6)
df = pd.DataFrame(np.random.randn(6, 4), index=dates, columns=list("ABCD"))

# Apply setting operations to match original state
s1 = pd.Series([1, 2, 3, 4, 5, 6], index=pd.date_range("20130102", periods=6))
df["F"] = s1
df.at[dates[0], "A"] = 0
df.iat[0, 1] = 0
df.loc[:, "D"] = np.array([5] * len(df))

df1 = df.reindex(index=dates[0:4], columns=list(df.columns) + ["E"])
df1.loc[dates[0]: dates[1], "E"] = 1
print(df1)
```

`DataFrame.dropna()` drops any rows that have missing data:

```python
import numpy as np
import pandas as pd

dates = pd.date_range("20130101", periods=6)
df = pd.DataFrame(np.random.randn(6, 4), index=dates, columns=list("ABCD"))

s1 = pd.Series([1, 2, 3, 4, 5, 6], index=pd.date_range("20130102", periods=6))
df["F"] = s1
df.at[dates[0], "A"] = 0
df.iat[0, 1] = 0
df.loc[:, "D"] = np.array([5] * len(df))

df1 = df.reindex(index=dates[0:4], columns=list(df.columns) + ["E"])
df1.loc[dates[0]: dates[1], "E"] = 1

print(df1.dropna(how="any"))
```

`DataFrame.fillna()` fills missing data:

```python
import numpy as np
import pandas as pd

dates = pd.date_range("20130101", periods=6)
df = pd.DataFrame(np.random.randn(6, 4), index=dates, columns=list("ABCD"))

s1 = pd.Series([1, 2, 3, 4, 5, 6], index=pd.date_range("20130102", periods=6))
df["F"] = s1
df.at[dates[0], "A"] = 0
df.iat[0, 1] = 0
df.loc[:, "D"] = np.array([5] * len(df))

df1 = df.reindex(index=dates[0:4], columns=list(df.columns) + ["E"])
df1.loc[dates[0]: dates[1], "E"] = 1

print(df1.fillna(value=5))
```

`isna()` gets the boolean mask where values are `nan`:

```python
import numpy as np
import pandas as pd

dates = pd.date_range("20130101", periods=6)
df = pd.DataFrame(np.random.randn(6, 4), index=dates, columns=list("ABCD"))

s1 = pd.Series([1, 2, 3, 4, 5, 6], index=pd.date_range("20130102", periods=6))
df["F"] = s1
df.at[dates[0], "A"] = 0
df.iat[0, 1] = 0
df.loc[:, "D"] = np.array([5] * len(df))

df1 = df.reindex(index=dates[0:4], columns=list(df.columns) + ["E"])
df1.loc[dates[0]: dates[1], "E"] = 1

print(pd.isna(df1))
```

---

## Operations

See the [Basic section on Binary Ops](https://pandas.pydata.org/docs/user_guide/basics.html#basics-binop).

### Stats

Operations in general *exclude* missing data.

Calculate the mean value for each column:

```python
import numpy as np
import pandas as pd

dates = pd.date_range("20130101", periods=6)
df = pd.DataFrame(np.random.randn(6, 4), index=dates, columns=list("ABCD"))

s1 = pd.Series([1, 2, 3, 4, 5, 6], index=pd.date_range("20130102", periods=6))
df["F"] = s1
df.at[dates[0], "A"] = 0
df.iat[0, 1] = 0
df.loc[:, "D"] = np.array([5] * len(df))

print(df.mean())
```

Calculate the mean value for each row:

```python
import numpy as np
import pandas as pd

dates = pd.date_range("20130101", periods=6)
df = pd.DataFrame(np.random.randn(6, 4), index=dates, columns=list("ABCD"))

s1 = pd.Series([1, 2, 3, 4, 5, 6], index=pd.date_range("20130102", periods=6))
df["F"] = s1
df.at[dates[0], "A"] = 0
df.iat[0, 1] = 0
df.loc[:, "D"] = np.array([5] * len(df))

print(df.mean(axis=1))
```

Operating with another `Series` or `DataFrame` with a different index or column will align the result with the union of the index or column labels. In addition, pandas automatically broadcasts along the specified dimension and will fill unaligned labels with `np.nan`:

```python
import numpy as np
import pandas as pd

dates = pd.date_range("20130101", periods=6)
df = pd.DataFrame(np.random.randn(6, 4), index=dates, columns=list("ABCD"))

s1 = pd.Series([1, 2, 3, 4, 5, 6], index=pd.date_range("20130102", periods=6))
df["F"] = s1
df.at[dates[0], "A"] = 0
df.iat[0, 1] = 0
df.loc[:, "D"] = np.array([5] * len(df))

s = pd.Series([1, 3, 5, np.nan, 6, 8], index=dates).shift(2)
print(s)
print("---")
print(df.sub(s, axis="index"))
```

### User defined functions

`DataFrame.agg()` and `DataFrame.transform()` apply a user defined function that reduces or broadcasts its result respectively:

```python
import numpy as np
import pandas as pd

dates = pd.date_range("20130101", periods=6)
df = pd.DataFrame(np.random.randn(6, 4), index=dates, columns=list("ABCD"))

s1 = pd.Series([1, 2, 3, 4, 5, 6], index=pd.date_range("20130102", periods=6))
df["F"] = s1
df.at[dates[0], "A"] = 0
df.iat[0, 1] = 0
df.loc[:, "D"] = np.array([5] * len(df))

print(df.agg(lambda x: np.mean(x) * 5.6))
print("---")
print(df.transform(lambda x: x * 101.2))
```

### Value Counts

See more at [Histogramming and Discretization](https://pandas.pydata.org/docs/user_guide/basics.html#basics-discretization).

```python
import numpy as np
import pandas as pd

s = pd.Series(np.random.randint(0, 7, size=10))
print(s)
print("---")
print(s.value_counts())
```

### String Methods

`Series` is equipped with a set of string processing methods in the `str` attribute that make it easy to operate on each element of the array. See more at [Vectorized String Methods](https://pandas.pydata.org/docs/user_guide/text.html#text-string-methods).

```python
import numpy as np
import pandas as pd

s = pd.Series(["A", "B", "C", "Aaba", "Baca", np.nan, "CABA", "dog", "cat"])
print(s.str.lower())
```

---

## Merge

### Concat

pandas provides various facilities for easily combining together `Series` and `DataFrame` objects with various kinds of set logic for the indexes and relational algebra functionality in the case of join / merge-type operations.

See the [Merging section](https://pandas.pydata.org/docs/user_guide/merging.html).

Concatenating pandas objects together row-wise with `concat()`:

```python
import numpy as np
import pandas as pd

df = pd.DataFrame(np.random.randn(10, 4))
print(df)

# break it into pieces
pieces = [df[:3], df[3:7], df[7:]]
print("---")
print(pd.concat(pieces))
```

> **Note:** Adding a column to a `DataFrame` is relatively fast. However, adding a row requires a copy, and may be expensive. We recommend passing a pre-built list of records to the `DataFrame` constructor instead of building a `DataFrame` by iteratively appending records to it.

### Join

`merge()` enables SQL style join types along specific columns. See the [Database style joining](https://pandas.pydata.org/docs/user_guide/merging.html#merging-join) section.

```python
import pandas as pd

left = pd.DataFrame({"key": ["foo", "foo"], "lval": [1, 2]})
right = pd.DataFrame({"key": ["foo", "foo"], "rval": [4, 5]})

print("left:")
print(left)
print("\nright:")
print(right)
print("\nmerged:")
print(pd.merge(left, right, on="key"))
```

`merge()` on unique keys:

```python
import pandas as pd

left = pd.DataFrame({"key": ["foo", "bar"], "lval": [1, 2]})
right = pd.DataFrame({"key": ["foo", "bar"], "rval": [4, 5]})

print("left:")
print(left)
print("\nright:")
print(right)
print("\nmerged:")
print(pd.merge(left, right, on="key"))
```

---

## Grouping

By "group by" we are referring to a process involving one or more of the following steps:

- **Splitting** the data into groups based on some criteria
- **Applying** a function to each group independently
- **Combining** the results into a data structure

See the [Grouping section](https://pandas.pydata.org/docs/user_guide/groupby.html).

```python
import numpy as np
import pandas as pd

df = pd.DataFrame(
    {
        "A": ["foo", "bar", "foo", "bar", "foo", "bar", "foo", "foo"],
        "B": ["one", "one", "two", "three", "two", "two", "one", "three"],
        "C": np.random.randn(8),
        "D": np.random.randn(8),
    }
)
print(df)
```

Grouping by a column label, selecting column labels, and then applying the `DataFrameGroupBy.sum()` function to the resulting groups:

```python
import numpy as np
import pandas as pd

df = pd.DataFrame(
    {
        "A": ["foo", "bar", "foo", "bar", "foo", "bar", "foo", "foo"],
        "B": ["one", "one", "two", "three", "two", "two", "one", "three"],
        "C": np.random.randn(8),
        "D": np.random.randn(8),
    }
)

print(df.groupby("A")[["C", "D"]].sum())
```

Grouping by multiple columns label forms `MultiIndex`:

```python
import numpy as np
import pandas as pd

df = pd.DataFrame(
    {
        "A": ["foo", "bar", "foo", "bar", "foo", "bar", "foo", "foo"],
        "B": ["one", "one", "two", "three", "two", "two", "one", "three"],
        "C": np.random.randn(8),
        "D": np.random.randn(8),
    }
)

print(df.groupby(["A", "B"]).sum())
```

---

## Reshaping

See the sections on [Hierarchical Indexing](https://pandas.pydata.org/docs/user_guide/advanced.html#advanced-hierarchical) and [Reshaping](https://pandas.pydata.org/docs/user_guide/reshaping.html).

### Stack

```python
import numpy as np
import pandas as pd

arrays = [
    ["bar", "bar", "baz", "baz", "foo", "foo", "qux", "qux"],
    ["one", "two", "one", "two", "one", "two", "one", "two"],
]

index = pd.MultiIndex.from_arrays(arrays, names=["first", "second"])
df = pd.DataFrame(np.random.randn(8, 2), index=index, columns=["A", "B"])
df2 = df[:4]
print(df2)
```

The `stack()` method "compresses" a level in the DataFrame's columns:

```python
import numpy as np
import pandas as pd

arrays = [
    ["bar", "bar", "baz", "baz", "foo", "foo", "qux", "qux"],
    ["one", "two", "one", "two", "one", "two", "one", "two"],
]

index = pd.MultiIndex.from_arrays(arrays, names=["first", "second"])
df = pd.DataFrame(np.random.randn(8, 2), index=index, columns=["A", "B"])
df2 = df[:4]

stacked = df2.stack()
print(stacked)
```

With a "stacked" DataFrame or Series (having a `MultiIndex` as the `index`), the inverse operation of `stack()` is `unstack()`, which by default unstacks the **last level**:

```python
import numpy as np
import pandas as pd

arrays = [
    ["bar", "bar", "baz", "baz", "foo", "foo", "qux", "qux"],
    ["one", "two", "one", "two", "one", "two", "one", "two"],
]

index = pd.MultiIndex.from_arrays(arrays, names=["first", "second"])
df = pd.DataFrame(np.random.randn(8, 2), index=index, columns=["A", "B"])
df2 = df[:4]
stacked = df2.stack()

print("unstack() — last level:")
print(stacked.unstack())
print("\nunstack(1):")
print(stacked.unstack(1))
print("\nunstack(0):")
print(stacked.unstack(0))
```

### Pivot tables

See the section on [Pivot Tables](https://pandas.pydata.org/docs/user_guide/reshaping.html#reshaping-pivot).

```python
import numpy as np
import pandas as pd

df = pd.DataFrame(
    {
        "A": ["one", "one", "two", "three"] * 3,
        "B": ["A", "B", "C"] * 4,
        "C": ["foo", "foo", "foo", "bar", "bar", "bar"] * 2,
        "D": np.random.randn(12),
        "E": np.random.randn(12),
    }
)
print(df)
```

`pivot_table()` pivots a `DataFrame` specifying the `values`, `index` and `columns`:

```python
import numpy as np
import pandas as pd

df = pd.DataFrame(
    {
        "A": ["one", "one", "two", "three"] * 3,
        "B": ["A", "B", "C"] * 4,
        "C": ["foo", "foo", "foo", "bar", "bar", "bar"] * 2,
        "D": np.random.randn(12),
        "E": np.random.randn(12),
    }
)

print(pd.pivot_table(df, values="D", index=["A", "B"], columns=["C"]))
```

---

## Time series

pandas has simple, powerful, and efficient functionality for performing resampling operations during frequency conversion (e.g., converting secondly data into 5-minutely data). This is extremely common in, but not limited to, financial applications. See the [Time Series section](https://pandas.pydata.org/docs/user_guide/timeseries.html).

```python
import numpy as np
import pandas as pd

rng = pd.date_range("1/1/2012", periods=100, freq="s")
ts = pd.Series(np.random.randint(0, 500, len(rng)), index=rng)
print(ts.resample("5Min").sum())
```

`Series.tz_localize()` localizes a time series to a time zone:

```python
import numpy as np
import pandas as pd

rng = pd.date_range("3/6/2012 00:00", periods=5, freq="D")
ts = pd.Series(np.random.randn(len(rng)), rng)
print(ts)

ts_utc = ts.tz_localize("UTC")
print(ts_utc)
```

`Series.tz_convert()` converts a timezone-aware time series to another time zone:

```python
import numpy as np
import pandas as pd

rng = pd.date_range("3/6/2012 00:00", periods=5, freq="D")
ts = pd.Series(np.random.randn(len(rng)), rng)
ts_utc = ts.tz_localize("UTC")

print(ts_utc.tz_convert("US/Eastern"))
```

Adding a non-fixed duration (`BusinessDay`) to a time series:

```python
import numpy as np
import pandas as pd

rng = pd.date_range("3/6/2012 00:00", periods=5, freq="D")
print(rng)
print(rng + pd.offsets.BusinessDay(5))
```

---

## Categoricals

pandas can include categorical data in a `DataFrame`. For full docs, see the [categorical introduction](https://pandas.pydata.org/docs/user_guide/categorical.html) and the [API documentation](https://pandas.pydata.org/docs/reference/arrays.html#api-arrays-categorical).

```python
import pandas as pd

df = pd.DataFrame(
    {"id": [1, 2, 3, 4, 5, 6], "raw_grade": ["a", "b", "b", "a", "a", "e"]}
)
print(df)
```

Converting the raw grades to a categorical data type:

```python
import pandas as pd

df = pd.DataFrame(
    {"id": [1, 2, 3, 4, 5, 6], "raw_grade": ["a", "b", "b", "a", "a", "e"]}
)

df["grade"] = df["raw_grade"].astype("category")
print(df["grade"])
```

Rename the categories to more meaningful names:

```python
import pandas as pd

df = pd.DataFrame(
    {"id": [1, 2, 3, 4, 5, 6], "raw_grade": ["a", "b", "b", "a", "a", "e"]}
)
df["grade"] = df["raw_grade"].astype("category")

new_categories = ["very good", "good", "very bad"]
df["grade"] = df["grade"].cat.rename_categories(new_categories)
print(df["grade"])
```

Reorder the categories and simultaneously add the missing categories (methods under `Series.cat()` return a new `Series` by default):

```python
import pandas as pd

df = pd.DataFrame(
    {"id": [1, 2, 3, 4, 5, 6], "raw_grade": ["a", "b", "b", "a", "a", "e"]}
)
df["grade"] = df["raw_grade"].astype("category")
new_categories = ["very good", "good", "very bad"]
df["grade"] = df["grade"].cat.rename_categories(new_categories)

df["grade"] = df["grade"].cat.set_categories(
    ["very bad", "bad", "medium", "good", "very good"]
)
print(df["grade"])
```

Sorting is per order in the categories, not lexical order:

```python
import pandas as pd

df = pd.DataFrame(
    {"id": [1, 2, 3, 4, 5, 6], "raw_grade": ["a", "b", "b", "a", "a", "e"]}
)
df["grade"] = df["raw_grade"].astype("category")
df["grade"] = df["grade"].cat.rename_categories(["very good", "good", "very bad"])
df["grade"] = df["grade"].cat.set_categories(
    ["very bad", "bad", "medium", "good", "very good"]
)

print(df.sort_values(by="grade"))
```

Grouping by a categorical column with `observed=False` also shows empty categories:

```python
import pandas as pd

df = pd.DataFrame(
    {"id": [1, 2, 3, 4, 5, 6], "raw_grade": ["a", "b", "b", "a", "a", "e"]}
)
df["grade"] = df["raw_grade"].astype("category")
df["grade"] = df["grade"].cat.rename_categories(["very good", "good", "very bad"])
df["grade"] = df["grade"].cat.set_categories(
    ["very bad", "bad", "medium", "good", "very good"]
)

print(df.groupby("grade", observed=False).size())
```

---

## Plotting

See the [Plotting](https://pandas.pydata.org/docs/user_guide/visualization.html) docs.

We use the standard convention for referencing the matplotlib API:

```run-python
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

ts = pd.Series(np.random.randn(1000), index=pd.date_range("1/1/2000", periods=1000))
ts = ts.cumsum()
ts.plot()
plt.show()
```

> **Note:** When using Jupyter, the plot will appear inline using `plot()`. Otherwise use `matplotlib.pyplot.show()` to show it or `matplotlib.pyplot.savefig()` to write it to a file.

`plot()` plots all columns:

```run-python
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

ts = pd.Series(np.random.randn(1000), index=pd.date_range("1/1/2000", periods=1000))
ts = ts.cumsum()

df = pd.DataFrame(
    np.random.randn(1000, 4), index=ts.index, columns=["A", "B", "C", "D"]
)
df = df.cumsum()

plt.figure()
df.plot()
plt.legend(loc='best')
plt.show()
```

---

## Importing and exporting data

See the [IO Tools](https://pandas.pydata.org/docs/user_guide/io.html) section.

### CSV

Writing to a csv file using `DataFrame.to_csv()`:

```python
import numpy as np
import pandas as pd

df = pd.DataFrame(np.random.randint(0, 5, (10, 5)))
df.to_csv("foo.csv")
print("Written to foo.csv")
```

Reading from a csv file using `read_csv()`:

```python
import pandas as pd

print(pd.read_csv("foo.csv"))
```

### Parquet

Writing to a Parquet file:

```python
import numpy as np
import pandas as pd

df = pd.DataFrame(np.random.randint(0, 5, (10, 5)))
df.to_parquet("foo.parquet")
print("Written to foo.parquet")
```

Reading from a Parquet file using `read_parquet()`:

```python
import pandas as pd

print(pd.read_parquet("foo.parquet"))
```

### Excel

Writing to an excel file using `DataFrame.to_excel()`:

```python
import numpy as np
import pandas as pd

df = pd.DataFrame(np.random.randint(0, 5, (10, 5)))
df.to_excel("foo.xlsx", sheet_name="Sheet1")
print("Written to foo.xlsx")
```

Reading from an excel file using `read_excel()`:

```python
import pandas as pd

print(pd.read_excel("foo.xlsx", "Sheet1", index_col=None, na_values=["NA"]))
```

---

## Gotchas

If you are attempting to perform a boolean operation on a `Series` or `DataFrame` you might see an exception like:

```python
import pandas as pd

# This will raise a ValueError — intentional demo
try:
    if pd.Series([False, True, False]):
        print("I was true")
except ValueError as e:
    print(f"ValueError: {e}")
```

Expected output:
```
ValueError: The truth value of a Series is ambiguous. Use a.empty, a.bool(), a.item(), a.any() or a.all().
```

See [Comparisons](https://pandas.pydata.org/docs/user_guide/basics.html#basics-compare) and [Gotchas](https://pandas.pydata.org/docs/user_guide/gotchas.html) for an explanation and what to do.
