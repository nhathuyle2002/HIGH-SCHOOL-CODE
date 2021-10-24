#include <iostream>
#include <stdio.h>

using namespace std;
//////

const
    int maxn=5e3+100;

int n, m;
int deg[maxn], d[maxn];
//////

int distan(int i, int j)
{
    if (i<=j) return j-i; else return j+n-i;
}

void enter()
{
    scanf("%d%d", &n, &m);
    for (int i=1; i<=m; i++)
    {
        int x, y;
        scanf("%d%d", &x, &y);
        deg[x]++;
        if (d[x]==0) d[x]=distan(x, y); else
        d[x]=min(d[x], distan(x, y));
    }
    for (int i=1; i<=n; i++)
        d[i]=d[i]+(deg[i]-1)*n;
}
//////

void process()
{
    for (int i=1; i<=n; i++)
    {
        int res=0;
        for (int j=1; j<=n; j++)
            res=max(res, distan(i, j)+d[j]);
        cout << res << ' ';
    }
}
//////

int main()
{
    enter();
    process();
}
