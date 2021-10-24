#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

typedef long long LL;
const
    int maxn=1e6+100;
int n, m;
vector<LL> f[maxn];
LL res;
//////

void enter()
{
    scanf("%d%d\n", &n, &m);
    forn(j, 0, m) f[0].push_back(0);
    forn(i, 1, n)
    {
        f[i].push_back(0);
        forn(j, 1, m)
        {
            f[i].push_back(0);
            scanf("%lld", &f[i][j]);
            f[i][j]+=f[i-1][j]+f[i][j-1]-f[i-1][j-1];
        }
    }
}
//////

void process()
{
    res=maxn*10;
    forn(i, 3, n)
        forn(j, 3, m)
            res=min(res, f[i][j]-f[i-3][j]-f[i][j-3]+f[i-3][j-3]);
    cout << res;
}
//////

int main()
{
    freopen("enrichment.inp", "r", stdin);
    freopen("enrichment.out", "w", stdout);
    enter();
    process();
}
