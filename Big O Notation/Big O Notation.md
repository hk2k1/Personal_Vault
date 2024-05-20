## O(1)
![[Pasted image 20240123173756.png]]
![[Pasted image 20240123173835.png]]
Constant time to do an operation
Constant time for a constant number
## O(n)
![[Pasted image 20240123173930.png]]
Linear Growth Scenario 
As Input increases, time increases
![[Pasted image 20240123173959.png]]

## O(n^2)
2D Array Nested Loops
![[Pasted image 20240123175052.png]]
![[Pasted image 20240123175254.png]]n^2 is a full square
(n^2)/2 is half square

![[Pasted image 20240123175320.png]]
n.m
![[Pasted image 20240123175437.png]]

## O(n^3)
rare
![[Pasted image 20240123175523.png]]

## O(logn)
![[Pasted image 20240123175548.png]]
Binary Search
Pushing and Popping from a heap

### Explanation:
- Every Iteration of the loop we are eliminating half of the elements of the loop
- Given an array of size n, how many times are we dividing by 2 until we get 1
	- ![[Pasted image 20240123175758.png]]
- OR
- How many times can we take the value of 1 and multiply by 2 until we get n 
	- which means 1x2 -> n
	- 2^x = n
	- x = log n
- exponential decreases

Difference between log n and O (n) is massive
log n is almost close the x axis

## O(2^n)
is like the reflection of log n over the y axis
![[Pasted image 20240123180341.png]]

## O(sqrt n)
Between 1 and sqrt of n
![[Pasted image 20240123180955.png]]

## O(n!)
n factorial
![[Pasted image 20240123181052.png]]
5! = 5x4x3x2x1

## O(nlog n)
![[Pasted image 20240123181429.png]]