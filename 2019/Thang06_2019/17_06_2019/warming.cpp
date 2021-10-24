#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=1e6+100;
int n;
long long a[maxn];
pair<long long, int> b[maxn];
int res;
//////

void enter()
{
    int nn;
    scanf("%d\n", &nn);
    n=0; a[0]=0;
    forn(i, 1, nn)
    {
        long long x; scanf("%lld\n", &x);
        if (a[n]!=x) a[++n]=x;
    }
    a[n+1]=0;

    forn(i, 1, n)
        if (a[i]>a[i-1] && a[i]>a[i+1]) b[i]={a[i], -1}; else
        if (a[i]<a[i-1] && a[i]<a[i+1]) b[i]={a[i], 1}; else
            b[i]={a[i], 0};
    sort(b+1, b+n+1);
}
//////

void process()
{
    res=0;
    int cou=1;
    forn(i, 1, n+1)
    {
        if (b[i].first!=b[i-1].first) res=max(res, cou);
        cou+=b[i].second;
    }
    cout << res;
}
//////

int main()
{
    freopen("warming.inp", "r", stdin);
    freopen("warming.out", "w", stdout);
    enter();
    process();
}
