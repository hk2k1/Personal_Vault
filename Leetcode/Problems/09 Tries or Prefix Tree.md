- A special type of tree that is basically a dictionary/hashmap of a charcter with hashmap of every character as the children

```
                (root)
               /      \
              a        b
             /         \
            p           a
           / \           \
          p   t           l
         /     \           \
        l       a           l
       /         \           \
      e           l           t
                  \
                   t
```

```json
trie = {
    'a': {
        'p': {
            'p': {
                'l': {
                    'e': {
                        '#': True  # End of word marker
                    }
                },
                '#': True  # End of word marker for "app"
            }
        }
    },
    'b': {
        'a': {
            't': {
                '#': True  # End of word marker
            },
            'l': {
                'l': {
                    '#': True  # End of word marker
                }
            }
        }
    }
}
```

## Initialization of Trie

```python
class TrieNode:
	def __init__(self):
		self.children = {}
		self.is_End = False

class Trie:
	def __init__(self):
		self.root = TrieNode()
```

## Insert

```python
def insert(self, word:str) ->None:
	node = self.root
	for char in word:
		if char not in node.children:
			node.children[char] = TrieNode()
		node = node.children[char]
	node.is_End = True
```

## Search

```python
def search(self, word: str)-> bool:
	node = self.root
	for char in word:
		if char not in node.children:
			return False
		node = node.children[char]
	return node.is_End
```

## StartsWith

```python
def startsWith(self, prefix:str)-> bool:
	node = self.root
	for char in prefix:
		if char not in node.children:
			return False
		node = node.children[char]
	return True
```

## [208. Implement Trie (Prefix Tree)](https://leetcode.com/problems/implement-trie-prefix-tree/)

```python
class TrieNode:
    def __init__(self):
        self.children = {}
        self.is_End = False

class Trie:
    def __init__(self):
        self.root = TrieNode()
        
    def insert(self, word:str)-> None:
        node = self.root
        for char in word:
            if char not in node.children:
                node.children[char] = TrieNode()
            node = node.children[char]
        node.is_End = True
            
    def search(self, word: str) -> bool:
        node = self.root
        for char in word:
            if char not in node.children:
                return False
            node = node.children[char]
        return node.is_End
        


    def startsWith(self, prefix: str) -> bool:
        node = self.root
        for char in prefix:
            if char not in node.children:
                return False
            node = node.children[char]
        return True



# Your Trie object will be instantiated and called as such:
# obj = Trie()
# obj.insert(word)
# param_2 = obj.search(word)
# param_3 = obj.startsWith(prefix)
```