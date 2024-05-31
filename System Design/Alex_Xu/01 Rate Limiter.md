- Benefits of API Rate Limiter
	- Prevent resource starvation caused by Denial Of Service
	- Reduce Cost by limiting allocation of resources
	- Prevent servers being overloaded

### Ask Questions
- Client or Server side?
- Limit based on IP? User ID?
- Scale of system?
- Separate Service? Application Code?
- Inform Users being limited?

Requirements:
- Low latency with little memory usage
- Rate limiting across multiple servers
- Exception handling
- High fault tolerance

### High Level Design

#### Where to put the rate limiter?
- Instead of putting the limiter at server -> Implement a Rate Limiter Middleware (Although it depends on your tech stack)
- Return **HTTP Status Code 429** (indicates too many requests by user)
-  ![[Pasted image 20240530235027.png]]

#### Rate Limiting Algorithm
- [[#Token Bucket Algorithm]]
- [[#Leaking Bucket Algorithm]]
- [[#Fixed Window Counter Algorithm]]
- [[#Sliding Window Log Algorithm]]
- [[#Sliding Window counter]]

##### Token Bucket Algorithm
- Bucket with predefined capacity
- Tokens put in periodically
- Once bucket full -> Extra tokens will overflow
- Each Request consumes 1 token
	- If tokens available -> Take 1 token out and Process Request
	- If no tokens -> Request dropped

- Two parameters
	- Bucket Size
	- Refill Rate
- How many buckets?
	- Different buckets for different API endpoints
		- 1 post/s, 150 friends/day, 5 posts/s => 3 buckets for each user
	- If based on IP address -> Each IP Address -> 1 Bucket
	- If Global Bucket needed by system for all requests
- Amazon, Stripe
![[Pasted image 20240531120047.png]]
###### Pros
- Easy to implement
- Memory efficient
- Token bucket allows burst of traffic for short periods
###### Cons
- Difficult to tune parameters of algorithm (bucket size & refill rate)

##### Leaking Bucket Algorithm
- FIFO queue
- Request arrives -> checks queue if full -> if not full process request
- if full  -> request dropped
- Two Parameters
	- Bucket Size
	- Outflow rate
- Shopify
![[Pasted image 20240531120101.png]]
###### Pros
- Memory efficient
- Requests processed at fix rate -> stable outflow rate
###### Cons
- burst of traffic fills up queue with old requests -> recent requests cannot be processed
- Difficult to tune parameters of algorithm (bucket size & outflow rate)

##### Fixed Window Counter Algorithm
- Divides timeline into fix-sized time windows
- assign counter for each window
- Increments counter for each request
- Reach pre-defined threshold -> requests dropped
- Problem
	- Burst of traffic at edges of time windows
![[Pasted image 20240531120121.png]]
###### Pros
- Memory efficient
- Easy to understand
###### Cons
- Spike in traffic at edges could cause more requests thana allowed quota to go through

##### Sliding Window Log Algorithm
- Fix the previous problem
- Keep track of requests
- Remove old requests
	- If window is 1 minute and current time is 1:01:00 any request before 1:00:00 is old
- Add new request time
- Check list size <= allowed number of requests -> allow new request
- > then reject request
![[Pasted image 20240531122432.png]]
###### Pros
- Very accurate rate limiting
###### Cons
- Uses more memory
##### Sliding Window Counter Algorithm
- Hybrid approach between fixed window and log
- Define Rate limit
- Track Requests
	- requests in previous minute and current minute
- Calculate requests in rolling window
	- `requests in current window +  requests in previous window x Overlap percentage`
	- If request arrive at 30% mark of the minute => overlap = 70%

###### Pros
- Smooths traffic spikes
- Memory efficient
###### Cons
- Assumes requests evenly distributed -> Approximation may not always be accurate

#### High Level Architecture
- Counter to keep track of how many requests
- Check counter > limit
- Where to store counters?
	- Database is slow due to I/O operations from disk
	- In-memory cache -> expiration and faster
	- `REDIS`
		- In memory store that offers `INCR` and `EXPIRE`
		- `INCR` - decreases stored counter by 1
		- `EXPIRE`- timeout for counter and auto delete
- ![[Pasted image 20240531123350.png]]

### Design Deep Dive
How are rate limiting rules created like the parameters?
How to handle requests that are rate limited?

#### Rate Limiting Rules
```conf
domain: messaging
decriptors:
- key: message_type
	Value: marketing
	rate_limit:
	unit: day
	requests_per_unit: 5
```

#### Exceeding Rate Limit
- Return HTTP Code 429 (too many requests)

##### Rate Limiting Headers
Client can know how much it is being throttled by using **HTTP Response Headers**
- `X-Ratelimit-Remaining` - Remaining number of  requests within window
- `X-Ratelimit-Limit` - Threshold
- `X-Ratelimit-Retry` - Waiting time

#### Detailed Design
![[Pasted image 20240531130358.png]]
- Rules stored on disk. Workers pull rules and store in cache
- Client request sent to middleware first
- Middleware loads rules from cache
	- Fetches counters and last request timestamp from Redis cache
	- Based on response
		- If request is not rate limited, forwards to <mark style="background: #BBFABBA6;">API servers</mark>
		- If request rate limited
			- Returns 429 code
			- Either dropped or put into a message queue

#### Distributed Environment
- Scaling to support multiple servers -> Challenges:
	- Race Condition
	- Synchronization issue

##### Race Condition
- Occurs in a highly concurrent environment
- If there are two requests concurrently read before either of them writes back
- each redis will increment counter
- This leads to an extra value
- If we use locks to fix this it will slow down system
- Fix:
	- Lua script
	- Sorted sets data structure in redis

##### Synchronization Issue
![[Pasted image 20240531131947.png]]
- If there are multiple rate limiter servers
- Synchronization between stateless servers needs to be done
- Solution
	- Use centralized data stores like Redis

#### Performance and Monitoring
- Multi-data centre setup
	- Latency
	- Traffic routed to closest edge server
- Synchronize data with eventual consistency model

- Need to check whether rate limiting algorithm and rules are effective and fine tune
- Becomes ineffective if we see sudden increase in traffic like flash sales
- Burst Traffic -> Token Bucket