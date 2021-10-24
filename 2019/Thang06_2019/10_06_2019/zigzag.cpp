#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=2e3+100, base=1e9;
int n, n1, n2, S, T;
long long d[maxn], sum1[maxn], sum2[maxn], res1[maxn], res2[maxn], res;
//////

void prepare()
{
    d[0]=1;
    forn(i, 1, 2000)
        forn(j, 0, i-1)
            d[i]=(d[i]+d[j]) % base;
}
//////

void enter()
{
    if (S>T) swap(S, T);
    n1=T-S;
    n2=S+n-T;
}
//////

void process()
{
    forn(i, 1, n1-1)
    {
        sum1[i]=d[i];
        res1[i]=d[i];
    }
    forn(j, 1, n2-1)
    {
        sum2[j]=d[j];
        res2[j]=d[j];
    }

    forn(i, 1, n1-1)
        forn(j, 1, n2-1)
        {
            res1[i]=(res1[i]+sum2[j]) % base;
            res2[j]=(res2[j]+sum1[i]) % base;

            long long tmp=sum1[i]+sum2[j];
            sum1[i]=(sum1[i]+tmp) % base;
            sum2[j]=(sum2[j]+tmp) % base;
        }

    res=1;
    forn(i, 1, n1-1) res+=res1[i];
    forn(j, 1, n2-1) res+=res2[j];
    cout << res % base << '\n';
}
//////

int main()
{
    freopen("zigzag.inp", "r", stdin);
    freopen("zigzag.out", "w", stdout);

    prepare();
    while (scanf("%d%d%d\n", &n, &S, &T)!=EOF)
    {
        enter();
        process();
    }
}
