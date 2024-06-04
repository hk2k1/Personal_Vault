![James May's OCD Compilation (youtube.com)](https://www.youtube.com/watch?v=pLIajuc31qk&t=624s)

- To traverse a list for max element it costs `O(n)`
- Solution is to sort and use the en but sort costs `O(nlogn)`
- Soooo
- HEAP
	- Binary tree
	- each curr node is smaller than its children - `min-heap`
	- node is larger than children - `max-heap`
	- Now we can find the max element for `O(1)`
- `siftup` & `siftdown` - Inserting
	- Add element obeying heap properties
	- `O(log n)`
- `O(1)` - get min or max
- Extract element
	- `O(log n)`
	- Swap with a leaf -> pop and remove the node (which is the leaf now)
- Heapify - Building the heap
	- start from back of array and keep swapping until heap properties satisfy
	- `O(n)`
- Applications
	- Heapsort
	- Priority Queue
		- Element with highest priority will dequeue first



## Basic Operations

- `heapq` module in python
1. `heapq.heappush(heap, item)` - Pushes a new item on the heap, maintaining the heap invariant
2. `heapq.heappop(heap)` - Pops the smallest item off the heap, maintaining the heap invariant
3. `heapq.heapify(x)` - Transforms list `x` into a heap, in-place, in linear time
4. `heapq.heapreplace(self.min_heap[0], val)`

## [703. Kth Largest Element in a Stream](https://leetcode.com/problems/kth-largest-element-in-a-stream/)

```python
import heapq
class KthLargest:
# O(n log n)
    def __init__(self, k: int, nums: List[int]):
        self.k = k
        self.nums = sorted(nums, reverse=True)

    def add(self, val: int) -> int:
        self.nums.append(val)
        self.nums.sort(reverse=True)
        return self.nums[self.k - 1]
# O(log n)
    def __init__(self, k: int, nums: List[int]):
        self.k = k
        self.min_heap = nums
        heapq.heapify(self.min_heap) # Initialize a min-heap
        while len(self.min_heap) > k:
            # Maintain a heap size of k
            # Only want kth largest, anything smaller than that is useless to us
            heapq.heappop(self.min_heap)

    def add(self, val: int) -> int:
        # if size < k append
        # elif val > smallest heap element
        #   replace it as the new kth largest 
        # return the smallest heap element which is the kth largest
        if len(self.min_heap) < self.k:
            heapq.heappush(self.min_heap, val)
        elif val > self.min_heap[0]:
            heapq.heapreplace(self.min_heap, val)
        return self.min_heap[0]


    # Another way of doing add
    def add(self, val: int) -> int:
        heapq.heappush(self.min_heap, val)
        if len(self.min_heap) > self.k:
            heapq.heappop(self.min_heap)
        return self.min_heap[0]

# Your KthLargest object will be instantiated and called as such:
# obj = KthLargest(k, nums)
# param_1 = obj.add(val)
```

## [1046. Last Stone Weight](https://leetcode.com/problems/last-stone-weight/)

```python
import heapq
class Solution:
    def lastStoneWeight(self, stones: List[int]) -> int:
        # Negate all the stones since python doesn't have max-heap so we gotta use min-heap and convert it
        for i,s in enumerate(stones):
            stones[i] = -s
        heapq.heapify(stones)
        while len(stones) > 1:
            firstStone = -heapq.heappop(stones) # unnegate the stones and insert into the heap
            secondStone = -heapq.heappop(stones)
            if firstStone > secondStone:
                heapq.heappush(stones, secondStone - firstStone)
        stones.append(0) # if stone is empty add 0
        return abs(stones[0]) # return positive value of the remaining stone
```