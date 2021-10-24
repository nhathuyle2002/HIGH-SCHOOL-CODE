#include <iostream>
#include <stdio.h>
#include <vector>
#include <deque>

using namespace std;
///////

const
    int maxn=1e5+100;
int n, m;
vector<int> e[maxn];
int w[maxn], deg[maxn];
deque<int> q;
long long res[maxn];
long long maxr;
///////

void enter()
{
    scanf("%d%d\n", &n, &m);
    for (int i=1; i<=n; i++) scanf("%d\n", &w[i]);
    for (int i=1; i<=m; i++)
    {
        int u, v;
        scanf("%d%d", &u, &v);
        e[u].push_back(v);
        deg[v]++;
    }
}
///////

void process()
{
    q.clear();
    for (int i=1; i<=n; i++)
    {
        res[i]=1;
        if (deg[i]==0) q.push_back(i);
    }
    while (!q.empty())
    {
        int u=q.front(); q.pop_front();
        for (int i=0; i<e[u].size(); i++)
        {
            int v=e[u][i];
            res[v]=max(res[v], res[u]+w[u]);
            deg[v]--;
            if (deg[v]==0) q.push_back(v);
        }
    }
    maxr=0;
    for (int i=1; i<=n; i++)
    {
        if (deg[i]>0)
        {
            maxr=-1;
            return;
        } else
        maxr=max(maxr, res[i]+w[i]-1);
    }
}
///////

int main()
{
    freopen("schedule.inp", "r", stdin);
    freopen("schedule.out", "w", stdout);
    enter();
    process();
    cout << maxr << '\n';
    if (maxr!=-1)
        for (int i=1; i<=n; i++) cout << res[i] << '\n';
}
