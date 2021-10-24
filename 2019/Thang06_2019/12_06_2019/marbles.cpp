#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=2e5+100;
int n, res;
int a[maxn], maxR[maxn], minL[maxn], d[3];
//////

void enter()
{
    char s[maxn];
    scanf("%s", s+1);
    n=strlen(s+1);
    forn(i, 1, n)
        if (s[i]=='w') a[i]=0; else
        if (s[i]=='r') a[i]=1; else
        if (s[i]=='b') a[i]=2;
    forn(i, n+1, 2*n)
        a[i]=a[i-n];
}
//////

void process()
{
    int R=1;
    d[1]=0; d[2]=0;
    forn(i, 1, n)
    {
        if (i>1) d[a[i-1]]--;
        while (R<=2*n && (d[1]==0 || d[2]==0)) d[a[R++]]++;
        maxR[i]=R-2;
    }

    int L=2*n;
    d[1]=0; d[2]=0;
    ford(i, 2*n ,n)
    {
        if (i<2*n) d[a[i+1]]--;
        while (L>0 && (d[1]==0 || d[2]==0)) d[a[L--]]++;
        minL[i]=L+2;
    }

    res=0;
    forn(i, 1, n)
    {
        int j=i+n-1, R=min(maxR[i], j), L=max(R+1, minL[j]);
        res=max(res, R-i+1+j-L+1);
    }

    cout << res;
}
//////

int main()
{
    freopen("marbles.inp", "r", stdin);
    freopen("marbles.out", "w", stdout);
    enter();
    process();
}
