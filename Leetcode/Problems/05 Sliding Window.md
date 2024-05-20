## [121. Best Time to Buy and Sell Stock](https://leetcode.com/problems/best-time-to-buy-and-sell-stock/) <mark style="background: #FFF3A3A6;">easy</mark> 
```python
class Solution:
    def maxProfit(self, prices: List[int]) -> int:
        l,r = 0, 1 # l=buy, r=sell
        max_profit = 0
        while r < len(prices):
            if prices[l] < prices[r]:
                profit = prices[r] - prices[l]
                max_profit = max(profit, max_profit)
            else:
                l = r # shift left to the minimum value
            r += 1
        return max_profit
```

## [3. Longest Substring Without Repeating Characters](https://leetcode.com/problems/longest-substring-without-repeating-characters/) <mark style="background: #FFF3A3A6;">medium</mark>
```python
class Solution:
    def lengthOfLongestSubstring(self, s: str) -> int:
        substring = set()
        l = 0
        res = 0
        for r in range(len(s)):
            while s[r] in substring:
                substring.remove(s[l])
                l += 1
            substring.add(s[r])
            res = max(res, r-l+1)
        return res
```

## [Longest Repeating Character Replacement](https://leetcode.com/problems/longest-repeating-character-replacement/)  <mark style="background: #FFF3A3A6;">medium</mark>

```python
class Solution:
    def characterReplacement(self, s: str, k: int) -> int:
        count = {} # Hashmap to count char
        res = 0
        l = 0
        max_freq = 0
        for r in range(len(s)):
            count[s[r]] = 1 + count.get(s[r], 0) # increment count of char
            max_freq = max(max_freq, count[s[r]])
            # check if current window is valid by checking if current window length - max frequency of char > k
            # number of replacements > number of replacements allowed => shift left pointer if not shift right
            while (r-l+1) - max_freq > k:
                count[s[l]] -= 1 # decrement of left pointer char by 1 because we are shifting it the left pointer
                l += 1
            res = max(res, r-l+1)
        return res
```

## [Permutation in String](https://leetcode.com/problems/permutation-in-string/) <mark style="background: #FFF3A3A6;">medium</mark>
```python
class Solution:
    def checkInclusion(self, s1: str, s2: str) -> bool:
        # Sol 1 Brute force checking of window
        if len(s1) > len(s2):
            return False
        window = len(s1) # Sliding Window Size
        s1Counter = Counter(s1) # A Hash map of all the character count in s1
        for i in range(len(s2) - window+1):
            s2Counter = Counter(s2[i:i+window]) # Hash map of s2 but only for the window 
            # So we just check the hasmap of 2 strings with the specified window size
            if s2Counter == s1Counter:
                return True
        return False
        # Sol 2 
        # If enter window -1 if exit window -1 
        cntr, w, match = Counter(s1), len(s1), 0
        for i in range(len(s2)):
            if s2[i] in cntr:
                if not cntr[s2[i]]: match -= 1
                cntr[s2[i]] -= 1
                if not cntr[s2[i]]: match += 1

            if i >= w and s2[i-w] in cntr:
                if not cntr[s2[i-w]]: match -= 1
                cntr[s2[i-w]] += 1
                if not cntr[s2[i-w]]: match += 1

            if match == len(cntr):
                return True       
        return False
```