## Microservices: System Design & Key Competencies

### Architecture and Design

#### What are Microservices?

Microservices are a software architectural style that structures an application as a collection of loosely coupled services. Each service is:

- **Highly maintainable and testable**
- **Loosely coupled**
- **Independently deployable**
- **Organized around business capabilities**
- **Owned by a small team**

#### Bounded Context

A bounded context is a central pattern in domain-driven design. It defines a boundary within which a particular domain model is defined and applicable. Each microservice should have its own bounded context, meaning it has its own domain model and logic, which do not leak into other services.

#### Advantages of Microservices

1. **Scalability**: Each microservice can be scaled independently based on its specific needs.
2. **Flexibility in Technology**: Different services can use different technologies best suited for their tasks.
3. **Fault Isolation**: Failures in one service do not directly affect others, improving system resilience.
4. **Ease of Deployment**: Independent deployment of each service allows for faster updates and rollbacks.

#### Communication in Microservices

- **Synchronous Communication**: Involves direct calls between services, typically using HTTP/REST where the client waits for the server to respond.
- **Asynchronous Communication**: Uses message brokers (e.g., RabbitMQ, Kafka) where the client sends a message and continues its work without waiting for a response. This is useful for decoupling services and improving system resilience.

### Example Design Exercise

#### E-commerce Microservices Architecture

1. **User Service**
    - Manages user information and authentication.
2. **Product Service**
    - Manages product listings and details.
3. **Order Service**
    - Handles order creation, updates, and status tracking.
4. **Inventory Service**
    - Manages product inventory levels.
5. **Payment Service**
    - Processes payments and manages transaction records.
6. **Notification Service**
    - Sends notifications to users about order status, promotions, etc.

**Interactions:**

- When a user places an order:
    - **Order Service** communicates with **Inventory Service** to check and update stock.
    - **Order Service** communicates with **Payment Service** to process the payment.
    - **Order Service** communicates with **Notification Service** to inform the user about the order status.
- **Product Service** updates the **Inventory Service** whenever there are changes in product availability.

### Implementing Fault Tolerance in a Microservice

#### Example: Payment Processing Microservice

To ensure the payment processing microservice is fault-tolerant, consider the following mechanisms:

- **Circuit Breaker**: Implement a circuit breaker pattern to stop requests to a service that is likely to fail. This helps prevent cascading failures and reduces load on struggling services.
	-  acts as a proxy for operations that might fail. The proxy should monitor the number of recent failures that have occurred, and use this information to decide whether to allow the operation to proceed, or simply return an exception immediately.
- **Retries**: Implement retries with exponential backoff for transient errors. This means if a request fails, it will be retried after a delay, with the delay increasing exponentially after each attempt.
- **Fallbacks**: Provide fallback mechanisms in case of failure, such as default responses or alternative workflows (e.g., queuing the transaction for later processing).
- **Bulkheads**: Isolate resources to limit the impact of failures (e.g., using separate thread pools for different services).
- **Timeouts**: Set timeouts for service calls to prevent hanging requests, ensuring that failures are detected quickly and do not block the system.

> More on this in - [[03 Resilience & Fault Tolerance]]
