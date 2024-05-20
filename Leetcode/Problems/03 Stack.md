## [20. Valid Parentheses](https://leetcode.com/problems/valid-parentheses/) <mark style="background: #BBFABBA6;">easy</mark>

```python
class Solution(object):
    def isValid(self, s):
        """
        :type s: str
        :rtype: bool
        """
        stack = []
        hashMap = { 
            ")": "(",
            "}": "{",
            "]": "["
        }

        for str in s:
            if str in hashMap:
                if stack and stack[-1] == hashMap[str]:
                    stack.pop()
                else:
                    return False
            else:
                stack.append(str)
        # only return true if stack is empty
        if not stack:
            return True
        else:
            return False
```

## Min Stack

```python
class MinStack(object):

    def __init__(self):
        self.stack = []
        self.minStack = []

    def push(self, val):
        """
        :type val: int
        :rtype: None
        """
        self.stack.append(val)
        val = min(val, self.minStack[-1] if self.minStack else val)
        self.minStack.append(val)    
        
    def pop(self):
        """
        :rtype: None
        """
        self.stack.pop()
        self.minStack.pop()
        

    def top(self):
        """
        :rtype: int
        """
        return self.stack[-1]

    def getMin(self):
        """
        :rtype: int
        """
        return self.minStack[-1]

        


# Your MinStack object will be instantiated and called as such:
# obj = MinStack()
# obj.push(val)
# obj.pop()
# param_3 = obj.top()
# param_4 = obj.getMin()

```

## Reverse Polish Notation
```python
class Solution:
    def evalRPN(self, tokens: List[str]) -> int:
        stack = []
        for tk in tokens:
            if tk == "+":
                stack.append(stack.pop() + stack.pop())
            elif tk == "-":
                a, b = stack.pop(), stack.pop()
                stack.append(b - a)
            elif tk == "*":
                stack.append(stack.pop() * stack.pop())
            elif tk == "/":
                a, b= stack.pop(), stack.pop()
                stack.append(int(b / a))
            else:
                stack.append(int(tk))
        return stack[-1]
```

## 853. Car Fleet](https://leetcode.com/problems/car-fleet/) <mark style="background: #FFF3A3A6;">medium</mark>
```python
cclass Solution:
    def carFleet(self, target: int, position: List[int], speed: List[int]) -> int:
        combined_arr =  [[p, s] for p, s in zip(position, speed)]

        stack = []
        # iterate in the reverse order
        # so that the car in front will take precedence
        for p, s in sorted(combined_arr)[::-1]:
            stack.append((target - p) / s) # calculate time taken to reach target by each car
            # stack must contain atleast 2 cars
            # check if follower car is takes less time to reach (faster) than leader
            if len(stack) >= 2 and stack[-1] <= stack[-2]:
                stack.pop() # remove the colliding follower because it will merged into 1 fleet (platoon)
        return len(stack)
```

## Largest Rectangle in Histogram
```python
class Solution:
    def largestRectangleArea(self, heights: List[int]) -> int:
        maxArea = 0
        stack = [] # pair = (index, height)

        for i, h in enumerate(heights):
            start = i # current start index of the current height
            # if top value of stack and top value of height greater than the current height, pop it and check the max area we can create from this
            while stack and stack[-1][1] > h:
                index, height = stack.pop()
                # check if the popped index and height makes the max area
                # current index -  start index -> width
                maxArea =  max(maxArea, height * (i - index) )
                start =  index # since current height greater than height, extend start index backwards to the index we just popped
            stack.append((start, h)) # add start index and height
        for i, h in stack:
            maxArea = max(maxArea, h * (len(heights) -i))
        return maxArea

```

## [739. Daily Temperatures](https://leetcode.com/problems/daily-temperatures/) <mark style="background: #FFF3A3A6;">medium</mark>

```python
class Solution:
    def dailyTemperatures(self, temperatures: List[int]) -> List[int]:
        # O(n^2)
        # ans = [0]*len(temperatures)
        # for i in range(len(temperatures)):
        #     for j in range(i+1, len(temperatures)):
        #         if temperatures[j] > temperatures[i]:
        #             ans[i] = j-i
        #             break
        # return ans

        # O(n)
        res = [0]*len(temperatures)
        stack = [] # pair: [temp, index]

        for i, t in enumerate(temperatures):
            while stack and t > stack[-1][0]:
                stackTemp, stackIndex = stack.pop()
                res[stackIndex] = (i - stackIndex)
            stack.append([t, i])
        return res


```