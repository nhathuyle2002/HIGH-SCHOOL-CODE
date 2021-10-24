#include <iostream>
#include <stdio.h>
#include <algorithm>

using namespace std;
//////

struct data
{
    int x, y, w;
};
bool comp(data a, data b)
{
    return a.w<b.w;
}

const
    int maxn=1e4+100, maxm=1e6+100;

int n, m;
data e[maxm];
int root[maxn], h[maxn];
int res;
//////

void enter()
{
    scanf("%d%d", &n, &m);
    for (int i=1; i<=m; i++)
        scanf("%d%d%d", &e[i].x, &e[i].y, &e[i].w);
    sort(e+1, e+m+1, comp);
}
//////

int findroot(int p)
{
    while (root[p]!=p) p=root[p];
    return p;
}

void process()
{
    for (int i=1; i<=n; i++)
    {
        root[i]=i;
        h[i]=0;
    }

    res=0;
    int cou=0;
    for (int i=1; i<=m; i++)
    {
        int x0=findroot(e[i].x), y0=findroot(e[i].y);
        if (x0==y0)
        {
            root[e[i].x]=x0; root[e[i].y]=y0;
        } else
        {
            res+=e[i].w;
            cou++;
            if (h[x0]<h[y0])
            {
                root[x0]=y0; root[e[i].x]=y0; root[e[i].y]=y0;
                //h[y0]=max(h[y0], h[x0]+1);
            } else
            {
                root[y0]=x0; root[e[i].x]=x0; root[e[i].y]=x0;
                h[x0]=max(h[x0], h[y0]+1);
            }
        }
        if (cou==n-1) break;
    }
    cout << res;
}
//////

int main()
{
    freopen("network.inp", "r", stdin);
    freopen("network.out", "w", stdout);
    enter();
    process();
}
