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
- 