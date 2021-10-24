#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define repn(i,a,b) for(int i=(a); i<(b); i++)
using namespace std;
//////

const
    int maxn=1e5+100;
int n, m;
int a[maxn];
long long res;
//////

void enter()
{
    scanf("%d%d\n", &n, &m);
    forn(i, 1, n) scanf("%d", &a[i]);
    sort(a+1, a+n+1);
}
//////

void process()
{
    res=n*(n-1)+n;
    forn(i, 1, n)
    {
        int p=upper_bound(a+1, a+n+1, m-a[i])-a;
        res-=n-p+1;
    }
    cout << res;
}
//////

int main()
{
    freopen("fm.inp", "r", stdin);
    freopen("fm.out", "w", stdout);
    enter();
    process();
}
