#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

const
    int maxn=1e5+100;
int n, K;
double a[maxn], sum[maxn];
//////

void enter()
{
    scanf("%d%d\n", &n, &K);
    forn(i, 1, n)
        scanf("%lf", &a[i]);
}
//////

void process()
{
    double L=-maxn, R=maxn;
    sum[0]=0;
    forn(t, 1, 60)
    {
        double H=(R+L)/2, mins=0;
        bool ok=false;
        forn(i, 1, n)
        {
            sum[i]=sum[i-1]+a[i]-H;
            if (i>=K)
            {
                mins=min(mins, sum[i-K]);
                if (sum[i]>=mins)
                {
                    ok=true;
                    break;
                }
            }
        }
        if (ok) L=H; else R=H;
    }
    printf("%0.5f", L);
}
//////

int main()
{
    freopen("seqmx.inp", "r", stdin);
    freopen("seqmx.out", "w", stdout);
    enter();
    process();
}
