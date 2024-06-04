[CS75 (Summer 2012) Lecture 9 Scalability Harvard Web Development David Malan (youtube.com)](https://www.youtube.com/watch?v=-W9F__D3oY4)

## Vertical Scaling
Vertical -> Increase Ram, CPU, Disk
Disk - SAS, SSD, PATA

## Horizontal Scaling

## Load Balancing
Distribute traffic across multiple servers

### How to handle multiple IP addresses of server?
Instead of DNS returning IP address of Server 1 and server 2
Return the IP address of Load Balancer and let load balancer figure how to route the users to the server

### How to get the load balancer return to that request
Return based on load (least busy server)

Use Round robin / BIND to search through each server
Disadvantages:
- Round Robin is still going to send more and more users 1/n th of a time
- Caching

### So if user logs in with server 1 cookie, he has to login in server 2 again
So we use session states. Like a independent server that stores all the session data there and connected to all the servers

>`Sessions need to be stored in a centralized data store which is accessible to all your application servers. It can be an external database or an external persistent cache, like Redis. An external persistent cache will have better performance than an external database. By external I mean that the data store does not reside on the application servers. Instead, it is somewhere in or near the data center of your application servers.`

#### RAID - Redundant Array Independent Disk
- RAID0 or RAID1 or RAID5 or RAID10 ....
- RAID0 - Two identical hard drives, you strike data meaning you write some into this drive and some into the other drive
	- Good for performance
- RAID1 - Mirror data, store in both places parallel
	- Good for data backup
- RAID5 - 1 drive for redundant data, while RAID1 uses 1:1 .. RAID5 is 1:5
- RAID6 - even better. Any two drives can die


### Sticky Session
- Even if you visit a website multiple times, you are going to end up on the same session object
- Using cookies like a handstamp

>` even if you successfully switch to the latest and greatest NoSQL database and let your app do the dataset-joins, soon your database requests will again be slower and slower. You will need to introduce a cache`

### Caching
> `in-memory caches like Memcached or Redis. Please never do file-based caching, it makes cloning and auto-scaling of your servers just a pain`
> 2 patterns of caching your data.
> **#1 - Cached Database Queries** - `one piece of data changes (for example a table cell) you need to delete all cached queries who may include that table cell`
> **#2 - Cached Objects** - 

`query_cache_type` caches query 
`memcache` piece of software run on server, stores anything in RAM

### CAP
- **Consistency** - Every read receives the most recent write or an error
- **Availability** - Every request receives a response, without guarantee that it contains the most recent version of the information
- **Partition Tolerance** - The system continues to operate despite arbitrary partitioning due to network failures

### Database Replication
Master Database and Slave database
Anything done on master will be copied down to slave
So if 1 database dies, we got database backup

OR
 you can balance read requests across them

Disadvantage: Downtime due to only 1 master
So fix this by using Multiple Master and Multiple Slave

### Database Partitioning
A-M go this load balancer containing servers
M-Z go to this other load balancer containing servers

## High Availability
Pair of more servers checking each other heartbeats
so if 1 of them dies the other takes over


#### Availability in parallel vs in sequence
###### In sequence
```
Availability (Total) = Availability (Foo) * Availability (Bar)
```
If both `Foo` and `Bar` each had 99.9% availability, their total availability in sequence would be 99.8%.
###### In parallel
```
Availability (Total) = 1 - (1 - Availability (Foo)) * (1 - Availability (Bar))
```
If both `Foo` and `Bar` each had 99.9% availability, their total availability in parallel would be 99.9999%.

