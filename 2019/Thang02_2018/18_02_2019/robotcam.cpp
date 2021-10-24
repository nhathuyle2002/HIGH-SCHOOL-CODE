#include <iostream>
#include <stdio.h>
#include <algorithm>

#define _y first
#define _x second

using namespace std;
//////

typedef pair<int, int> pii;
const
    int maxn=1e5+100;
int n, cou;
pii a[maxn];
int it[maxn*4];
int d[maxn], leaf[maxn];
//////

void enter()
{
    scanf("%d\n", &n);
    for (int i=1; i<=n; i++)
        scanf("%d%d\n", &a[i]._x, &a[i]._y);
    sort(a+1, a+n+1);

    pii dd[maxn]; dd[0].first=(int)(-1e9-100);
    for (int i=1; i<=n; i++)
    {
        dd[i].first=a[i]._x;
        dd[i].second=i;
    }
    sort(dd+1, dd+n+1);

    cou=0;
    for (int i=1; i<=n; i++)
    {
        if (dd[i].first>dd[i-1].first) cou++;
        a[dd[i].second]._x=cou;
    }
}
//////

void build(int id, int l, int r)
{
    if (l==r) leaf[l]=id; else
    {
        int mid=(l+r)>>1;
        build(id*2, l, mid);
        build(id*2+1, mid+1, r);
    }
}

int query(int id, int l, int r, int dd, int cc)
{
    if (dd>r || cc<l) return 0;
    if (dd<=l && r<=cc) return it[id];
    int rr, mid=(l+r)>>1;
    rr=query(id*2+1, mid+1, r, dd, cc);
    if (rr==0) rr=query(id*2, l, mid, dd, cc);
}

void update(int i, int x)
{
    d[i]+=x;
    int id=leaf[i];
    if (d[i]==0) it[id]=0; else it[id]=i;
    id=id>>1;
    while (id>0)
    {
        it[id]=max(it[id*2], it[id*2+1]);
        id=id>>1;
    }
}
//////

void process()
{
    build(1, 1, cou);
    for (int i=1; i<=n; i++) d[i]=0;
    int res=0;
    for (int i=1; i<=n; i++)
    {
        int x=query(1, 1, cou, 1, a[i]._x);
        if (x==0) res++; else update(x, -1);
        update(a[i]._x, 1);
    }
    cout << res;
}
//////

int main()
{
    freopen("robotcam.inp", "r", stdin);
    freopen("robotcam.out", "w", stdout);
    enter();
    process();
}
