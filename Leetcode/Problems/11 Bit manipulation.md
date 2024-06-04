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

---

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

