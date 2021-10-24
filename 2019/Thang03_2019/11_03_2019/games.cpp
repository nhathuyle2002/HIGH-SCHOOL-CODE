#include <iostream>
#include <stdio.h>

using namespace std;
///////

struct data
{
    int l, r, g, d;
};

const
    int maxn=1e5+100;
int n, m;
data it[4*maxn];
///////

void build(int id, int l, int r)
{
    it[id].l=l; it[id].r=r;
    it[id].d=0; it[id].g=0;
    if (l<r)
    {
        int mid=(l+r) >> 1;
        build(id*2, l, mid);
        build(id*2+1, mid+1, r);
    }
}

void capn(int id)
{
    it[id].g=max(it[id].g, it[id].d);
    if (it[id].l<it[id].r)
    {
        it[id*2].d=max(it[id*2].d, it[id].d);
        it[id*2+1].d=max(it[id*2+1].d, it[id].d);
    }
    it[id].d=0;
}

void update(int id, int dd, int cc, int x)
{
    capn(id);
    int l=it[id].l, r=it[id].r;
    if (dd>r || cc<l) return;
    if (dd<=l && r<=cc)
    {
        it[id].d=x;
        capn(id);
        return;
    }

    update(id*2, dd, cc, x);
    update(id*2+1, dd, cc, x);
    it[id].g=max(it[id*2].g, it[id*2+1].g);
}

int query(int id, int dd, int cc)
{
    capn(id);
    int l=it[id].l, r=it[id].r;
    if (dd>r || cc<l) return 0;
    if (dd<=l && r<=cc) return it[id].g;

    int rr;
    rr=max(query(id*2, dd, cc),
        query(id*2+1, dd, cc));
    it[id].g=max(it[id*2].g, it[id*2+1].g);
    return rr;
}

///////

void enter()
{
    scanf("%d%d\n", &n, &m);
    build(1, 1, n);
    for (int i=1; i<=n; i++)
    {
        int x;
        scanf("%d", &x);
        update(1, i, i, x);
    }
}
///////

void process()
{
    for (int i=1; i<=m; i++)
    {
        int l, r, hh;
        scanf("%d%d\n", &l, &r);
        if (l+r-1>n) r=n; else r=l+r-1;
        hh=query(1, l, r)+1;
        cout << hh << '\n';
        update(1, l, r, hh);
    }
}
///////

int main()
{
    freopen("games.inp", "r", stdin);
    freopen("games.out", "w", stdout);
    enter();
    process();
}
