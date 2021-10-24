#include <iostream>
#include <stdio.h>
#include <vector>
#include <string.h>

using namespace std;
//////

const
    int maxn=1e5+100;

int n, k, root;
vector<int> e[maxn];
int cou, pl[maxn], pr[maxn];
int leaf[maxn], it[4*maxn];
long long res;
//////

void enter()
{
    scanf("%d%d\n", &n, &k);
    int d[maxn];
    memset(d, 0, sizeof(d));
    for (int i=1; i<=n-1; i++)
    {
        int u, v;
        scanf("%d%d\n", &u, &v);
        e[u].push_back(v);
        d[v]=1;
    }
    for (int i=1; i<=n; i++)
        if (d[i]==0) root=i;
}
//////

void dfs(int u)
{
    cou++; pl[u]=cou;
    for (int i=0; i<e[u].size(); i++)
        dfs(e[u][i]);
    pr[u]=cou;
}

void build(int id, int l, int r)
{
    it[id]=0;
    if (l==r) leaf[l]=id; else
    {
        int mid=(l+r)>>1;
        build(id*2, l, mid);
        build(id*2+1, mid+1, r);
    }
}

void init()
{
    cou=0;
    dfs(root);
    build(1, 1, cou);
}
//////

void update(int i, int x)
{
    i=leaf[i];
    it[i]+=x;
    i>>=1;
    while (i>0)
    {
        it[i]=it[i*2]+it[i*2+1];
        i>>=1;
    }
}

int query(int id, int l, int r, int dd, int cc)
{
    if (cc<l || dd>r) return 0;
    if (dd<=l && r<=cc) return it[id];
    int mid=(l+r)>>1;
    return query(id*2, l, mid, dd, cc)
        +query(id*2+1, mid+1, r, dd, cc);
}

void process()
{
    res=0;
    int l=1, r=0;
    for (int i=1; i<=n; i++)
    {
        while (r<=n && i+k>r)
        {
            r++;
            update(pl[r], 1);
        }
        if (l<i-k)
        {
            update(pl[l], -1);
            l++;
        }
        res+=query(1, 1, cou, pl[i], pr[i])-1;
    }
    cout << res;
}

//////

int main()
{
    freopen("perfect.inp", "r", stdin);
    freopen("perfect.out", "w", stdout);
    enter();
    init();
    process();
}
