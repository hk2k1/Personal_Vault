`XOR`
- `0 ^ 0 = 0`
- `0 ^ 1 = 1`
- `1 ^ 1 = 0`
- Think XOR of as  Toggle
- If `0 ^ any number = any number`
- And if `1101 ^ 1111 = 0010`
- We can use `XOR` to check for same values

`Guassian Sum Formula`
`n*(n+1)/2 = sum of 1 to n`

`<< Left Shift` - Multiply by 2
`>> Right Shift` - Divide by 2

[That XOR Trick (florian.github.io)](https://florian.github.io/xor-trick/)

```
  a ^ b ^ c ^ a ^ b     # Commutativity
= a ^ a ^ b ^ b ^ c     # Using x ^ x = 0
= 0 ^ 0 ^ c             # Using x ^ 0 = x (and commutativity)
= c
```

---
## [136. Single Number](https://leetcode.com/problems/single-number/)

```python
class Solution:
    def singleNumber(self, nums: List[int]) -> int:
        res = 0
        for n in nums:
            res ^= n
        return res
```

## [268. Missing Number](https://leetcode.com/problems/missing-number/)
`XOR` operator to check each i with the list and return the one that's not found

```python
class Solution:
    def missingNumber(self, nums: List[int]) -> int:
        res = 0
        for i, num in enumerate(nums):
            res ^= i+1 ^ num
        return res
```

## [191. Number of 1 Bits](https://leetcode.com/problems/number-of-1-bits/)

>Repeatedly divide number by 2 (right shift) and Check Least Significant Bit (rightmost bit) to check if the divided number was even or odd
>Count all the 1s that way

```python
class Solution:
    def hammingWeight(self, n: int) -> int:
        count = 0
        while n:
            count += n&1
            n >>= 1
        return count
```