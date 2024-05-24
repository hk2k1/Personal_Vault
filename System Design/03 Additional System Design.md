>[!tip] Resources
>- [System Design Interview Guide for Senior Engineers (interviewing.io)](https://interviewing.io/guides/system-design-interview)

## SSL/TLS HTTPS 
### Asymmetric Encryption
1. Message encrypted by A's public key can only be decrypted by A's private key
2. Anyone with B's public key can verify that a message could only have been created by someone with access to B's private key 


### How browser connects to website using HTTPS
![](Pasted%20image%2020230531183159.png)

### How Certificate Authority (CA) works and create a Signed Certificate for a server
- CA will create Private & Public Key
- Server will create Private & Public Key
- Server will create Certificate Signing Request (CSR) using its key pair and ask CA to sign it 
- CA will sign it using its private key. So anyone who has access to CA's public key will know it was actually CA who signed as per [[4 Prerequisites#^point2|point2]] 
- Browser can now verify public key signed by CA
- ![](Pasted%20image%2020230531184228.png)

### Self Signed Certificate
- Your app will create Private & Public Key
- Your very own CA will create Private & Public Key
- App ask  own CA to sign CSR
- self-CA signs CSR and sends back to app
- Now instead of browser, 2nd app wants to interact with 1st App via HTTPS
- 2nd app finds public key of 1st app
- But since 1st app wasn't signed by authorised CA, its gonna give an error
- But But since its in your controlled environment
- 2nd app will find the own CA public key and certificate to validate 1st app 
- is basically source? Trust me bro


### Technical Overview
![[Pasted image 20240522145538.png]]


## Mutex and Sephamore

- Mutex is for ensuring mutual exclusion (one thread at a time)
	- exclusive access to a resource, like writing to a file or modifying a shared variable
- Semaphore is for controlling access to a finite number of resources
	- limited number of resources, like a pool of database connections, where several threads can use resources, but there's a limit to how many can be used simultaneously