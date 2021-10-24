#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

typedef pair<int, int> pii;
const
    int maxn=1e5+100;
const
    int max_it=1e5+100, max_node=4e5+100, oo=1e7;
int n, m;
pii a[maxn];
vector<pii> e[maxn];
int ans[maxn];
long long res;
//////

void minimize(int &x, int y) {if (x>y) x=y;}

struct Interval_Tree
{
    int f[max_node], g[max_node], posL[max_it], posR[max_it];

    void build(int id, int L, int R)
    {
        posL[id]=L; posR[id]=R;
        f[id]=oo; g[id]=oo;
        if (L==R) return; else
        {
            int mid=(L+R)/2;
            build(id*2, L, mid);
            build(id*2+1, mid+1, R);
        }
    }

    void update_node(int id)
    {
        if (g[id]==oo) return;
        minimize(f[id], g[id]);
        if (posL[id]<posR[id])
        {
            minimize(g[id*2], g[id]);
            minimize(g[id*2+1], g[id]);
        }
        g[id]=oo;
    }

    int query(int id, int x, int y)
    {
        if (y<posL[id] || x>posR[id]) return oo;
        update_node(id);
        if (x<=posL[id] && posR[id]<=y) return f[id];
        int ans=min(query(id*2, x, y), query(id*2+1, x, y));
        if (posL[id]<posR[id]) f[id]=min(f[id*2], f[id*2+1]);
        return ans;
    }

    void update(int id, int x, int y, int w)
    {
        if (y<posL[id] || x>posR[id]) return;
        update_node(id);
        if (x<=posL[id] && posR[id]<=y) {g[id]=w; update_node(id); return;}
        update(id*2, x, y, w);
        update(id*2+1, x, y, w);
        if (posL[id]<posR[id]) f[id]=min(f[id*2], f[id*2+1]);
    }
} IT1, IT2;

//Interval_Tree IT1, IT2;
//////

void fastscan(int &number)
{
    number=0;
    register char c=getchar();
    while (c!='-' && (c<48 || c>57)) c=getchar();
    bool negative=false;
    if (c=='-') negative=true, c=getchar();
    for(; c>47 && c<58; c=getchar())
        number=number*10+c-48;
    if (negative) number=-number;
}

void enter()
{
    scanf("%d%d\n", &n, &m);
    forn(u, 1, n) fastscan(a[u].first), a[u].second=u;
    while (m--)
    {
        int u, l, r;
        fastscan(u); fastscan(l); fastscan(r);
        e[u].push_back({l, r});
    }
    sort(a+1, a+n+1);
}
//////

void process()
{
    IT1.build(1, 1, n);
    IT2.build(1, 1, n);

    forn(i, 1, n)
    {
        int u=a[i].second;
        if (i==1)
        {
            ans[u]=0;
            IT1.update(1, u, u, a[i].first);
            for(pii p : e[u])
                IT2.update(1, p.first, p.second, a[i].first);
            continue;
        }

        ans[u]=IT2.query(1, u, u);
        for(pii p : e[u])
            minimize(ans[u], IT1.query(1, p.first, p.second));
        if (ans[u]!=oo)
        {
            IT1.update(1, u, u, a[i].first);
            for(pii p : e[u])
                IT2.update(1, p.first, p.second, a[i].first);
        }
    }

    IT1.build(1, 1, n);
    IT2.build(1, 1, n);

    ford(i, n, 1)
    {
        int u=a[i].second;
        if (ans[u]==oo)
        {
            ans[u]=IT2.query(1, u, u);
            for(pii p : e[u])
                minimize(ans[u], IT1.query(1, p.first, p.second));
        }
        IT1.update(1, u, u, a[i].first);
        for(pii p : e[u])
            IT2.update(1, p.first, p.second, a[i].first);
    }

    res=0;
    forn(i, 2, n) res+=a[i].first+ans[a[i].second];
    cout << res;
}
//////

int main()
{
    freopen("galaxy.inp", "r", stdin);
    freopen("galaxy.out", "w", stdout);
    enter();
    process();
}
