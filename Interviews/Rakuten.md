### Coding Questions
- Missing Integer return the smallest integer which is not present within an array
- Reverse an array in place\
-  two sum
- determine whether the given string is an odd or even number
- shift elements of a single dimensional array in the right direction by one position
- Write a function that takes in a string input and return the first non repeating character
-  Core JavaScript Questions
- Data structures questions
- REST API and microservices design
- Database normalization.
- ![[Pasted image 20240712120736.png]]
- ![[Pasted image 20240712120743.png]]

```python
def solution(A, B, C):
    counts = [['a', A], ['b', B], ['c', C]]
    result = []

    while True:
        # Sort characters based on their counts in descending order
        counts.sort(key=lambda x: -x[1])
        
        # Check if the first character in the sorted list can be added
        added = False
        for i in range(3):
            if counts[i][1] == 0:
                break
            if len(result) >= 2 and result[-1] == result[-2] == counts[i][0]:
                continue
            result.append(counts[i][0])
            counts[i][1] -= 1
            added = True
            break
        
        if not added:
            break

    return ''.join(result)

# Test cases
print(solution(6, 1, 1))  # Possible output: "aabaacaa"
print(solution(1, 3, 1))  # Possible outputs: "abbcb", "bacbb", etc.
print(solution(0, 1, 8))  # Output: "cbcbcbcbcbcbcbc"

```

## Behaviour Questions
- what do you see yourself in 5 years?
- how do you handle pressure ?
- A difficult situation you encountered and how you resolved it /challenge
- Why Rakuten? Why software engineer?
- Experience with learning a new language
- What is your greatest strength and how you leverage your strength for peak performance? Please give us an example.
- What are your career goal and career plans? How does this job fit into your career plans?

### Points
- your technology seems to align with my skill set and I am hoping it would be an opportunity for me to grow 
- I want to work on interesting problems with good people. The industry you're in and the products you offer
- a positive working environment is the best way to improve my skills and stay engaged with other professionals in my field


### Tell me about yourself
- Summarise myself I love to learn, code and grow
- I am in my final year studying computer engineering graduating around end of august
- I took this academic path so that I can learn about both hardware and software domains and choose my career path from that
- During my course, I learnt about python and c++ and got a couple of certifications along the way
- My first internship was at Continental Automotive which is in the automotive industry
	- Although it was my first time getting hands on experience, I was tasked to handle a part of larger project
	- At the end of my internship, I completed it successfully and it was presented to Conti's Business Unit
- In my second internship at MediaTek which is in the Semiconductor Industry
	- My role can be summarised into 2 things
		- Web Development and Scripting
	- A few key things that I did
		- Created and managed intranet websites using Content Management Systems
		- Due to some company policy restrictions, things like GitHub were firewall blocked at MediaTek, so I helped my team in setting up a local git server that could be accessed only by our internal staff
		- With this I created a CI/CD pipeline for collaboration and to automate the push of our changes to production servers
		- Learnt a lot of new stuff like cms, reactjs, nextjs and i am using that knowledge to do my final year project 
- And now, I would like the opportunity to start my career at Rakuten

### Why Rakuten? Why software engineer?

- Rakuten's reputation as a leading global innovation company, particularly in e-commerce, fintech, and digital content, is something that I believe I can apply my skills to impactful projects
- I was also quite intrigued about Rakuten's dedication to employee development like
	- training programs like the grade based training programs
	- Hosting tech talks like the recent Apache Kafka Meetup 
- I believe these will help in improving my skills and contribute effectively to the company.
- Rakuten’s technology stack, which includes tools and languages such as Java, Python, React, Kubernetes, and Spark, matches my skill set perfectly. 
- That's why I want to work at Rakuten will provide me opportunities for growth and learning new technologies.

### What do you know about Global Ad Technology Department

- From my research on it, I believe its responsible for developing, maintaining, and improving Rakuten's advertising platform and data-driven marketing solutions. 
- These solutions support both internal and external stakeholders, ensuring that Rakuten's advertising strategies are effective and efficient.
- they develop the Rakuten Marketing Platform, not just for the buyer but also the seller
- I saw a few key things that were developed for the platform like
	- user search linked advertisements, suggest products based on user search behaviour
	- Super point where users can earn points by viewing advertisements
- And things like these makes it exciting to be part of

### Overcome a challenge, and what did you learn from that experience?

During my internship at MediaTek, I had to setup a tool for my team to work with. But the challenge was this tool was blocked by my organization and to a request would take too long. This tool was important for our development of websites. From in depth debugging, I found out the tool was actually requesting to some GitHub APIs. So, I curled the request to find out that these requests were not flowing through a proper SSL certificate setup by the organization. Prior to this, my previous task involved configuring SSL certificates to make our intranet websites encrypted. That task helped me to understand about encryption and realise the challenge i was facing. After endless debugging and finding the root cause, I was able to configure the proper SSL Certificate approved by MediaTek and used it to configure the tool. Finally, the tool was able to work, and team were happy to use it. 

Key takeway from these is to learn from the tasks done and not get overwhelmed by the endless debugging sessions 
asking questions like "why?" it helped me get to the root cause and solving the problem would rather become easier


### What do you see yourself in 5 years? Career Goals?

I want to grow as a professional in the industry and specialize in my technical skills and become an expert. I want to eventually move into a Full stack development role where I can tackle more challenges with the experience I gained.

I’m really excited about the digital advertising industry space. I hope that in five years, I’m continuing to get better at skills and learning more about how to become an expert in whole process of application life cycle


### how do you handle pressure ?

What you need to say is what they want to hear and you show an example of:
- Assess the situation
- Understand it
- Gathered info
- Prioritize
- Get assistance
- Make a decision
- Follow through
- Follow up 
- Keep records
- Adjust as needed

### Strengths & Weaknesses
- Organisational Skills
- I believe this is what got me through University
- Started out with around 4.0 gpa in my Trimester 1
- As University progressed, I fine tuned how I basically work
- How I time manage myself.
- Prepare notes ahead of time
- I believe these helped me to improve my gpa
- I believe with my work ethic, I can achieve first class honours when I graduate
- On top of that I have good problem solving skills and debugging skills
- I believe these would help me during the internship and contribute to the success of the project.

Too engrossed into what im doing without taking a step back.