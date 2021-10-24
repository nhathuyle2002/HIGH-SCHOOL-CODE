#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=1e5+100;

int n, res;
int a[maxn];
//////

void enter()
{
    scanf("%d\n", &n);
    forn(i, 1, n) scanf("%d", &a[i]);
    sort(a+1, a+n+1);
}
//////

void process()
{
    res=n;
    forn(i, 1, n)
    {
        int pos=upper_bound(a+1, a+n+1, a[i]+n-1)-a;
        res=min(res, n-(pos-i));
    }
    cout << res;
}
//////

int main()
{
    freopen("cassia.inp", "r", stdin);
    freopen("cassia.out", "w", stdout);
    enter();
    process();
}
