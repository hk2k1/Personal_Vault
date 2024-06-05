
## [217. Contains Duplicate](https://leetcode.com/problems/contains-duplicate/) <mark style="background: #BBFABBA6;">easy</mark>

```python
class Solution:
    def containsDuplicate(self, nums: List[int]) -> bool:
        nums.sort()
        for i in range(1, len(nums)):
            if nums[i] == nums[i - 1]:
                return True
        return False
```

## [242. Valid Anagram](https://leetcode.com/problems/valid-anagram/)<mark style="background: #BBFABBA6;">easy</mark>

```python
class Solution:
    def isAnagram(self, s: str, t: str) -> bool:
        ss = sorted(s)
        tt = sorted(t)
        return ss == tt
```

## [1. Two Sum](https://leetcode.com/problems/two-sum/) <mark style="background: #BBFABBA6;">easy</mark>

```python
class Solution:
    def twoSum(self, nums: List[int], target: int) -> List[int]:
        numMap = {}
        n =  len(nums)

        # Build a hash table with the dictionary
        for i in range(n):
            numMap[nums[i]] = i
        
        # Iterate through the Hash Table
        for i in range(n):
            # subtracting from target will give you the number. Find this number from the hash table
            # Since hash table is organized using the number as its indices => numMap[number]
            counterpart = target - nums[i]
            if counterpart in numMap and numMap[counterpart] != i:
                return[i, numMap[counterpart]]
        # Nothing found
        return []
```

## Top K Frequent Elements <mark style="background: #FFF3A3A6;">medium</mark>
```python
class Solution:
    def topKFrequent(self, nums: List[int], k: int) -> List[int]:
        map = defaultdict(int)
        for n in nums:
            map[n] += 1
        return sorted(map, key=map.get, reverse=True)[:k]
```

[Top K Frequent Elements - Submission Detail - LeetCode](https://leetcode.com/submissions/detail/1207746899/)

## [49. Group Anagrams](https://leetcode.com/problems/group-anagrams/) <mark style="background: #FFF3A3A6;">medium</mark>

```python
class Solution:
    def groupAnagrams(self, strs: List[str]) -> List[List[str]]:
        map = defaultdict(list)
        for word in strs:
            # sorted('banana') would return ['a', 'a', 'a', 'b', 'n', 'n'].
            # so we join the sorted list into a word
            # use the hash map to store the word that is matched
            sorted_word = ''.join(sorted(word))
            map[sorted_word].append(word)

        return list(map.values())
```
[Group Anagrams - Submission Detail - LeetCode](https://leetcode.com/submissions/detail/1207731779/)

### Longest Streak
```python
class Solution:
    def longestConsecutive(self, nums: List[int]) -> int:
        if not nums:
            return 0
        nums = set(nums)
        count = 0
        for n in nums:
            if n-1 not in nums:
                y = n+1
                while y in nums:
                    y += 1
                count = max(count, y-n)
        return count

```

## <mark style="background: #FF5582A6;">String Encode and Decode</mark>
 
```python
class Solution:

    def encode(self, strs: List[str]) -> str:
        res = ""
        for s in strs:
            res += s+"-"
        return res

    def decode(self, s: str) -> List[str]:
        res = [""]
        i = 0
        for sts in s:
            if sts == "-":
                i += 1
                res.append("")
            else:
                res[i] += sts
        return res[:-1]
```

## <mark style="background: #FF5582A6;">Products of Array Discluding Self</mark>
`prefix & postfix method`

```python
class Solution:
    def productExceptSelf(self, nums: List[int]) -> List[int]:
        res = [1] * len(nums)
        # Prefix Array
        prefix = 1
        for i in range(len(nums)):
            res[i] = prefix
            prefix *= nums[i]
        postfix = 1
        for j in range(len(nums)-1, -1, -1):
            res[j] *= postfix
            postfix *= nums[j]
        return res
```

## <mark style="background: #FF5582A6;">Valid Sudoku</mark>

```python
from collections import defaultdict
class Solution:
    def isValidSudoku(self, board: List[List[str]]) -> bool:
        row, col, region = defaultdict(set), defaultdict(set), defaultdict(set)

        for r in range(9):
            for c in range(9):
                if board[r][c] == ".":
                    continue
                if board[r][c] in row[r] or board[r][c] in col[c] or board[r][c] in region[(r//3, c//3)]:
                    return False
                row[r].add(board[r][c])
                col[c].add(board[r][c])
                region[(r//3, c//3)].add(board[r][c])
        return True
```

