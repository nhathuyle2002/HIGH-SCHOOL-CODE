#include <iostream>
#include <stdio.h>
#include <stack>
#include <vector>

#define for(i,a,b) for (int (i)=(a); (i)<=(b); (i)++)

using namespace std;

const
    int maxn=10010;

int n,m,t;
vector<int> e[maxn];
int cou;
int num[maxn], low[maxn], d[maxn];
stack<int> q;
int coutp;
int id[maxn], deg[maxn];
int res;

void enter()
{
    scanf("%d%d%d", &n, &m, &t);
    for(i,1,m)
    {
        int u,v;
        scanf("%d%d", &u, &v);
        e[u].push_back(v);
    }
}

void dfs(int u)
{
    d[u]=1;
    cou++; num[u]=cou; low[u]=cou;
    q.push(u);
    for(i,0,int(e[u].size())-1)
    {
        int v=e[u][i];
        if (d[v]==0)
        {
            dfs(v);
            low[u]=min(low[u],low[v]);
        } else
        if (d[v]==1)
            low[u]=min(low[u],num[v]);
    }
    if (low[u]==num[u])
    {
        coutp++;
        int v;
        do
        {
            v=q.top();
            d[v]=-1;
            id[v]=coutp;
            q.pop();
        }
        while (v!=u);
    }
}

void process()
{
    cou=0; coutp=0;
    for(i,1,n)
        if (d[i]==0) dfs(i);
    for(i,1,coutp) deg[i]=0;
    for(u,1,n)
        if (id[u]!=id[t])
        for(i,0,int(e[u].size())-1)
        {
            int v=e[u][i];
            if (id[u]!=id[v]) deg[id[u]]++;
        }
    res=0;
    for(i,1,coutp)
        if (deg[i]==0) res++;
    cout << res-1;
}

int main()
{
    enter();
    process();
    return 0;
}
