


### 📝 Introduction to float32 and float64

`float32` and `float64` are two fundamental data types used in computing to represent real numbers (numbers with fractional parts). They adhere to the IEEE 754 standard, which defines how these numbers are encoded in binary. The names `float32` and `float64` refer to the number of bits (32 and 64, respectively) they use for storage.

The key difference lies in their precision (the number of significant digits they can accurately represent) and their range (the magnitude of the numbers they can store). `float64`, also known as double precision, offers significantly higher precision and a much larger range than `float32`, or single precision. 

---

### 💾 Storage in Computer Memory

Both types store a number using three components, similar to scientific notation ($N = (-1)^S times M times 2^E$):

1.  Sign bit (S): Determines if the number is positive (0) or negative (1).
2.  Exponent (E): Represents the power of 2 by which the significand is multiplied. It's stored with a "bias" to allow for both positive and negative exponents. 
3.  Significand/Mantissa (M): Holds the significant digits of the number. In a normalized format, there is an implicit leading '1' that is not stored but is assumed, which adds to the precision. 


#### Example: Storing the Number 5.75

Let's see how the decimal number 5.75 is stored in both formats.

1.  Convert to Binary:
    *   Integer part (5) is `101` in binary.
    *   Fractional part (0.75) is `0.11` in binary ($0.75 = 1/2 + 1/4$).
    *   So, 5.75 in binary is `101.11`.

2.  Normalize (Scientific Notation):
    *   We shift the binary point to the left until there is only one '1' to its left: `1.0111`. 
    *   We shifted it 2 places, so the exponent is 2. The normalized form is $1.0111 times 2^2$. 

3.  Fill the Components:

    *   Sign bit (S): The number is positive, so S = 0.
    *   Exponent (E):
        *   For `float32`, the bias is 127. The stored exponent is $2 + 127 = 129$, which is `10000001` in binary.
        *   For `float64`, the bias is 1023. The stored exponent is $2 + 1023 = 1025$, which is `10000000001` in binary.
    *   Significand (M):
        *   The normalized form is `1.0111`. The leading '1' is implicit. We only store the fractional part, `0111`, and pad the rest with zeros.
        *   For `float32`, we store `0111` followed by 19 zeros to fill the 23-bit mantissa.
        *   For `float64`, we store `0111` followed by 48 zeros to fill the 52-bit mantissa.

---

### 📊 Comparison of float32 and float64

The following table summarizes the key differences between the two formats.

| Feature           | float32 (Single Precision)                                                           | float64 (Double Precision)                                                             |
| :---------------- | :----------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------- |
| Total Size        | 32 bits (4 bytes)                                                                    | 64 bits (8 bytes)                                                                      |
| Sign Bit          | 1 bit                                                                                | 1 bit                                                                                  |
| Exponent Bits     | 8 bits                                                                               | 11 bits                                                                                |
| Significand Bits  | 23 bits (24 bits with implicit '1')                                                  | 52 bits (53 bits with implicit '1')                                                    |
| Decimal Precision | ~7 significant digits                                                                | ~15-16 significant digits                                                              |
| Approximate Range | ±3.4 × 10³⁸                                                                          | ±1.8 × 10³⁰⁸                                                                           |
| Primary Use Case  | Graphics rendering, machine learning, real-time simulations where speed is critical. | Scientific computing, financial modeling, and any application requiring high accuracy. |

The IEEE 754 single-precision (32-bit) floating-point number has the following key characteristics for precision and range.

### Precision (Mantissa and Significant Digits)
A 32-bit float allocates:
- 1 bit for the sign,
- 8 bits for the biased exponent,
- 23 bits for the explicit mantissa (fraction). 

There is an implicit leading 1 for normalized numbers, giving a total of 24 bits of significand precision.

The machine epsilon (ε), which is the smallest relative difference between 1.0 and the next representable number greater than 1.0, is: $epsilon = 2^(-23) approx 1.1920929 times 10^(-7)$ .

### Representable Range
The exponent field uses a bias of 127.

- Smallest positive normalized number (minimum normal):   $2^(-126) approx 1.17549435 times 10^(-38)$ 

- Largest finite number (maximum):   $(2 - 2^(-23)) times 2^(127) approx 3.40282347 times 10^(38)$ 

- Smallest positive subnormal number (when exponent field is all zeros):   $2^(-126 - 23) = 2^(-149) approx 1.40129846 times 10^(-45)$ 

- Underflow occurs for values smaller than the smallest subnormal (they become zero).

In summary:  
- Precision: ~7 decimal digits ($2^(-23)$ relative precision)  
- Positive normalized range: $[1.17549435 times 10^(-38), 3.40282347 times 10^(38)]$ 
- With subnormals: down to $approx 1.4 times 10^(-45)$ 

These values assume the standard IEEE 754 binary32 format with round-to-nearest-even mode.
