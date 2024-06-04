## [226. Invert Binary Tree](https://leetcode.com/problems/invert-binary-tree/)

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def invertTree(self, root: Optional[TreeNode]) -> Optional[TreeNode]:
        if root is None:
            return None
        queue = [root]
        while queue:
            curr = queue.pop(0)
            curr.right, curr.left = curr.left, curr.right
            if curr.left is not None:
                queue.append(curr.left)
            if curr.right is not None:
                queue.append(curr.right)
        return root
```

## [104. Maximum Depth of Binary Tree](https://leetcode.com/problems/maximum-depth-of-binary-tree/)

```python
class Solution:
    # Recursive
    def maxDepth(self, root: Optional[TreeNode]) -> int:
        if root is None:
            return 0
        else:
            lDepth = self.maxDepth(root.left)
            rDepth = self.maxDepth(root.right)
        if lDepth > rDepth:
            return lDepth + 1
        else:
            return rDepth + 1
    # Iterative DFS
    def maxDepth(self, root: Optional[TreeNode]) -> int:
        if not root:
            return 0
        stack = [[root, 1]]
        res = 1
        while stack: 
            node, depth = stack.pop()
            if node:
                res = max(res, depth)
                stack.append([node.left, depth+1])
                stack.append([node.right, depth+1])
        return res
```


## [543. Diameter of Binary Tree](https://leetcode.com/problems/diameter-of-binary-tree/)

```python
class Solution:
    def __init__(self):
        self.diameter = 0
    def depth(self, node: Optional[TreeNode]) -> int:
            left = self.depth(node.left) if node.left else 0
            right = self.depth(node.right) if node.right else 0
            self.diameter = max(self.diameter, left+right)
            return 1 + max(left, right)
    def diameterOfBinaryTree(self, root: Optional[TreeNode]) -> int:
        self.depth(root)
        return self.diameter
```

## [110. Balanced Binary Tree](https://leetcode.com/problems/balanced-binary-tree/)'

```python
class Solution:
    def depth(self, node: Optional[TreeNode]) -> bool:
        if node is None:
            return 0
        else:
            leftMax = self.depth(node.left)
            rightMax = self.depth(node.right)
            if leftMax == -1 or rightMax == -1 or abs(leftMax-rightMax) > 1:
                return -1
            return 1 + max(leftMax, rightMax)

    def isBalanced(self, root: Optional[TreeNode]) -> bool:
        check = self.depth(root)
        return check != -1
```


## [100. Same Tree](https://leetcode.com/problems/same-tree/)

```python
class Solution:
    # Iterative BFS
    def isSameTree(self, p: Optional[TreeNode], q: Optional[TreeNode]) -> bool:
        queue = [(p,q)]
        while queue:
            nodeP, nodeQ = queue.pop(0)
            if not nodeP and not nodeQ:
                continue
            elif nodeP is None or nodeQ is None:
                return False
            else:
                if nodeP.val != nodeQ.val:
                    return False
                queue.append((nodeP.left, nodeQ.left))
                queue.append((nodeP.right, nodeQ.right))
        return True
    # Recursive
    def isSameTree(self, p: Optional[TreeNode], q: Optional[TreeNode]) -> bool:
        if p and q:
            return p.val == q.val and self.isSameTree(p.left, q.left) and self.isSameTree(p.right, q.right)
        else:
            return p == q
```

## [572. Subtree of Another Tree](https://leetcode.com/problems/subtree-of-another-tree/)

```python
class Solution:
    def isSameTree(self, r: Optional[TreeNode], s: Optional[TreeNode]) -> bool:
        if r and s:
            return r.val == s.val and self.isSameTree(r.left, s.left) and self.isSameTree(r.right, s.right)
        else:
            return r == s
    def isSubtree(self, root: Optional[TreeNode], subRoot: Optional[TreeNode]) -> bool:
        if self.isSameTree(root, subRoot):
            return True
        if not root:
            return False
        return (self.isSubtree(root.left, subRoot)) or (self.isSubtree(root.right, subRoot))
```

## [235. Lowest Common Ancestor of a Binary Search Tree](https://leetcode.com/problems/lowest-common-ancestor-of-a-binary-search-tree/)

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def lowestCommonAncestor(self, root: 'TreeNode', p: 'TreeNode', q: 'TreeNode') -> 'TreeNode':
        if not root:
            return 0
        stack = [root]
        while stack:
            curr = stack.pop()
            if curr.val > p.val and curr.val > q.val:
                stack.append(curr.left)
            elif curr.val < p.val and curr.val < q.val:
                stack.append(curr.right)
            else:
                return curr
```

## [102. Binary Tree Level Order Traversal](https://leetcode.com/problems/binary-tree-level-order-traversal/)

>Loop around the size of the queue for each level
>and not just the entire tree itself

```python
class Solution:
    def levelOrder(self, root: Optional[TreeNode]) -> List[List[int]]:
        if not root:
            return []
        queue = [root]
        res = []
        while queue:
            level, size = [], len(queue)
            for _ in range(size):
                curr = queue.pop(0)
                level.append(curr.val)
                if curr.left is not None:
                    queue.append(curr.left)
                if curr.right is not None:
                    queue.append(curr.right)
            res.append(level)
        return res
```

## [199. Binary Tree Right Side View](https://leetcode.com/problems/binary-tree-right-side-view/)

`my first solution i do myself`

```python
class Solution:
    def rightSideView(self, root: Optional[TreeNode]) -> List[int]:
        if not root:
            return None
        queue = [root]
        res = []
        while queue:
            level, size = [], len(queue)
            for _ in range(size):
                curr = queue.pop(0)
                level.append(curr.val)
                if curr.left is not None:
                    queue.append(curr.left)
                if curr.right is not None:
                    queue.append(curr.right)
            res.append(level.pop())
        return res
```

## [1448. Count Good Nodes in Binary Tree](https://leetcode.com/problems/count-good-nodes-in-binary-tree/)

> Get max through DFS LIFO STACK
> increase the counter if curr val > the max

```python
class Solution:
    def goodNodes(self, root: TreeNode) -> int:
        stack = [[root, root.val]]
        res = 0
        while stack: 
            curr, currMax = stack.pop()
            if curr:
                currMax = max(curr.val, currMax)
                if curr.val >= currMax:
                    res += 1
                stack.append([curr.left, currMax])
                stack.append([curr.right, currMax])
        return res
```

## [98. Validate Binary Search Tree](https://leetcode.com/problems/validate-binary-search-tree/)

>Check current node value: Ensure the current node's value is within the bounds (lower < node.val < upper). R
>Recursively validate left and right subtrees: 
>	The left subtree should be valid with an updated upper bound. 
>	The right subtree should be valid with an updated lower bound.

```python
class Solution:
    def isValidBST(self, root: Optional[TreeNode], lower=float('-inf'), upper=float('inf')) -> bool:
        if not root:
            return True
        
        if root.val <= lower or root.val >= upper:
            return False
        
        if not self.isValidBST(root.right, root.val, upper):
            return False
        if not self.isValidBST(root.left, lower, root.val):
            return False
        return True
```


