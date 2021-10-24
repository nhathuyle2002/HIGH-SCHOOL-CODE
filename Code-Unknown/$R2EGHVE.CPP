#include <bits/stdc++.h>
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
}
