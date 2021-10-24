#include <iostream>
#include <stdio.h>
#include <vector>

using namespace std;
//////

const
    int maxn=1e5+100;
int st, n, m;
bool exist[maxn];
vector<int> e[maxn];

vector<int> q;
int cou;
int num[maxn], low[maxn];
int coutp;
int id[maxn];
vector<int> tp[maxn];
int deg[maxn];
//////

void enter()
{
    scanf("%d%d", &n, &m);
    for (int i=1; i<=n; i++)
    {
        exist[i]=0;
        e[i].clear();
    }
    for (int i=1; i<=m; i++)
    {
        int x, y;
        scanf("%d%d", &x, &y);
        e[x].push_back(y);
        exist[x]=1; exist[y]=1;
    }
}
//////

void dfs(int u)
{
    cou++;
    num[u]=cou; low[u]=cou;
    q.push_back(u);
    for (int i=0; i<e[u].size(); i++)
    {
        int v=e[u][i];
        if (num[v]==0)
        {
            dfs(v);
            low[u]=min(low[u], low[v]);
        } else
        if (id[v]==0)
            low[u]=min(low[u], num[v]);
    }
    if (low[u]==num[u])
    {
        coutp++;
        int v;
        do
        {
            v=q.back(); q.pop_back();
            id[v]=coutp;
            tp[coutp].push_back(v);
        }
        while (v!=u);
    }
}
//////

void init()
{
    coutp=0;
    cou=0; q.clear();

    for (int i=1; i<=n; i++)
    {
        num[i]=0;
        low[i]=0;
        id[i]=0;
        tp[i].clear();
    }
    for (int i=1; i<=n; i++)
        if (exist[i] && num[i]==0) dfs(i);
}
//////

bool process()
{
    for (int i=1; i<=coutp; i++) deg[i]=0;
    for (int u=1; u<=n; u++)
        for (int i=0; i<e[u].size(); i++)
            if (id[u]!=id[e[u][i]]) deg[id[e[u][i]]]++;

    cou=0;
    int u;
    for (int i=1; i<=coutp; i++)
        if (deg[i]==0)
        {
            cou++;
            u=i;
        }
    do
    {
        if (cou>1) return 0;
        cou=0; int uu;
        for (int x=0; x<tp[u].size(); x++)
        {
            int u2=tp[u][x];
            for (int i=0; i<e[u2].size(); i++)
            {
                int v=e[u2][i];
                if (id[v]!=u)
                {
                    deg[id[v]]--;
                    if (deg[id[v]]==0)
                    {
                        cou++;
                        uu=id[v];
                    }
                }
            }
        }
        u=uu;
    }
    while (cou>=1);
    return 1;
}
//////

int main()
{
    freopen("sperfect.inp", "r", stdin);
    freopen("sperfect.out", "w", stdout);
    scanf("%d", &st);
    for (int i=1; i<=st; i++)
    {
        enter();
        init();
        bool res=process();
        if (res) cout << "YES"; else cout << "NO";
        cout << '\n';
    }
}
