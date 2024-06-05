Take Left and Right end indices and compare

## Valid Palindrome <mark style="background: #BBFABBA6;">easy</mark>

```python
class Solution:
    def isPalindrome(self, s: str) -> bool:
    
    # Solution 1: Using Arrays
        newstr = "" 
        for ss in s:
            if ss.isalnum():
                newstr += ss.lower()
        return newstr == newstr[::-1]

    # Solution 2: Using Two Pointers
        l,r = 0, len(s)-1
        while(l<r):
            # Check if left and right pointer is alpha num and skip the index if its not
            while(l<r) and not s[l].isalnum():
                l+=1
            while(l<r) and not s[r].isalnum():
                r-=1
            # Check if left and right pointer is the same and move on to the next index
            if s[l].lower() != s[r].lower():
                return False
            l +=1
            r -=1
        return True

    # Solution 1 needs extra memory space allocated (newstr="" & newstr[::-1]) but Solution 2 doesn't


class Solution:
    def isPalindrome(self, s: str) -> bool:
        l, r = 0, len(s)-1
        while l < r:
            if not s[l].isalnum():
                l += 1
                continue
            if not s[r].isalnum():
                r -= 1
                continue
            if s[l].lower() != s[r].lower():
                return False
            l += 1
            r -= 1
        return True
```

## [167. Two Sum II - Input Array Is Sorted](https://leetcode.com/problems/two-sum-ii-input-array-is-sorted/) <mark style="background: #FFF3A3A6;">medium</mark>

```python
class Solution:
    def twoSum(self, numbers: List[int], target: int) -> List[int]:
        l, r = 0, len(numbers) - 1
        while l<r:
            curSum = numbers[l] + numbers[r]
            if curSum > target:
                r -= 1
            elif curSum < target:
                l += 1
            else:
                return [l+1, r+1]
        return []
            
```

## [15. 3Sum](https://leetcode.com/problems/3sum/) <mark style="background: #FFF3A3A6;">medium</mark>
```python
class Solution:
    def threeSum(self, nums: List[int]) -> List[List[int]]:
        res = []
        # sort nums and do 2 pointers to the 2nd and 3rd integer 
        nums.sort()
        # avoiding duplicates
        for i, a in enumerate(nums):
            if i > 0 and a == nums[i-1]:
                continue
            # 2 pointer solution for 2 sums
            l,r = i+1, len(nums)-1
            while l < r:
                threeSum = a + nums[l] + nums[r]
                if threeSum > 0:
                    r -= 1
                elif threeSum < 0:
                    l += 1
                else:
                    res.append([a, nums[l], nums[r]])
                    l += 1
                    # to avoid duplicates in 2 pointers and shift left pointer if duplicate found
                    while nums[l] == nums[l-1] and l < r:
                        l += 1
        return res
```

## [11. Container With Most Water](https://leetcode.com/problems/container-with-most-water/) <mark style="background: #FFF3A3A6;">medium</mark>

```python
class Solution:
    def maxArea(self, height: List[int]) -> int:
        res = 0
        l,r = 0, len(height)-1

        while l < r:
            area = min(height[l], height[r]) * (r-l)
            res = max(res, area)
            if height[l] < height[r]:
                l += 1
            else: 
                r -= 1
        return res
            
```