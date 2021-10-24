#include <iostream>
#include <stdio.h>
#include <queue>

#define for(i,a,b) for (int i=a; i<=b; i++)

using namespace std;

const
    int maxn=250100, maxg=65536;

int t, n, k, k2;
int seed, mul ,add;
long long res;
int a[maxn], typ[maxn];

struct cmpMax
{
    bool operator()(int x, int y) {return a[x]<a[y];}
};

struct cmpMin
{
    bool operator()(int x, int y) {return a[x]>a[y];}
};

int nheap1, nheap2;
priority_queue<int, vector<int>, cmpMax> heap1;
priority_queue<int, vector<int>, cmpMin> heap2;

void enter()
{
    scanf("%d%d%d%d%d", &seed, &mul, &add, &n, &k);
    a[1]=seed;
    for(i,2,n)
        a[i]=((long long)(a[i-1])*mul+add)%maxg;
    //for(i,1,n) scanf("%d", &a[i]);
    k2=(k+1)/2;
}

void pr()
{
   priority_queue<int, vector<int>, cmpMax> q=heap1;
   while (!q.empty())
   {
        cout << q.top() << ' ';
        q.pop();
   }
   cout << '\n';
}

void pr2()
{
   priority_queue<int, vector<int>, cmpMin> q=heap2;
   while (!q.empty())
   {
        cout << q.top() << ' ';
        q.pop();
   }
   cout << '\n';
}

void process()
{
    res=0;
    nheap1=0; nheap2=0;

    while (!heap1.empty()) heap1.pop();
    while (!heap2.empty()) heap2.pop();

    typ[0]=0;
    for(i,1,k-1)
    {
        heap1.push(i); nheap1++; typ[i]=1;

        if (nheap1>k2)
        {
            int x=heap1.top();
            heap2.push(x); nheap2++; typ[x]=2;
            heap1.pop(); nheap1--;
        }
    }
    //pr();
    for(i,k,n)
    {
        if (typ[i-k]==1) nheap1--; else
        if (typ[i-k]==2) nheap2--;

        heap1.push(i); nheap1++; typ[i]=1;

        while (nheap1>k2)
        {
            while (heap1.top()<=i-k) heap1.pop();
            int x=heap1.top();
            heap2.push(x); nheap2++; typ[x]=2;
            heap1.pop(); nheap1--;
        }
        //pr(); pr2();
        do
        {
            while (heap1.top()<=i-k) heap1.pop();
            while (!heap2.empty() && heap2.top()<=i-k) heap2.pop();
            if (!heap2.empty() && a[heap1.top()]>a[heap2.top()])
            {
                int x=heap1.top(); heap1.pop();
                int y=heap2.top(); heap2.pop();
                heap1.push(y); typ[y]=1;
                heap2.push(x); typ[x]=2;
            }
            else break;
            //pr(); pr2();
        }
        while (true);
        res+=a[heap1.top()];
    }
}

int main()
{
    freopen("median.inp", "r", stdin);
    //freopen("median.out", "w", stdout);
    scanf("%d", &t);
    for(i,1,t)
    {
        enter();
        process();
        cout << "Case #" << i << ": " << res << '\n';
    }
    return 0;
}
