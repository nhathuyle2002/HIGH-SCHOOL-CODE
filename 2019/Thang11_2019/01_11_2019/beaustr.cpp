#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

const
    int maxn=5e5+100;
int n, res;
int sum0[maxn], nex[maxn];
//////

void enter()
{
    scanf("%d\n", &n);
    sum0[0]=0;
    forn(i, 1, n)
    {
        char x=getchar();
        if (x=='0') sum0[i]=1; else sum0[i]=0;
        sum0[i]+=sum0[i-1];
    }
    nex[n+1]=n+1; sum0[n+1]=sum0[n];
    ford(i, n, 1)
        if (sum0[i]==sum0[i-1]) nex[i]=i; else nex[i]=nex[i+1];
}
//////

void process()
{
    res=n-sum0[n];
    forn(len, 1, n)
    {
        int bfpos=0, cou=0;
        while (bfpos<=n)
        {
            int pos=lower_bound(sum0+bfpos+1, sum0+n+1, sum0[bfpos]+len)-sum0;
            if (pos>n) break;
            bfpos=nex[pos];
            if (sum0[n]-sum0[bfpos]<len) break;
            cou++;
        }
        if (cou==0) break;
        res=max(res, cou+(cou+1)*len);
    }
    cout << res;
}
//////

int main()
{
    freopen("beaustr.inp", "r", stdin);
    freopen("beaustr.out", "w", stdout);
    enter();
    process();
}
