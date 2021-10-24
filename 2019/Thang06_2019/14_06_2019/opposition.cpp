#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define F first
#define S second
using namespace std;
//////

typedef pair<int, int> pii;
const
    int maxn=310;
int n, m, L, R, res, sumb;
pii a[maxn], b[maxn];
int sum[maxn];
//////

void enter()
{
    scanf("%d%d\n", &n, &m);
    scanf("%d%d\n", &L, &R);
    int bf=L, tmp;
    forn(i, 1, n) scanf("%d%d\n", &a[i].F, &a[i].S);
    sort(a+1, a+n+1);

    forn(i, 1, n)
    {
        tmp=a[i].S;
        a[i]={bf, a[i].F};
        bf=tmp;
    }
    a[++n]={bf, R};

    sumb=0;
    forn(i, 1, m)
    {
        scanf("%d%d\n", &b[i].F, &b[i].S);
        sumb+=b[i].S-b[i].F;
    }
    sort(b+1, b+m+1);
}
//////

void process()
{
    sum[0]=0;
    forn(i, 1, n) sum[i]=sum[i-1]+a[i].S-a[i].F;
    a[n+1].F=R+1;

    res=sumb;
    forn(i, 1, n) forn(j, 1, m)
    {
        int k=a[i].F-b[j].F;
        if (b[1].F+k<L || b[m].S+k>R) continue;
        int L=0, R=1, sm=0;
        forn(t, 1, m)
        {
            while (a[L+1].F<=b[t].F+k) L++;
            while (a[R].S<b[t].S+k) R++;
            sm+=sum[R]-sum[L-1];
            if (b[t].F+k>a[L].S) sm-=a[L].S-a[L].F; else sm-=b[t].F+k-a[L].F;
            if (b[t].S+k<a[R].F) sm-=a[R].S-a[R].F; else sm-=a[R].S-(b[t].S+k);
        }
        res=min(res, sumb-sm);
    }

    cout << res;
}
//////

int main()
{
    freopen("opposition.inp", "r", stdin);
    freopen("opposition.out", "w", stdout);
    enter();
    process();
}
