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

---

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

## [973. K Closest Points to Origin](https://leetcode.com/problems/k-closest-points-to-origin/)

```python
import heapq
class Solution:
    def kClosest(self, points: List[List[int]], k: int) -> List[List[int]]:
        # Create a hashMap that will map the points to the distance
        # hashMap = { [-2, 2] : 2.8 }
        # Create a min-heap that will store the distance
        # for loop k -> pop min-heap and append to res []

        res, minHeap = [], []
        for x, y in points:
            dist = x**2 + y**2
            heapq.heappush(minHeap, [dist, [x,y]])
            
        for _ in range(k):
            res.append(heapq.heappop(minHeap)[1])
        return res
```

## [215. Kth Largest Element in an Array](https://leetcode.com/problems/kth-largest-element-in-an-array/)
`Kth Largest/Smallest`

```python
import heapq
class Solution:
    def findKthLargest(self, nums: List[int], k: int) -> int:
        # Build the entire array into min-heap
        # then we do a N-k pop
        # And the mineheap[0] is Kth largest element

        heapq.heapify(nums)
        for i in range(len(nums)-k):
            heapq.heappop(nums)
        return nums[0]

        # Alternative Approach
        minHeap = []
        for num in nums:
            heapq.heappush(minHeap, num)
            if len(minHeap) > k:
                heapq.heappop(minHeap)
        return minHeap[0]

        # Kth Smallest
        maxHeap = []
        for num in nums:
            heapq.heappush(maxHeap, -num)
            if len(maxHeap) > k:
                heapq.heappop(maxHeap)
        return -maxHeap[0]
```

---
## [1834. Single-Threaded CPU](https://leetcode.com/problems/single-threaded-cpu/)

```python
import heapq
class Solution:
    def getOrder(self, tasks: List[List[int]]) -> List[int]:
        # Add the index to each of the task
        for i, t in enumerate(tasks):
            t.append(i)
        # sort tasks by their enqueue time
        tasks.sort(key = lambda t: t[0])
        # Min-Heap Problem
        res, minHeap = [], []
        # i -> Current task
        # time -> Current time
        i, time = 0, tasks[0][0]

        # Go through min heap and the tasks to min heap
        while minHeap or i < len(tasks):
            # Add to min-heap only if current time > task time
            while i < len(tasks) and time >= tasks[i][0]:
                heapq.heappush(minHeap, [tasks[i][1], tasks[i][2]]) # only care about the processing time and index
                i += 1
            if not minHeap:
                # if minHeap empty -> Fast forward time to the next time we actually need
                time = tasks[i][0]
            else:
                # if not empty get the smallest processing time and index
                processTime, index = heapq.heappop(minHeap)
                time +=  processTime
                res.append(index)
        return res
```

1. **Add Indices to Tasks**:
   ```python
   for i, t in enumerate(tasks):
       t.append(i)
   ```
   Here, we append the index of each task to its corresponding list. This helps us keep track of the original position of each task after sorting and during heap operations.

2. **Sort Tasks by Enqueue Time**:
   ```python
   tasks.sort(key=lambda t: t[0])
   ```
   We sort the tasks by their enqueue time (`t[0]`). This way, we can process tasks in the order they become available.

3. **Initialize Variables**:
   ```python
   res, minHeap = [], []
   i, time = 0, tasks[0][0]
   ```
   - `res`: List to store the order of task indices as they are processed.
   - `minHeap`: A min-heap to manage tasks based on their processing times.
   - `i`: Pointer to iterate over the tasks.
   - `time`: The current time, initialized to the enqueue time of the first task.

4. **Process Tasks**:
   ```python
   while minHeap or i < len(tasks):
   ```
   This loop continues until all tasks have been processed.

5. **Add Tasks to Min-Heap**:
   ```python
   while i < len(tasks) and time >= tasks[i][0]:
       heapq.heappush(minHeap, [tasks[i][1], tasks[i][2]])
       i += 1
   ```
   We add tasks to the min-heap if their enqueue time is less than or equal to the current time. We push a tuple `[processingTime, index]` to the heap to prioritize tasks with smaller processing times.

6. **Handle Empty Min-Heap**:
   ```python
   if not minHeap:
       time = tasks[i][0]
   ```
   If the min-heap is empty, we fast-forward the current time to the enqueue time of the next task.

7. **Process Task from Min-Heap**:
   ```python
   else:
       processTime, index = heapq.heappop(minHeap)
       time += processTime
       res.append(index)
   ```
   If the min-heap is not empty, we pop the task with the smallest processing time. We then increment the current time by the processing time of this task and add the task's index to the result list.

#### Example Walkthrough
Let's go through an example:

#### Input
```python
tasks = [[1, 2], [2, 4], [3, 2], [4, 1]]
```

#### Execution
1. Append indices:
   ```python
   tasks = [[1, 2, 0], [2, 4, 1], [3, 2, 2], [4, 1, 3]]
   ```
   
2. Sort by enqueue time:
   ```python
   tasks = [[1, 2, 0], [2, 4, 1], [3, 2, 2], [4, 1, 3]]
   ```

3. Initialize variables:
   ```python
   res = []
   minHeap = []
   i = 0
   time = 1
   ```

4. Start processing tasks:
   - Add first task to min-heap:
     ```python
     minHeap = [[2, 0]]
     i = 1
     ```
   - Process the first task:
     ```python
     processTime, index = heapq.heappop(minHeap)  # processTime = 2, index = 0
     time += processTime  # time = 3
     res = [0]
     ```

   - Add second and third tasks to min-heap:
     ```python
     minHeap = [[4, 1], [2, 2]]
     i = 3
     ```
   - Process the task with the smallest processing time (third task):
     ```python
     processTime, index = heapq.heappop(minHeap)  # processTime = 2, index = 2
     time += processTime  # time = 5
     res = [0, 2]
     ```

   - Add fourth task to min-heap:
     ```python
     minHeap = [[4, 1], [1, 3]]
     i = 4
     ```
   - Process the task with the smallest processing time (fourth task):
     ```python
     processTime, index = heapq.heappop(minHeap)  # processTime = 1, index = 3
     time += processTime  # time = 6
     res = [0, 2, 3]
     ```

   - Process the remaining task (second task):
     ```python
     processTime, index = heapq.heappop(minHeap)  # processTime = 4, index = 1
     time += processTime  # time = 10
     res = [0, 2, 3, 1]
     ```

5. Return the result:
   ```python
   return res  # [0, 2, 3, 1]
   ```


import heapq
class Solution:
    def findKthLargest(self, nums: List[int], k: int) -> int:
        # Build the entire array into min-heap
        # then we do a N-k pop
        # And the mineheap[0] is Kth largest element

        heapq.heapify(nums)
        for i in range(len(nums)-k):
            heapq.heappop(nums)
        return nums[0]

This is my LC 215 Kth largest element in array
What if i want Kth smallest element, how do i convert my code to solve this?