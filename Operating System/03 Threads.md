- Parallelism
	- System can perform more than one task simultaneously
	- Data Parallelism
		- distributes subsets of same data across multiple cores
	- Task Parallelism
		- distributes threads across cores, each thread -> unique task
- Concurrency
	- Makes progress on more than one task
	- Single Processor
- ![[Pasted image 20240601132704.png]]
- ![[Pasted image 20240601132818.png]]

### Multithreading Models
- Many-to-One
	- ![[Pasted image 20240601133016.png]]
	- 1 thread blocked causes all to be blocked
	- Multiple threads cannot run in parallel
- One-to-One
	- ![[Pasted image 20240601133122.png]]
	- more concurrency
- Many-to-Many
	- ![[Pasted image 20240601133154.png]]
- Two-level model
	- ![[Pasted image 20240601133226.png]]
	- Similar to M:M except it allows user thread to be bound to kernel thread

- Thread library - API for creating and managing threads
- Pthreads - POSIX standard either as user level or kernel level
- Threading Issues
	- Signal Handling - deliver signals for multi thread which signal to which thread
	- Cancellation of Thread - Asynchronous or Deferred (periodically check if thread needs to be cancelled)
- Thread Local Storage - Each thread have its own copy of data
- Linux threads done through `clone()`
- 