- OS is a resource allocator
- OS is a control program
- bootstrap program loaded at power up or reboot stored in ROM or EPROM known as firmware
	- Initializes system
	- loads OS kernel and starts execution


### Interrupts

- Transfers control to **interrupt service routine** through **interrupt vector** (contains addresses of all service routines)
- Save the address of interrupted instruction
- Trap or exception -> software generated interrupt caused by error/user request
- OS is interrupt driven
- Handling
	- OS preserves state of CPU by storing **registers** and **program counter**
	- Type of Interrupt
		- Polling
		- Vectored

### Storage
- Main Memory
	- Random Access
	- volatile
- Secondary Storage
	- non-volatile
- Hard disks
- SSD
- Caching - main memory can be cache to secondary storage
- Device driver - Manage I/O providing uniform interface between controller and kernel
- registers <- cache <- main memory <- SSD <- HDD <- Optical disk <- Magnetic tapes
- Direct Memory Access Structure
	- Transfer data from buffer to main memory without CPU intervention
	- 1 interrupt per block of data instead of per byte


#### OS Architecture/Structure
- Multiprogramming
	- Jobs in memory
	- 1 job selected and run via **Job Scheduling**
	- Wait -> switch job
- Multitasking/Timesharing
	- Switch jobs frequently so that user can interact while running
	- **CPU scheduling**
	- Virtual memory allows execution of process not completely in memory

1. **Multiprogramming –** Multiprogramming is known as keeping multiple programs in the main memory at the same time ready for execution.
2. **Multiprocessing –** A computer using more than one CPU at a time.
3. **Multitasking –** Multitasking is nothing but multiprogramming with a Round-robin scheduling algorithm.
4. **Multithreading** is an extension of multitasking.

### Info
- Dual Mode
	- User mode and Kernel mode
	- Mode bit provided by hardware - distinguish between user code or kernel code
- Program in execution -> Process
	- Needs CPU, memory, I/O, files, Initialization data
- Single threaded -> 1 program counter
- Multi threaded -> 1 PC per thread
