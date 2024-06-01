
- CPU Burst - duration during which a process runs on the CPU without any interruptions -> I/O bursts
- Scheduling Criteria
	- CPU utilization -> Max
	- Throughput -> Max
	- Turnaround Time -> Min
	- Waiting time -> Min
	- Response time -> Min
- Preemptive Scheduling - OS can stop running process
	- Better response time
	- Increased overhead due to frequent switching
- Non Preemptive Scheduling - Runs until CPU voluntarily yields
	- Predictable
	- Long Waiting time and Response time

## Scheduling Algorithm
- **FCFS**
- **SJF**
	- Gives better average waiting time
- **Priority scheduling**
	- smallest integer -> Highest priority
	- Problem
		- **Starvation** - low priority never gets executed
	- Solution
		- **Aging** - As time progresses increase the priority of process
- Round Robin
	- each process gets time quantum q
	- Higher average turnaround time than SJF
- Multilevel Queue
	- Ready queue split into separate queues
	- Each queue has its own scheduling algorithm
- Multilevel Feedback Queue
	- Process can move between queues
	- aging can be implemented

## Dispatcher
- Is a scheduler
- Role
	- **Context Switching
	- **CPU Allocation:** Assigns
	- **State Management
- Dispatch Latency
	- Hardware support
	- Process state complexity
	- OS efficiency