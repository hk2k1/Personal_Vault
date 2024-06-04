- **File** Logical storage unit
- **File system** for data to be stored
- Data cannot be written into secondary storage unless they are within a file
- Multi leveled system
	- Application -> Logical file system -> File Organization Module -> Basic file system -> I/O control -> Disk
- **Directory** logical construct representing a set of files


### File System
- `Boot control block` - info needed to boot
- `volume control block` - info about volume/size
- `master file table` - info about directory
- `file control block` - info about file

Allocation methods
- Contiguous
- Linked
- Indexed

### How does a Hard Disk work
- Each disk circular flate shape
- Bits stored magenetically 
- Read-write head flies over platters
- Surface of platter divided into circular tracks
- Tracks subdivided into sectors
- set of tracks at one arm position consist a cylinder
- thousands of cylinder
- motor rotates the disk at high speed

- Large 1-D array of logical blocks (smallest unit of transfer)
- Disk Scheduling - improve access time and bandwidth
	- FCFS
	- Shortest seek time first
	- SCAN or C-SCAN
	- LOOK or C-LOOK
- Disk Formatting
	- Physical
		- fills disk with data structure
	- Logical
		- creates a file system

![[01 CS75 Scalability#RAID - Redundant Array Independent Disk]]