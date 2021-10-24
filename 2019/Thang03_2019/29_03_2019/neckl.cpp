#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define repn(i,a,b) for(int i=(a); i<(b); i++)
using namespace std;
//////

const
    int maxn=70;
int n;
int a[maxn];
long long mu2[maxn];
long long res_min, res_max;
//////

void enter()
{
    char s[maxn];
    scanf("%s", s+1);
    n=strlen(s+1);
    forn(i, 1, n)
        if (s[i]=='B') a[i]=0; else a[i]=1;
    forn(i, n+1, n*2) a[i]=a[i-n];
    mu2[0]=1;
    forn(i, 1, n+1) mu2[i]=mu2[i-1]*2;
}
//////

void process(int typ)
{
    forn(s, 1, n)
    {
        int t=s+n-1;
        long long sum=0;
        forn(i, s, t)
            if (a[i]==typ) sum+=(1LL << (i-s));//mu2[i-s];
        res_min=min(res_min, sum);
        res_max=max(res_max, sum);
    }
}
//////

int main()
{
    freopen("neckl.inp", "r", stdin);
    freopen("neckl.out", "w", stdout);
    enter();
    res_min=1LL << (n+1) ; res_max=0;
    process(0); process(1);
    forn(i, 1, n/2) swap(a[i], a[n-i+1]);
    forn(i, n+1, n*2) a[i]=a[i-n];
    process(0); process(1);
    cout << res_min << ' ' << res_max;
}
