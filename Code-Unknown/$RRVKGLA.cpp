#include <iostream>
#include <stdio.h>
#include <algorithm>
#include <utility>
#include <vector>

#define _x first
#define _pos second

using namespace std;
////////

struct data
{
    int l, r, d, pos;
};
bool comp(data x, data y)
{
    return x.l<y.l;
}

typedef pair<int, int> pii;

const
    int maxn=1e5+100;

int n, m, cou;
data a[maxn], b[maxn];
int leaf[maxn*2];
vector<pii> h[maxn*2];
int it[8*maxn];
int match[maxn];
////////

void enter()
{
    scanf("%d\n", &n);
    pii d[maxn*2];
    for (int i=1; i<=n; i++)
    {
        scanf("%d%d\n", &a[i].l, &a[i].r);
        a[i].pos=i;
        d[i]._x=a[i].r; d[i]._pos=i;
    }

    scanf("%d\n", &m);
    for (int i=1; i<=m; i++)
    {
        scanf("%d%d%d\n", &b[i].l, &b[i].r, &b[i].d);
        b[i].pos=i;
        d[n+i]._x=b[i].r, d[n+i]._pos=n+i;
    }

    sort(d+1, d+n+m+1);
    cou=0; d[0]._x=0;
    for (int i=1; i<=n+m; i++)
    {
        if (d[i]._x>d[i-1]._x) cou++;
        if (d[i]._pos<=n) a[d[i]._pos].r=cou; else
            b[d[i]._pos-n].r=cou;
    }

    sort(a+1, a+n+1, comp);
    sort(b+1, b+m+1, comp);
}
////////

void build(int id, int l, int r)
{
    it[id]=cou+1;
    if (l==r) leaf[l]=id; else
    {
        int mid=(l+r)/2;
        build(id*2, l, mid);
        build(id*2+1, mid+1, r);
    }
}

void update(int x, int pos, int d)
{
    h[x].push_back(pii(d, pos));

    int i=leaf[x];
    it[i]=x;
    i/=2;
    while (i>0)
    {
        it[i]=min(it[i*2], it[i*2+1]);
        i/=2;
    }
}

int popp(int x)
{
    if (h[x].empty()) return -1;

    int rr=h[x].back()._pos;
    h[x].back()._x--;
    if (h[x].back()._x==0) h[x].pop_back();

    int i=leaf[x];
    if (h[x].empty()) it[i]=cou+1; else it[i]=x;
    i/=2;
    while (i>0)
    {
        it[i]=min(it[i*2], it[i*2+1]);
        i/=2;
    }
    return rr;
}

int query(int id, int l, int r, int dd, int cc)
{
    if (cc<l || dd>r) return cou+1;
    if (dd<=l && r<=cc) return it[id];

    int mid=(l+r)/2;
    return min(query(id*2, l, mid, dd, cc), query(id*2+1, mid+1, r, dd, cc));
}
////////

void process()
{
    build(1, 1, cou);
    int j=1;
    for (int i=1; i<=n; i++)
    {
        while (j<=m && b[j].l<=a[i].l)
        {
            update(b[j].r, b[j].pos, b[j].d);
            j++;
        }
        int p=query(1, 1, cou, a[i].r, cou);
        int rr=popp(p);
        if (rr==-1)
        {
            cout << "NO";
            return;
        } else
        match[a[i].pos]=rr;
    }
    cout << "YES" << '\n';
    for (int i=1; i<=n; i++) cout << match[i] << ' ';
}
////////

int main()
{
    freopen("singer.inp", "r", stdin);
    freopen("singer.out", "w", stdout);
    enter();
    process();
}
