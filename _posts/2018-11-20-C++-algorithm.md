---
layout: post
title: 最小生成树
categories: C++ algorithm 图论
description: prim算法与Kruskal算法
keywords: prim kruskal 图论 span-tree
---

## 最小生成树

在图论中，无向图G的生成树是具有G的全部顶点，但边数最小的子图。

而**[最小生成树](https://zh.wikipedia.org/wiki/%E6%9C%80%E5%B0%8F%E7%94%9F%E6%88%90%E6%A0%91)**是联通加权无向图中一棵权值最小的生成树。

在给定的无向图$G=(V,E)$中, $(u,v)$代表连接顶点$u$与顶点$v$的边(即$(u,v) \in E$), 而$w(u, v)$代表该边的权值, 若存在$T$为$E$的子集(即$T \in E$, 且$(V, T)$为树), 使得

​								$w(T) = \sum_{(u,v)\in T}{w(u,v)}$

的$w(T)$最小,  如下图所示, 则此$T$为$G$的最小生成树。

![最小生成树](https://upload.wikimedia.org/wikipedia/commons/thumb/d/d2/Minimum_spanning_tree.svg/300px-Minimum_spanning_tree.svg.png)

*应用 : 以有线电视电缆的架设为例,若只能沿着街道布线, 则以街道为边, 而路口为顶点, 其中必然有一最小生成树能使得布线成本最低。*

**从上述定义不难发现, 对于一个有$N$个顶点的连通图而言, 则最小生成树必然是包含$N$个顶点与$N-1$条边的联通子图, 并且$N-1$条边的权值之和最小。**

> 因此对于最小生成树的求解,一般有两个方向。
>
> * 从点入手, 对于N个顶点, 分别一个一个加入已知的集合中, 每次加入的时候都选择从已知集合到原始集合中其余点最近的边所邻接的顶点加入。(prim算法)
> * 从边入手, 最小生成树必然有$N-1$条边, 对这$N-1$条边排序, 然后每次选择最小的边加入到已知集合中, 确保一个规则, 就是每次加入边的同时必须确保不会形成环。(Kruskal 算法)

接下来就以prim算法与Kruskal算法为例, 讲解一下算法的实现过程.

### 图的定义

为了简化问题, 对实际问题进行快速建模, 此处假设使用的是邻接表, 但不对邻接表的数据结构进行定义, 只突出算法的概念。对图的定义, 使用树或者哈希表定义了一个图的依赖关系。

example: 0 --- 1 权值3 : 代表从顶点0与顶点1之间存在一条权值为3的边。

**C++**

```C++
#include <map>
typedef map<int, map<int, int> > Graph; // using Graph=map<int, map<int, int> >
```

**Python3**

```python
from collections import defaultdict
Graph = defaultdict(dict) # dict[int, dict[int, int]]
```

**运行环境**: 

> C++ : gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.10)
>
> Python3: Python 3.5.2

**机器**:

>  Linux omnisky 4.15.0-34-generic #37~16.04.1-Ubuntu SMP Tue Aug 28 10:44:06 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux

### prim算法

如上面所述。

- 初始化一个顶点, 作为最小生成树, 建立一个数组lowcost保存该顶点与其余各点的**距离**。
- 每次都找边权值最小的某个顶点加入最小生成树的集合,  并且将该边的信息存入adjvex数组中(使用下标i到adjvex[i]做一个顶点i与顶点adjvex[i]之间的映射)
- 加入该顶点后生成树到其余各点的距离改变, 因此需要更新lowcost数组信息。

```C++
#include <bits/stdc++.h>
#define INF INT_MAX   // climits.h
#define MAXVEX 4 //联通图中最多不超过的顶点数量
using namespace std;
typedef map<int, map<int, int> > Graph;
vector<pair<int, int> > prim(Graph& g, int vertexNum){
    int adjvex[MAXVEX]; //定义生成树中存在adjvex[i]到顶点i的一条边, 也就是生成树信息
    int lowcost[MAXVEX]; 
    vector<pair<int, int> > res;
    lowcost[0] = 0;
    adjvex[0] = 0;
    for(size_t i=1; i < vertexNum; i++){
        if(g[0].find(i) != g[0].end()) // 顶点0与顶点i是否存在边, 不存在则默认为无穷大
            lowcost[i] = G[0][i];
        else
            lowcost[i] = INF;
        adjvex[i] = 0; //默认初始时候只有顶点0, 从顶点0到其余各个顶点
    }
    for(size_t i=1; i<vertexNum; i++){
        int min = INT_MAX; //记录每次找到的最小权值边的权值
        int worker = 0; // 遍历节点临时变量
        int minIndex = 0; //最小权值的顶点
        while(worker < vertexNum) {
            if(lowcost[worker]!=0 && lowcost[worker] < min){
                min = lowcost[worker];
                minIndex = worker;
            }
            worker++;
        }
        lowcost[minIndex] = 0; //将minIndex加入到生成树集合中,所以生成树到该顶点的距离为0.
        printf("%d --> %d \n", adjvex[minIndex], minIndex);
        res.push_back(pair<int, int> (adjvex[minIndex], minIndex));
        for(auto it=G[minIndex].begin(); it!=G[minIndex].end(); it++){
            int to = it->first;
            int weight = it->second;
            if(lowcost[to]!=0 && weight<lowcost[to]){
                lowcost[to] = weight;
                adjvex[to] = minIndex;
            }
        }
    }
	return res;    
}

int main(){
    Graph g;
    int vertexNum = 4;
    g[0].insert(pair<int, int>(1,3));   
    g[0].insert(pair<int, int>(2,4));   
    g[1].insert(pair<int, int>(2,2));   
    g[1].insert(pair<int, int>(3,5));   
    g[2].insert(pair<int, int>(3,4));   
    g[3].insert(pair<int, int>(0,1));  
    prim(Graph& g, int vertexNum);
    return 0;
}
```

![1542683581764](/images/posts/span-tree/prim-cpp-output.jpg)





