#include <iostream>
#include <stdio.h>
#include <algorithm>
#include <vector>

using namespace std;
//////

struct data
{
    int pos, y;
    double w;
    bool operator < (const data &A) const {return w>A.w;}
};
data make_data(int v, double w, int pos)
{
    data p;
    p.y=v; p.w=w; p.pos=pos;
    return p;
}

const
    int maxn=1e4+100;
int n, k, v1, v2;
vector<data> e[maxn];
int child[maxn];
bool d[maxn];
vector<data> q;
//////

void enter()
{
    scanf("%d%d%d%d\n", &n, &k, &v1, &v2);
    for (int i=1; i<n; i++)
    {
        int u, v;
        double w;
        scanf("%d%d%lf\n", &u, &v, &w);
        e[u].push_back(make_data(v, w, i));
        e[v].push_back(make_data(u, w, i));
    }
}
//////

void dfs(int u)
{
    d[u]=false; child[u]=1;
    for (int i=0; i<e[u].size(); i++)
    {
        data p=e[u][i];
        if (d[p.y])
        {
            dfs(p.y);
            q.push_back(make_data(0, (p.w/v1-p.w/v2)*child[p.y]*(n-child[p.y]), p.pos));
            child[u]+=child[p.y];
        }
    }
}

void process()
{
    for (int u=1; u<=n; u++) d[u]=true;
    q.clear();
    dfs(1);
    sort(q.begin(), q.end());
    for (int i=1; i<n; i++) d[i]=true;
    for (int i=0; i<k; i++) d[q[i].pos]=false;
    for (int i=1; i<n; i++)
        if (!d[i]) cout << i << '\n';
}
//////

int main()
{
    freopen("bridges.inp", "r", stdin);
    freopen("bridges.out", "w", stdout);
    enter();
    process();
}
