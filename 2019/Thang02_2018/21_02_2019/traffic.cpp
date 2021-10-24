#include <iostream>
#include <stdio.h>
#include <vector>
#include <utility>

using namespace std;
///////

typedef pair<int, int> pii;

const
    int maxn=1e5+100, maxm=2e5+100;
int n, m, coutp;
vector<int> e[maxn], e2[maxn];
int cou;
vector<int> q;
int num[maxn], low[maxn], id[maxn];
int lab[maxn];
vector<int> tp[maxn];
bool noI[maxn], noO[maxn];
vector<pii> ot;
///////

void enter()
{
    scanf("%d%d", &n, &m);
    for (int i=1; i<=m; i++)
    {
        int u, v;
        scanf("%d%d", &u, &v);
        e[u].push_back(v);
    }
}
///////

void dfstp(int u)
{
    cou++;
    num[u]=cou; low[u]=cou;
    q.push_back(u);
    for (int i=0; i<e[u].size(); i++)
    {
        int v=e[u][i];
        if (num[v]==0)
        {
            dfstp(v);
            low[u]=min(low[u], low[v]);
        } else
        if (id[v]==0)
            low[u]=min(low[u], num[v]);
    }
    if (low[u]==num[u])
    {
        coutp++;
        lab[coutp]=u;
        int v;
        do
        {
            v=q.back();
            id[v]=coutp;
            tp[coutp].push_back(v);
            q.pop_back();
        }
        while (v!=u);
    }
}

void nentp()
{
    cou=0; coutp=0;
    q.clear();
    for (int u=1; u<=n; u++)
    {
        num[u]=0;
        id[u]=0;
    }
    for (int u=1; u<=n; u++)
        if (num[u]==0) dfstp(u);
    for (int i=1; i<=n; i++)
    {
        e2[i]=e[i];
        e[i].clear();
    }
    for (int u=1; u<=n; u++)
        for (int i=0; i<e2[u].size(); i++)
            if (id[u]!=id[e2[u][i]]) e[id[u]].push_back(id[e2[u][i]]);
}
///////

void adde(int u, int v, int typ)
{
    e[u].push_back(v);
    noI[v]=0;
    noO[u]=0;
    if (typ==0) ot.push_back(pii(lab[u], lab[v])); else ot.push_back(pii(lab[v], lab[u]));
}

void initIO()
{
    for (int u=1; u<=coutp; u++)
    {
        noI[u]=1;
        noO[u]=1;
    }
    for (int u=1; u<=coutp; u++)
        for (int i=0; i<e[u].size(); i++)
        {
            noO[u]=0;
            noI[e[u][i]]=0;
        }
}

void dfs(int u)
{
    if (noO[u]) q.push_back(u);
    num[u]=1;
    for (int i=0; i<e[u].size(); i++)
    {
        int v=e[u][i];
        if (num[v]==0) dfs(v);
    }
}

void inverse_edge()
{
    for (int u=1; u<=coutp; u++)
    {
        e2[u]=e[u];
        e[u].clear();
    }
    for (int u=1; u<=coutp; u++)
    {
        swap(noI[u], noO[u]);
        for (int i=0; i<e[u].size(); i++)
            e[e2[u][i]].push_back(u);
    }
}

void process()
{
    if (coutp==1) return;
    initIO();
    ot.clear();

    q.clear();
    for (int u=1; u<=coutp; u++) num[u]=0;
    int black=0;

    for (int u=1; u<=coutp; u++)
    if (noI[u])
    {
        int oldtop=q.size();
        dfs(u);
        if (black==0) black=u; else
        if (q.size()>oldtop)
        {
            int v=q.back();
            q.pop_back();
            adde(v, black, 0);
            black=u;
        }
    }

    inverse_edge();

    q.clear();
    for (int u=1; u<=coutp; u++) num[u]=0;
    int white=0;

    for (int u=1; u<=coutp; u++)
    if (noI[u])
    {
        int oldtop=q.size();
        dfs(u);
        if (white==0) white=u; else
        if (q.size()>oldtop)
        {
            int v=q.back();
            q.pop_back();
            adde(v, white, 1);
            white=u;
        }
    }

    if (!noO[black]) black=q.back();
    adde(black, white, 1);
    int v=0;
    for (int u=1; u<=coutp; u++)
    if (noI[u])
    {
        v++;
        while (v<=coutp && !noO[v]) v++;
        if (v<=coutp) adde(v, u, 1);
    }
    for (int u=1; u<=coutp; u++)
    {
        if (noI[u]) adde(black, u, 1);
        if (noO[u]) adde(u, white, 1);
    }
}

int main()
{
    freopen("traffic.inp", "r", stdin);
    freopen("traffic.out", "w", stdout);
    enter();
    nentp();
    process();
    cout << ot.size() << '\n';
    for (int i=0; i<ot.size(); i++) cout << ot[i].first << ' ' << ot[i].second << '\n';
}
