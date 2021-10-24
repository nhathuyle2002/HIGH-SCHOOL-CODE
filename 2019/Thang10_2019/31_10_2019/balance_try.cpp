#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

typedef vector<int> bignum;
const
    int maxn=10000, base=1e9;
int n, m;
int res;
int d[3][3], d2[3][3];
int x[maxn];
//////

void enter()
{
    scanf("%d%d\n", &n, &m);
}

void thu(int i)
{
    if (i>n)
    {
        vector<int> sum(3, 0);
        forn(i, 1, n) sum[x[i]]+=i;
        if (sum[1]+m==sum[2]) ++res;
        return;
    }
    forn(j, 0, 2)
    {
        x[i]=j;
        thu(i+1);
    }
}
//////

int main()
{
    freopen("balance.inp", "r", stdin);
    freopen("balance_try.out", "w", stdout);
    enter();
    res=0;
    thu(1);
    cout << res;
}
