#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define repn(i,a,b) for(int i=(a); i<(b); i++)
using namespace std;
//////

typedef pair<int, int> pii;
const
    int maxn=1e4+100;
int n, m, C;
int nex[maxn], deg[maxn], trace[maxn];
bool d[maxn];
pii a[maxn];
vector<int> q;
double res;
//////

void enter()
{
    scanf("%d%d\n", &n, &m);
    scanf("%d\n", &C);
    forn(i, 1, n)
    {
        scanf("%d\n", &nex[i]);
        if (nex[i]==i) nex[i]=0;
        if (nex[i]>0) deg[nex[i]]++;
    }
}
//////

void dfs(int s)
{
    forn(u, 1, n) d[u]=true;
    int u=s, cou=0, pa=0;
    while (u>0)
    {
        if (!d[u]) break; d[u]=false;
        cou++;
        if (a[u].first>=cou) break;
        a[u].first=cou; trace[u]=pa;
        pa=u; u=nex[u];
    }
}

void process()
{
    forn(u, 1, n)
        if (deg[u]==0) dfs(u);
    forn(u, 1, n)
        if (a[u].first==0) dfs(u);
    forn(u, 1, n) a[u].second=u;
    sort(a+1, a+n+1, greater<pii>() );

    forn(u, 1, n) d[u]=true;
    forn(i, 1, n)
    {
        int u=a[i].second;
        if (!d[u]) break;
        double c=C;
        while (m>0 && u>0)
        {
            d[u]=false;
            q.push_back(u);
            res+=c; c=c*9/10;
            u=trace[u];
            m--;
        }
    }

    sort(q.begin(), q.end());
    cout << setprecision(0) << fixed << res << '\n';
    forn(i, 1, n)
        if (!d[i]) cout << i << '\n';
    //repn(i, 0, q.size()) cout << q[i] << '\n';
}

int main()
{
    freopen("souvenir.inp", "r", stdin);
    freopen("souvenir.out", "w", stdout);
    enter();
    process();
}
