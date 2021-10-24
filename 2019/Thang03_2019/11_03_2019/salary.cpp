#include <iostream>
#include <stdio.h>
#include <vector>
#include <string.h>

using namespace std;
//////

struct data
{
    int l, r;
    long long g, d;
};

const
    int maxn=5e5+100;

int n, m;
long long a[maxn];
vector<int> e[maxn];
int cou, pl[maxn], pr[maxn], tt[maxn];
data it[4*maxn];
//////

void enter()
{
    scanf("%d%d\n", &n, &m);
    scanf("%lld\n", &a[1]);
    for (int i=2; i<=n; i++)
    {
        int u;
        scanf("%lld%d\n", &a[i], &u);
        e[u].push_back(i);
    }
}
//////

void dfs(int u)
{
    cou++; pl[u]=cou; tt[cou]=u;
    for (int i=0; i<e[u].size(); i++)
        dfs(e[u][i]);
    pr[u]=cou;
}

void build(int id, int l, int r)
{
    it[id].l=l; it[id].r=r;
    it[id].d=0;
    if (l==r)
    {
        it[id].g=a[tt[l]];
    } else
    {
        it[id].g=0;
        int mid=(l+r) >> 1;
        build(id*2, l, mid);
        build(id*2+1, mid+1, r);
        //it[id].g=it[id*2].g +it[id*2+1].g;
    }
}

void init()
{
    cou=0;
    dfs(1);
    build(1, 1, n);
}
//////

void capn(int id)
{
    if (it[id].l==it[id].r) it[id].g+=it[id].d;
    if (it[id].l<it[id].r)
    {
        it[id*2].d+=it[id].d;
        it[id*2+1].d+=it[id].d;
    }
    it[id].d=0;
}

void update(int id, int dd, int cc, long long x)
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
    //it[id].g=it[id*2].g +it[id*2+1].g;
}

long long query(int id, int dd, int cc)
{
    capn(id);
    int l=it[id].l, r=it[id].r;
    if (dd>r || cc<l) return 0;
    if (dd<=l && r<=cc) return it[id].g;

    long long rr;
    rr=query(id*2, dd, cc)
    +query(id*2+1, dd, cc);
    //it[id].g=it[id*2].g +it[id*2+1].g;
    return rr;
}
//////

void process()
{
    for (int i=1; i<=n; i++) a[i]=0;
    for (int i=1; i<=m; i++)
    {
        char ms;
        int p; long long x;
        scanf("%c", &ms);
        if (ms=='u')
        {
            scanf("%d\n", &p);
            cout << query(1, pl[p], pl[p])-a[p] << '\n';
        } else
        {
            scanf("%d%lld\n", &p, &x);
            a[p]+=x;
            update(1, pl[p], pr[p], x);
        }
    }
}

//////

int main()
{
    freopen("salary.inp", "r", stdin);
    freopen("salary.out", "w", stdout);
    enter();
    init();
    process();
}
