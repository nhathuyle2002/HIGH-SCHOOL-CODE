#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

typedef long long LL;
typedef pair<LL, int> data;
struct edge
{
    int x, y, w;
};
const
    int maxn=1e5+100, maxk=17;
const
    LL oo=1e15;

int n, m, K;
int a[maxk];
vector<edge> e;
vector<int> pose[maxn];
LL d[maxk][maxk];
LL s[maxn];
set<data> Q;
LL f[1<<maxk][maxk];
//////

void enter()
{
    scanf("%d%d%d\n", &n, &m, &K);
    a[0]=1;
    forn(i, 1, K) scanf("%d", &a[i]);
    scanf("\n");
    forn(i, 1, m)
    {
        int u, v, w;
        scanf("%d%d%d\n", &u, &v, &w);
        pose[u].push_back(e.size()); e.push_back({u, v, w});
    }
}
//////

void dijkstra(int S)
{
    forn(u, 1, n) s[u]=oo;
    s[S]=0;
    Q.clear(); Q.insert({0, S});
    while (!Q.empty())
    {
        int u=Q.begin()->second; Q.erase(Q.begin());
        for(int i : pose[u])
        {
            int v=e[i].y, w=e[i].w;
            if (s[u]+w<s[v])
            {
                if (s[v]<oo) Q.erase({s[v], v});
                s[v]=s[u]+w;
                Q.insert({s[v], v});
            }
        }
    }
}
//////

int daob(int i, int x)
{
    return x ^ (1 << (i-1));
}
int getb(int i, int x)
{
    return (x >> (i-1)) & 1;
}

void process()
{
    forn(i, 0, K)
    {
        dijkstra(a[i]);
        forn(j, 0, K)
        {
            //cout << s[a[j]] << ' ';
            d[i][j]=s[a[j]];
        }
        //cout << '\n';
    }
    int maxb=(1 << K)-1;
    forn(x, 1, maxb)
        forn(i, 1, K)
        {
            f[x][i]=oo;
            if (getb(i, x)==1)
            {
                int y=daob(i, x);
                if (y==0)
                {
                    f[x][i]=d[0][i];
                    continue;
                }
                forn(j, 1, K)
                    if (getb(j, y)==1) f[x][i]=min(f[x][i], f[y][j]+d[j][i]);
            }
        }

    /*forn(x, 1, maxb)
        forn(i, 1, K) f[x][i]=oo;
    forn(i, 1, K) f[daob(i, 0)][i]=d[0][i];
    forn(x, 1, maxb)
        forn(i, 1, K)
        if (getb(i, x)==1)
            forn(j, 1, K)
                if (getb(j, x)==0) f[daob(j, x)][j]=min(f[daob(j, x)][j], f[x][i]+d[i][j]);
    */
    LL res=oo;
    forn(i, 1, K)
        res=min(res, f[maxb][i]+d[i][0]);
    if (res==oo) cout << -1; else cout << res;
}
//////

int main()
{
    freopen("tour.inp", "r", stdin);
    freopen("tour.out", "w", stdout);
    enter();
    process();
}

/*#include <bits/stdc++.h>
#define pii pair<long long, int>
#define F first
#define S second
#define FOR(i,a,b) for( int i=(a), _b=(b); i<=_b; i++)
#define FORD(i,a,b) for( int i=(a), _b=(b); i>=_b; i--)

using namespace std;

const	int mn = 1e5 + 5;

vector<pii > a[mn];
int     n,m,k,s[mn];
long long d[16][mn],oo=1e16,f[40000][16];

void	enter()
{
    cin>>n>>m>>k;
    FOR(i,1,k) cin >> s[i];
    int u,v,w;
    FOR(i,1,m)
    {
        scanf("%d%d%d",&u,&v,&w);
        a[u].push_back(make_pair(w,v));
    }
}

void    dijkstra(int z, int st)
{
    FOR(i,1,n) d[z][i]= oo;
    d[z][st]= 0;
    set<pii > Q;
    Q.insert(make_pair(0,st));
    while (!Q.empty())
    {
        int u= Q.begin()->S; Q.erase(Q.begin());
        for (pii xy : a[u])
        {
            int v= xy.S, w=xy.F;
            if (d[z][v]>d[z][u]+w)
            {
                if (d[z][v]<oo) Q.erase(Q.find(make_pair(d[z][v],v)));
                d[z][v]=d[z][u]+w;
                Q.insert(make_pair(d[z][v],v));
            }
        }
    }
}

int     getbit(int x, int k)
{
    return ((x >> (k-1))&1);
}

int     set1(int x, int k)
{
    return x | (1 << (k-1));
}

void	solve()
{
    dijkstra(0,1);
    FOR(i,1,k) dijkstra(i,s[i]);
    s[0]=1;
    FOR(i, 0, k)
    {
        FOR(j, 0, k)
            cout << d[i][s[j]] << ' ';
        cout << '\n';
    }

    int ful = (1 << k) - 1;
    FOR(i,1,ful)
        FOR(j,1,k)
            f[i][j]=oo;

    FOR(i,1,k)
        f[set1(0,i)][i]= d[0][s[i]];

    FOR(i,1,ful)
        FOR(last,1,k)
            FOR(j,1,k) if (getbit(i,j)==0)
            {
                int t= set1(i,j);
                f[t][j]=min(f[t][j],f[i][last]+d[last][s[j]]);
            }
    long long kq= oo;
    FOR(i,1,k) kq= min(kq, f[ful][i]+d[i][1]);
    if (kq==oo) cout << -1; else
    cout << kq;
}

int 	main()
{
	freopen("tour.inp","r",stdin);
	freopen("tour.out","w",stdout);

	enter();
	solve();

	return 0;
}*/

