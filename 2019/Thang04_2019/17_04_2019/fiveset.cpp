#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=2e5+100;
const
    long long oo=1e16;
int n, w1, w2;
long long a[maxn], f[maxn][6];
int w[6];
//////

void enter()
{
    scanf("%d%d%d\n", &n, &w1, &w2);
    forn(i, 1, n) scanf("%lld", &a[i]);
    w[1]=w1; w[2]=w2; w[3]=1; w[4]=w2; w[5]=w1;
}
//////

void process()
{
    forn(j, 1, 5) f[0][j]=-oo;
    forn(i, 1, n)
        forn(j, 1, 5)
            f[i][j]=max(f[i-1][j], f[i-1][j-1]+a[i]*w[j]);
    cout << f[n][5];
}
//////

int main()

{
    freopen("fiveset.inp", "r", stdin);
    freopen("fiveset.out", "w", stdout);
    enter();
    process();
}
