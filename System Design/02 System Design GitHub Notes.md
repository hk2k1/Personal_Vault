## DNS
- **NS record (name server)** - Specifies the DNS servers for your domain/subdomain.
- **MX record (mail exchange)** - Specifies the mail servers for accepting messages.
- **A record (address)** - Points a name to an IP address.
- **CNAME (canonical)** - Points a name to another name or `CNAME` (example.com to [www.example.com](http://www.example.com/)) or to an `A` record.
#### Disadvantages
- slight delay, although mitigated by caching
- complex
- DDoS Attacks

## CDN 
- serve static files such as HTML/CSS/JS, photos, and videos
- Push CDN: 
	- CDN received changes from server when content is changed
	- used when not a lot of changes made to content
- Pull CDN: 
	- grab new content from server when first user requests and cache it
	- For High traffic

#### Disadvantages
- High costs
- Content might be stale if it is updated before the TTL expires it.
- CDNs require changing URLs for static content to point to the CDN.

## Load Balancers
- Distribute incoming client requests to servers and databases
- Increased scalability, Caching, Security
- LB useful for multiple servers
- Reverse proxies useful even with 1 server
	- But increased complexity and single point of failure
![[Pasted image 20240521230323.png]]
### Load Balancing Algorithms
- Static
	- Round Robin: A seequence
	- Weighted Round Robin
		- Servers with more resources gets priority
	- Random
	- Hashing
		- has to look into contents
- Dynamic
	- Least Load/Busy
		- Complex and overhead
		- ![[4cee9cb5b61260bd94fe23425917f25e.webp]]
	- Power of d choices
		- For Large distributed clusters
		- Choose a subset of servers at random (nginx uses d=2) and pick the best (least busy) server between them.
## OSI Model
Physical -> Data Link -> Network -> Transport -> Session -> Presentation -> Application Layer
![[Pasted image 20240522122154.jpg]]

Horizontal Scaling Disadvantage: Load Balancer complexity -> performance bottleneck

## Reverse Proxy (web server)
- Centralizes internal services and provides unified interfaces to public
- Useful with a single server
- Single point of failure

## Microservices
- Independent deployable small modular services runs a unique process and communicates
- Disadvantages to Application layer: loosely coupled services requires different approach vs a monolithic system.. Complexity

## Database
- ACID
	- **Atomicity** - Each transaction is all or nothing
	- **Consistency** - Any transaction will bring the database from one valid state to another
	- **Isolation** - Executing transactions concurrently has the same results as if the transactions were executed serially
	- **Durability** - Once a transaction has been committed, it will remain so
- Master-slave replication
- Master-Master replication

### Sharding
![[Pasted image 20240522112652.png]]

### Denormalization
- Redundant copies of the data are written in multiple tables to avoid expensive joins
	- Data is duplicated

### SQL Tuning
- Benchmark and profile to uncover bottlenecks
- Tighten up schema
	- `CHAR`> `VARCHAR`
	- `TEXT`
	- `INT`
	- `DECIMAL`
- Use good indices
- Avoid expensive joins
- Partition tables
- Tune query cache

## NoSQL
- BASE
	- **Basically available** - the system guarantees availability.
	- **Soft state** - the state of the system may change over time, even without input.
	- **Eventual consistency** - the system will become consistent over a period of time, given that the system doesn't receive input during that period.

## Types of Database storage
### Key-value store
- High performance, rapidly changing data
### Document store
- APIs or query language to query based on internal structure of doc itself
- Organized based on collections, tags, metadata
- High flexibility, occasionally changing data

### Wide column store
- ![[Pasted image 20240522113952.png]]
- Cassandra
- High Availability, Scalability and used for very large data sets

### Graph Database
- each node is a record and each arc is a relationship between two nodes
- complex relationships with many foreign keys or many-to-many relationships
- high performance for data models with complex relationships, such as a social network

## Cache
### Client Caching
- OS or Browser, server side, cache layer
### CDN caching
- CDNs

### Web server caching
- Reverse proxies cache requests, returning responses

### Database Caching
- query caching

## Application caching
- In memory such as Memcached and Redis
- Data stored in RAM

### When to update cache
- Look for entry in cache, resulting in a cache miss
- Load entry from the database
- Add entry to cache
- Return entry

### Disadvantages: cache
- Need to maintain consistency between caches and the source of truth such as the database through [cache invalidation](https://en.wikipedia.org/wiki/Cache_algorithms).
- Cache invalidation is a difficult problem, there is additional complexity associated with when to update the cache.
- Need to make application changes such as adding Redis or memcached.

## Asynchronism
![[Pasted image 20240522122007.png]]
### Message queues
- receive, hold, and deliver messages
- Redis, RabbitMQ
### Task queues
- support scheduling and run computationally intensive jobs in background
- Celery

Back Pressure - queue size > memory results in cache misses slower performance. Inexpensive calculations and realtime workflows better with synchronous operations

### HTTP
- GET
-  POST
-  PUT
-  PATCH
-  DELETE
- Application layer protocol like TCP and UDP

## TCP
- Connection established and terminated using a handshake
- All packets guaranteed to reach destination in original order without corruption
	- Sequence numbers, Checksum fields
	- Ack packets and automatic retransmission
- Multiple timeouts -> Connection dropped
- Flow Control - regulate amount of data a sender can transmit to not overwhelm a receiver
- Congestion Control - prevent network congestion by controlling rate of data entry into network
- applications that require High reliability,  less time critical
	- SMTP, FTP, SSH

## HTTP/1.0 - HTTP/1.1 - HTTP/2
- 1.0  had to break and rebuild connection/handshake every time there is a new request
- 1.1 solved this by introducing persistent connections and pipelining
	- TCP connection should be kept open unless directly told to close
	- But there is a bottleneck
	- Head Of Line Blocking
		- Packets cannot pass each other travelling to the same destination
		- So if 1 request cannot be served it will block the remaining requests in queue
		- Making parallel connections can but won't solve this entirely
- 2 Introduces Streams
	- Multiple streams in same TCP connection
		- Each stream has messages broken down into binary encoded frames
		- Can interleave during transfer and reassemble at the end
		- **Multiplexing**
	- Solves HOL blocking
	- 
## UDP
- Connectionless
- Datagrams are guaranteed only at datagram level
- may reach but out of order
- More efficient than TCP
- useful for DHCP Dynamic Host Configuration Protocol
- Applications like VoIP, video chat, streaming, realtime multiplayer games
- Low latency, ownself error correct

## Remote Procedure Call
- Execute function/procedure on a different computer over a network as if it were calling it locally
- Focused on exposing behaviours
- Used for performance reasons with internal communications
- Difficult to debug RPC, tightly coupled changes made difficult
- Specialized data processing
- Uses protocol buffers
	- data is serialized in binary format

## REST
- Architectural style enforcing client/server model
- Stateless and cacheable
- REST is great for horizontal scaling and partitioning.
- suffers if nested hierarchies

## Security
- Encrypt in transit and at rest.
- Sanitize all user inputs or any input parameters exposed to user to prevent [XSS](https://en.wikipedia.org/wiki/Cross-site_scripting) and [SQL injection](https://en.wikipedia.org/wiki/SQL_injection).
- Use parameterized queries to prevent SQL injection.
- Use the principle of [least privilege](https://en.wikipedia.org/wiki/Principle_of_least_privilege).

## Appendix
### Latency numbers every programmer should know

```
Latency Comparison Numbers
--------------------------
L1 cache reference                           0.5 ns
Branch mispredict                            5   ns
L2 cache reference                           7   ns                      14x L1 cache
Mutex lock/unlock                           25   ns
Main memory reference                      100   ns                      20x L2 cache, 200x L1 cache
Compress 1K bytes with Zippy            10,000   ns       10 us
Send 1 KB bytes over 1 Gbps network     10,000   ns       10 us
Read 4 KB randomly from SSD*           150,000   ns      150 us          ~1GB/sec SSD
Read 1 MB sequentially from memory     250,000   ns      250 us
Round trip within same datacenter      500,000   ns      500 us
Read 1 MB sequentially from SSD*     1,000,000   ns    1,000 us    1 ms  ~1GB/sec SSD, 4X memory
HDD seek                            10,000,000   ns   10,000 us   10 ms  20x datacenter roundtrip
Read 1 MB sequentially from 1 Gbps  10,000,000   ns   10,000 us   10 ms  40x memory, 10X SSD
Read 1 MB sequentially from HDD     30,000,000   ns   30,000 us   30 ms 120x memory, 30X SSD
Send packet CA->Netherlands->CA    150,000,000   ns  150,000 us  150 ms

Notes
-----
1 ns = 10^-9 seconds
1 us = 10^-6 seconds = 1,000 ns
1 ms = 10^-3 seconds = 1,000 us = 1,000,000 ns
```

Handy metrics based on numbers above:

- Read sequentially from HDD at 30 MB/s
- Read sequentially from 1 Gbps Ethernet at 100 MB/s
- Read sequentially from SSD at 1 GB/s
- Read sequentially from main memory at 4 GB/s
- 6-7 world-wide round trips per second
- 2,000 round trips per second within a data center

#### Latency numbers visualized

[![](https://camo.githubusercontent.com/77f72259e1eb58596b564d1ad823af1853bc60a3/687474703a2f2f692e696d6775722e636f6d2f6b307431652e706e67)](https://camo.githubusercontent.com/77f72259e1eb58596b564d1ad823af1853bc60a3/687474703a2f2f692e696d6775722e636f6d2f6b307431652e706e67)
