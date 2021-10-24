#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

typedef long long LL;
const
    int maxn=1e5+100;
int n;
int x[maxn], y[maxn];
LL sum1, sum2;
//////

void enter()
{
    scanf("%d\n", &n);
    forn(i, 1, n) scanf("%d%d\n", &x[i], &y[i]);
    sort(x+1, x+n+1);
    sum1=0;
    forn(i, 1, n)
        sum1+=abs(x[i]-x[(n+1)/2]);
    sort(y+1, y+n+1);
    sum2=0;
    forn(i, 1, n)
        sum2+=abs(y[i]-y[(n+1)/2]);
}
//////

void process()
{
    forn(i, 1, n) x[i]-=i;
    forn(i, 1, n) y[i]-=i;
    sort(x+1, x+n+1);

    forn(i, 1, n)
        sum2+=abs(x[i]-x[(n+1)/2]);
    sort(y+1, y+n+1);

    forn(i, 1, n)
        sum1+=abs(y[i]-y[(n+1)/2]);

    cout << min(sum1, sum2);
}
//////

int main()
{
    freopen("queue.inp", "r", stdin);
    freopen("queue.out", "w", stdout);
    enter();
    process();
}
