#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define repn(i,a,b) for(int i=(a); i<(b); i++)
using namespace std;
//////

const
    int maxN=1e6+100;
int T, n, K;
int x[maxN], c[maxN], d[maxN];
int res;
//////

void enter()
{
    scanf("%d%d\n", &n, &K);
    forn(i, 1, n) scanf("%d", &x[i]); scanf("\n");
    forn(i, 1, n) scanf("%d", &c[i]); scanf("\n");
}
//////

void process()
{
    res=0; d[0]=0;
    int L=0;
    forn(i, 1, n)
    {
        while (L+1<i && x[i]-x[L+1]>=K)
        {
            L++;
            d[L]=max(d[L], d[L-1]);
        }
        d[i]=d[L]+c[i];
        res=max(res, d[i]);
    }
    cout << res << '\n';
}
//////

int main()
{
    freopen("radars.inp", "r", stdin);
    freopen("radars.out", "w", stdout);
    scanf("%d\n", &T);
    while (T--)
    {
        enter();
        process();
    }
}
