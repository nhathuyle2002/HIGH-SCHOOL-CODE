#include <iostream>
#include <stdio.h>
#include <vector>
#include <utility>

#define _l first
#define _r second

using namespace std;
/////

struct dataIT
{
    long long f, g;
    int l, r;
};

const
    int maxn=5e5+100;
const
    long long oo=1e15;

int n, q;
int w[maxn];
long long h[maxn];
pair<int, int> query[maxn], dpos[maxn];
vector<int> e[maxn], idq[maxn];
long long res[maxn];

dataIT it[maxn*4];
int leaf[maxn];
/////

void cnIT(int id)
{
    if (it[id].g==0) return;
    it[id].f+=it[id].g;
    if (it[id].l<it[id].r)
    {
        it[id*2].g+=it[id].g;
        it[id*2+1].g+=it[id].g;
    }
    it[id].g=0;
}

void build(int id, int l, int r)
{
    it[id].f=0;
    it[id].g=0;
    it[id].l=l;
    it[id].r=r;
    if (l<r)
    {
        int mid=(l+r)>>1;
        build(id*2, l, mid);
        build(id*2+1, mid+1, r);
    }
}

long long quece(int id, int dd, int cc)
{
    int l=it[id].l, r=it[id].r;
    cnIT(id);
    if (dd>r || cc<l) return oo;
    if (dd<=l && r<=cc) return it[id].f;
    return min(quece(id*2, dd, cc), quece(id*2+1, dd, cc));
}

void update(int id, int dd, int cc, long long x)
{
    int l=it[id].l, r=it[id].r;
    cnIT(id);
    if (dd>r || cc<l) return;
    if (dd<=l && r<=cc)
    {
        it[id].g+=x;
        cnIT(id);
        return;
    }
    update(id*2, dd, cc, x);
    update(id*2+1, dd, cc, x);
    it[id].f=min(it[id*2].f, it[id*2+1].f);
}
//////

void enter()
{
    scanf("%d%d", &n, &q);
    for (int i=2; i<=n; i++)
    {
        int x, ww;
        scanf("%d%d", &x, &ww);
        e[x].push_back(i);
        w[i]=ww;
    }
    for (int i=1; i<=q; i++)
    {
        int x;
        scanf("%d%d%d", &x, &query[i]._l, &query[i]._r);
        idq[x].push_back(i);
    }
}
/////

void dfs1(int u)
{
    h[u]+=w[u];
    dpos[u]._l=u; dpos[u]._r=u;
    if (e[u].empty()) leaf[u]=1; else
    for (int i=0; i<e[u].size(); i++)
    {
        int v=e[u][i];
        h[v]=h[u];
        dfs1(v);
        dpos[u]._l=min(dpos[u]._l, dpos[v]._l);
        dpos[u]._r=max(dpos[u]._r, dpos[v]._r);
    }
}

void init()
{
    build(1, 1, n);
    dfs1(1);
    for (int i=1; i<=n; i++)
        if (leaf[i]==1) update(1, i, i, h[i]); else update(1, i, i, oo);
}
/////

void dfs2(int u)
{
    update(1, dpos[u]._l, dpos[u]._r, -w[u]);
    if (dpos[u]._l>1) update(1, 1, dpos[u]._l-1, w[u]);
    if (dpos[u]._r<n) update(1, dpos[u]._r+1, n, w[u]);

    for (int i=0; i<idq[u].size(); i++)
    {
        int p=idq[u][i];
        res[p]=quece(1, query[p]._l, query[p]._r);
    }
    for (int i=0; i<e[u].size(); i++) dfs2(e[u][i]);

    update(1, dpos[u]._l, dpos[u]._r, w[u]);
    if (dpos[u]._l>1) update(1, 1, dpos[u]._l-1, -w[u]);
    if (dpos[u]._r<n) update(1, dpos[u]._r+1, n, -w[u]);
}

void process()
{
    dfs2(1);
    for (int i=1; i<=q; i++) cout << res[i] << '\n';
}
/////

int main()
{
    enter();
    init();
    process();
}
