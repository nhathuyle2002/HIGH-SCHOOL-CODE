#include <iostream>
#include <stdio.h>
#include <vector>

using namespace std;
////////

struct data
{
    int y, w;
    data (int _y, int _w):y(_y), w(_w) {}
};

const   int maxn=1e4+100;
int n;
int pos1[maxn], pos2[maxn];
vector<data> e[maxn];
int id[maxn];
int res1, res2, cou0, cou1;
////////

void enter()
{
    scanf("%d\n", &n);
    int x;
    for (int i=1; i<=n; i++)
    {
        scanf("%d", &x);
        if (pos1[x]!=0)
        {
            e[i].push_back(data(pos1[x], 1));
            e[pos1[x]].push_back(data(i, 1));
        } else
        pos1[x]=i;
    }
    scanf("\n");
    for (int i=1; i<=n; i++)
    {
        scanf("%d", &x);
        if (pos2[x]!=0)
        {
            e[i].push_back(data(pos2[x], 1));
            e[pos2[x]].push_back(data(i, 1));
        } else
        pos2[x]=i;
    }
    for (int i=1; i<=n; i++)
        if (pos1[i]>0 && pos2[i]>0)
    {
        e[pos1[i]].push_back(data(pos2[i], 0));
        e[pos2[i]].push_back(data(pos1[i], 0));
    }
}
////////

void dfs(int u, int k)
{
    id[u]=k;
    if (k==0) cou0++; else cou1++;
    for (int i=0; i<e[u].size(); i++)
    {
        data v=e[u][i];
        if (id[v.y]==-1)
        {
            if (v.w==1) dfs(v.y, 1-k);
            else dfs(v.y, k);
        }
    }
}

void process()
{
    for (int i=1; i<=n; i++) id[i]=-1;
    res1=1; res2=0;
    for (int i=1; i<=n; i++)
        if (id[i]==-1)
    {
        cou0=0; cou1=0;
        dfs(i, 0);
        res2=res2+min(cou0, cou1);
        if (cou0+cou1>1) res1=res1*2;
    }
    cout << res1 << ' ' << res2;
}
////////

int main()
{
    freopen("double15.inp", "r", stdin);
    freopen("double15.out", "w", stdout);
    enter();
    process();
}
