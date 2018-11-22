---
layout: post
title: leetcode 133. Clone Graph
categories: leetcode Graph
description: Graph DeepCopy
keywords: Graph leetcode
---

Given the head of a graph, return a deep copy (clone) of the graph. Each node in the graph contains a label (int) and a list (List[UndirectedGraphNode]) of its neighbors. There is an edge between the given node and each of the nodes in its neighbors.


OJ's undirected graph serialization (so you can understand error output):
Nodes are labeled uniquely.

We use # as a separator for each node, and , as a separator for node label and each neighbor of the node.
 

As an example, consider the serialized graph {0,1,2#1,2#2,2}.

The graph has a total of three nodes, and therefore contains three parts as separated by #.

First node is labeled as 0. Connect node 0 to both nodes 1 and 2.
Second node is labeled as 1. Connect node 1 to node 2.
Third node is labeled as 2. Connect node 2 to node 2 (itself), thus forming a self-cycle.
 

Visually, the graph looks like the following:

       1
      / \
     /   \
    0 --- 2
         / \
         \_/

**Note**: The information about the tree serialization is only meant so that you can understand error output if you get a wrong answer. You don't need to understand the serialization to solve the problem.

Quickly get started [leetcode 133: clone graph](https://leetcode.com/problems/clone-graph/description/)

### Solution
#### c++
```c++
/**
 * Definition for undirected graph.
 * struct UndirectedGraphNode {
 *     int label;
 *     vector<UndirectedGraphNode *> neighbors;
 *     UndirectedGraphNode(int x) : label(x) {};
 * };
 */
#include <bits/sdtc++.h>
using namespace std;
typedef UndirectedGraphNode node_t;
class Solution {
public:
    unordered_map<int, node_t*> seen;
    UndirectedGraphNode *cloneGraph(UndirectedGraphNode *node) {
        if(!node)
            return nullptr;
        return helper(node);
    }
    UndirectedGraphNode *helper(UndirectedGraphNode *node){
        auto it=seen.find(node->label);
        if(it!=seen.end())
            return it->second;
        UndirectedGraphNode* copy = new UndirectedGraphNode(node->label);
        seen[copy->label] = copy;
        for(auto nb: node->neighbors){
            copy->neighbors.push_back(helper(nb));
        }
        return copy;
    }
};
```
#### Python2 

```python
 # Definition for a undirected graph node
 # class UndirectedGraphNode:
 #     def __init__(self, x):
 #         self.label = x
 #         self.neighbors = []

class Solution:
    # @param node, a undirected graph node
    # @return a undirected graph node
    
    def cloneGraph(self, node):
        seen = {}
        if not node:
            return None
        return self.helper(node, seen)
    
    def helper(self, node, seen):
        if node.label in seen:
            return seen[node.label]
        copy =  UndirectedGraphNode(node.label)
        seen[copy.label] = copy
        for nb in node.neighbors:
            copy.neighbors.append(self.helper(nb, seen))
        return copy
```
