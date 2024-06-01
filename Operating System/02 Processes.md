- Programs
	- Batch system - jobs
	- Time-shared system - user programs or tasks
- Process
	- Program in execution
- Text Section
	- Program code
- Stack
	- Temp data - function parameters, local variables
- Data section
	- global variables
- Heap
	- Memory dynamically allocated during run time
![[Pasted image 20240601112805.png]]

### Process State
![[Pasted image 20240601112829.png]]

### Process Control Block

![[Pasted image 20240601113005.png]]

Context Switch: save state into PCB -> reload state from PCB

### Threads
- Process - single thread of execution
- If multiple locations can execute at once  -> threads -> storage for thread details and multiple PCs

### Process Scheduling
Selects among available processes for next execution on CPU
- Job queue - set of all processes
- Ready queue - processes waiting to be executed
- Device queue - waiting for an I/O device

### Schedulers
- **Short-term Scheduler/CPU Scheduler**
	- selects process to be executed and allocates CPU
	- Invoked Frequently
- **Long-term Scheduler/Job Scheduler**
	- selects process to be put into ready queue
	- Invoked infrequently
- Processes can be
	- I/O bound process - spends more time with I/O computations
	- CPU bound process - spends more time with CPU bursts
- Medium-term  Scheduler
	- Remove process from memory, store on disk bring back in from disk to continue execution: swapping

### Operations on Processes
- Process Creation
	- Process Identifer (PID)
	- UNIX commands
		- `fork()` - new process
		- `exec()` - replace the process memory space with new program
- Termination
	- `wait()` status data from child to parent
		- process terminated but no parent waiting to delete its PCB - `zombie`
		- If parent terminated without invoking wait process is `orphan`
	- `abort()`

### Interprocess Communication
- Cooperating processes for information sharing/modularity need **IPC**
- Two models of IPC
	- Shared Memory
		- comms under control of users processes and not OS
		- Issue - Synchronization
		- Producer-Consumer
		- Share a common space/area known as buffer
	- Message Passing
		- Communicate without shared memory by establishing communication link (direct - straight to pid or indirect - mailbox)
		- Operations `send(message)` & `receive(message)`
	- ![[Pasted image 20240601122344.png]]


#### Synchronization
- Blocking - synchronous
	- Blocking send - sender blocked until message received
	- Blocking receive - receiver is blocked until message is available
- Non Blocking - asyncrhonous
	- Non blocking send - sender sends msg and continues
	- Non Blocking receive - receiver receivesmsg
- If both send and receive blocking - rendezvous
- Examples: Local/Remote Procedure Calls, Sockets, Pipes
#### Sockets
- Endpoint for communication
- IP address and Port
- ports  < 1024 - standard

### Remote Procedure Calls
- Stubs - client side proxy for actual procedure on server
	- client marshalls the parameters
- Server side stub receives unpacks and performs procedure on server
