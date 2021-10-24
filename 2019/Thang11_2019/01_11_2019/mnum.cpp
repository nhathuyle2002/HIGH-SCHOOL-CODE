#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

const
    int maxn=1e5+100, maxtk=60;
int n; long long K;
long long last[20], frpos[100], dis[100], ans[100];
long long a[maxn], res[maxn];
//////

long long tim(long long x)
{
    forn(i, 1, 16)
        if ((last[i]-last[i-1])*i<x) x-=(last[i]-last[i-1])*i; else
        {
            long long p=(x-1)/i, q=(x-1)%i+1;
            return (last[i-1]+1+p)/(last[i-q]+1)%10;
        }
}

void init()
{
    last[0]=0;
    forn(i, 1, 16) last[i]=(last[i-1]+1)*10-1;

    frpos[1]=1; dis[1]=1;
    forn(i, 2, maxtk)
    {
        frpos[i]=frpos[i-1];
        if (i % 2==0) frpos[i]+=dis[i-1];
        dis[i]=dis[i-1]*2;
    }

    forn(i, 1, maxtk)
        ans[i]=tim(frpos[i]);
}
//////

void enter()
{
    scanf("%d\n", &n);
    forn(i, 1, n) scanf("%lld", &a[i]);
}
//////

long long demso(long long x)
{
    long long dem=0;
    forn(i, 1, 16)
        if (last[i]>=x) return dem+(x-last[i-1])*i; else dem+=(last[i]-last[i-1])*i;
}

void process()
{
    forn(t, 1, n)
    {
        K=demso(a[t]);
        forn(i, 1, maxtk)
            if (frpos[i]+dis[i]>K) {res[t]=ans[i]; break;}
    }
    forn(t, 1, n) cout << res[t];
}
//////

int main()
{
    freopen("mnum.inp", "r", stdin);
    freopen("mnum.out", "w", stdout);
    init();
    enter();
    process();
}
