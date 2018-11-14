---
layout: post
title: C++ 指针初始化的问题
categories: C++, poniter
description: 指针的函数调用与初始化问题
keywords: C++  pointer
---

### 谨记

正常情况下使用指针，为了防止编译器出现未知的行为，对指针进行初始化可以有效的防止程序中未知bug的出现。

现在下面有一个很小的程序。下述代码中，一个只声明而未初始化的指针，被一个函数调用，从而进行初始化。

*prog1.cpp*

```C++
#include <iostream>
using namespace std;
struct Node{
	int data;
	Node* next;
	Node(int ele):
		data(ele),
		next(nullptr)
		{}
};
void test(Node*& p){
//	p = NULL;
//	if(!p)
	p = new Node(10);
}
int main(){
	Node* p;
	test(p);
	cout << p->data << endl; // right 10
}
```

问题就在上述if(!p)中，我在自己的程序里，即使函数多次调用一个未初始化的指针，程序都不会出现问题。只要不对指针p进行判断(因为并未初始化，却可能随意指向内存中的任意位置)，可以多次将p指针传给下一个函数，却不会报错或者越界。一旦进行判断

```c++
if(!p)
    p = new Node(10)
```

此时就会有未知的情况发生，最后输出*p的值一直是1。

因此，对指针初始化，真的是一个血的教训。好的情况只是不符合预期而已，坏的情况则直接是越界报错。

![](https://github.com/lisongs1995/lisongs1995.github.io/blob/master/images/posts/c++-pointer/favicon.ico)

