#include <iostream>
#include <stdio.h>
#include <algorithm>

using namespace std;
//////

const
    int maxn=4e3+10, maxm=1e4+10, maxq=8e4+10;
struct data
{
    int x, y, w;
    bool operator < (const data &A) const {return w<A.w;}
};
int T, n, m, q;
data a[maxm];
data b[maxq];
int root[maxn], h[maxn], child[maxn];
int res[maxq];
//////

void enter()
{
    scanf("%d%d%d\n", &n, &m, &q);

    for (int i=1; i<=m; i++)
        scanf("%d%d%d\n", &a[i].x, &a[i].y, &a[i].w);
    sort(a+1, a+m+1);

    for (int i=1; i<=q; i++)
    {
        scanf("%d%d\n", &b[i].x, &b[i].w);
        b[i].y=i;
    }
    sort(b+1, b+q+1);
}
//////

int findroot(int p)
{
    while (root[p]!=p) p=root[p];
    return p;
}

void process()
{
    for (int u=1; u<=n; u++)
    {
        root[u]=u; h[u]=0;
        child[u]=1;
    }
    int k=1;
    for (int i=1; i<=m; i++)
    {
        while (k<=q && b[k].w<a[i].w)
        {
            res[b[k].y]=child[findroot(b[k].x)];
            k++;
        }
        int x=findroot(a[i].x), y=findroot(a[i].y);
        if (x==y)
        {
            root[a[i].x]=x; root[a[i].y]=x;
        } else
        if (h[x]<h[y])
        {
            root[x]=y; root[a[i].x]=y; root[a[i].y]=y;
            //h[y]=max(h[y], h[x]+1);
            child[y]+=child[x];
        } else
        if (h[x]>=h[y])
        {
            root[y]=x; root[a[i].x]=x; root[a[i].y]=x;
            h[x]=max(h[x], h[y]+1);
            child[x]+=child[y];
        }
    }
    while (k<=q)
    {
        res[b[k].y]=child[findroot(b[k].x)];
        k++;
    }
    for (int i=1; i<=q; i++) cout << res[i] << '\n';
}
//////

int main()
{
    freopen("emotor.inp", "r", stdin);
    freopen("emotor.out", "w", stdout);
    scanf("%d\n", &T);
    while (T--)
    {
        enter();
        process();
    }
}
