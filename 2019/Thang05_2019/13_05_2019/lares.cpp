#include <bits/stdc++.h>
#define forn(i, a, b) for (int i=(a); i<=(b); ++i)
#define ford(i, a, b) for (int i=(a); i>=(b); --i)
using namespace std;
//////

int m, n, k;
int res;
//////

void enter()
{
    scanf("%d%d%d\n", &m, &n, &k);
}
//////

void process()
{
    res=min(m/2, n);
    k=k-(m+n-3*res);
    if (k>0) res-=(k+2)/3;
    cout << max(res, 0);
}
//////

int main()
{
    freopen("lares.inp", "r", stdin);
    freopen("lares.out", "w", stdout);
    enter();
    process();
}
