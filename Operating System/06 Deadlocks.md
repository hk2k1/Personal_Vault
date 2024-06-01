## What causes Deadlocks
- Mutual exclusion - 1 process at a time
- Hold & wait - process hold 1 resource is waiting for another process to finish up with another resource
- No preemption - Can only voluntarily yield
- Circular wait - P0 waiting for P1 and P1 waiting for P2 and P2 waiting for P0

## Methods for handling Deadlocks
### Prevention
- Make sure atleast one condition should not meet the above causes

### Avoidance
- each process declare max number of resources it may need
- Algorithm examines and allocates accordingly

### Detection/Recovery
- Banker's Algo
	- Safe state - A sequence of processes such that system can allocate all resources to each order 
- Process termination - Recovery