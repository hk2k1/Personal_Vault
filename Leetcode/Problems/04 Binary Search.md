## [704. Binary Search](https://leetcode.com/problems/binary-search/) <mark style="background: #BBFABBA6;">easy</mark>
```python
class Solution:
    def search(self, nums: List[int], target: int) -> int:
        # O(log n) means dividing the class into half and check whether it is in the left or right and repeat
        l, r  = 0, len(nums)-1
        while l <= r:
            m = (l + r) // 2
            print(m)
            if target > nums[m]:
                l = m + 1
            elif target < nums[m]:
                r = m - 1
            else:
                return m
        return -1
```

## [74. Search a 2D Matrix](https://leetcode.com/problems/search-a-2d-matrix/) <mark style="background: #FFF3A3A6;">medium</mark>
```python
class Solution:
    def searchMatrix(self, matrix: List[List[int]], target: int) -> bool:
        # O(n) time complexity
        # for i in matrix:
        #     if target in i:
        #         return True
        #     else:
        #         continue
        # return False

        # O(log(m *n))
        row, col = 0, len(matrix[0])-1
        while row < len(matrix) and col >= 0:
            if matrix[row][col] < target:
                row += 1
            elif matrix[row][col] > target:
                col -= 1
            else:
                return True
        return False
```

## [875. Koko Eating Bananas](https://leetcode.com/problems/koko-eating-bananas/) <mark style="background: #FFF3A3A6;">medium</mark>
```python
class Solution:
    def minEatingSpeed(self, piles: List[int], h: int) -> int:
        l, r, m = 1, max(piles), 0

        while l <= r:
            m = (l+r)//2
            res = 0
            for pile in piles:
                res += math.ceil(pile/m)
            # If Koko takes m speed to eat => finishes with res hours 
            # If time taken res hours is longer than target time => koko eating too slow => increase her speed by increasing left pointer
            # Else time taken res hours is faster than target time => koko eating too fast => decrease her speed
            if res > h:
                l = m+1
            else:
                r = m-1
        return l
```

## [153. Find Minimum in Rotated Sorted Array](https://leetcode.com/problems/find-minimum-in-rotated-sorted-array/) <mark style="background: #FFF3A3A6;">medium</mark>
```python
class Solution:
    def findMin(self, nums: List[int]) -> int:
        # O(n)
        # return min(nums)

        # O(log n)
        l, r = 0, len(nums)-1

        while l <= r:
            m = (l+r)//2
            if m > 0 and nums[m] < nums[m-1]:
                return nums[m]
            
            if nums[m] < nums[r]:
                r = m - 1
            else:
                l = m +  1
        return nums[0]
            
```

## [33. Search in Rotated Sorted Array](https://leetcode.com/problems/search-in-rotated-sorted-array/)

```python
class Solution:
    def search(self, nums: List[int], target: int) -> int:
        l, r = 0, len(nums) - 1

        while l <= r:
            m = (l + r) // 2
            if nums[m] == target:
                return m
            if nums[l] <= nums[m]:
                if nums[l] <= target and target < nums[m]:
                    r = m - 1
                else:
                    l = m + 1
            else:
                if nums[m] < target and target <= nums[r]:
                    l = m + 1
                else:
                    r = m - 1
        return -1
```

## [981. Time Based Key-Value Store](https://leetcode.com/problems/time-based-key-value-store/) <mark style="background: #FFF3A3A6;">medium</mark>
```python
class TimeMap:

    def __init__(self):
        self.store = collections.defaultdict(list)

    def set(self, key: str, value: str, timestamp: int) -> None:
        self.store[key].append((value,timestamp))

    def get(self, key: str, timestamp: int) -> str:
        res = ""
        values = self.store.get(key, [])
        l,r = 0, len(values)-1
        while l <= r:
            m = (l + r)//2
            if values[m][1] <= timestamp:
                res = values[m][0]
                l = m+1
            else:
                r = m-1
        return res
```