### Race Condition
A race condition occurs when two or more threads can access shared data and they try to change it at the same time. 

Because the thread scheduling algorithm can swap between threads at any time, you don't know the order in which the threads will attempt to access the shared data. Therefore, the result of the change in data is dependent on the thread scheduling algorithm, i.e. both threads are "racing" to access/change the data.


## Critical Section

- Segment of code that is important 
- Process must ask permission to enter and exit section
- **Mutual Exclusion**
	- Only 1 process allowed into critical section
- **Progress**
	- If no process in critical section and 1 process waiting -> it should not be postponed
- **Bounded waiting**
	- number of times processes allowed to enter critical section

- Preemptive - Exit process when running
- Non-preemptive - Runs until voluntarily yields CPU

## Mutex Locks
- `acquire()` and `release()`
- Atomic - Non Interruptible
- Locking Mechanism
- Mutex Object
- **Busy waiting**
	- to spin and wait for a change in a hardware register or a memory location
- **Spinlock**
	- spinlocks use a busy-wait method, where a thread continuously selects a lock until it becomes available

## Semaphores
- `wait()` and `signal()`
- Atomic - Non Interruptible
- Integer
- Signalling Mechanism
	- A thread can be signalled by another thread
- **Counting Semaphores**
	- Integer value can range over an unrestricted domain
- **Binary Semaphores**
	- Range: 0 and 1
	- Same as mutex lock

## Deadlock & Starvation
- Deadlock - All processes keep waiting for each other to complete and none get executed
- Starvation - High priority processes keep executing and low priority processes are blocked
- **Priority Inversion** - Lower priority process holds a lock needed by higher priority process
	- Solved by **Priority Inheritance protocol** ( priority is raised )

### Classic Problems of Synchronization
- Bounded-Buffer Problem
	- A challenge in coordinating producers adding items to a buffer and consumers removing items from it, ensuring the buffer doesn’t overflow or underflow.
- Readers and Writers Problem
	- A challenge in managing access to a shared resource, ensuring multiple readers can read simultaneously, but writers get exclusive access to write, avoiding conflicts.
- Dining-Philosophers Problem
	- A challenge in ensuring that multiple philosophers can eat without causing a deadlock, by managing the limited number of shared chopsticks they need to eat.
