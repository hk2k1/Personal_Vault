
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
