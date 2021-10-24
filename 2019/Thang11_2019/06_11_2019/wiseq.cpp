#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

const
    int maxn2=510, maxn=5e4+100, oo=2e9;
int n, W, res;
int a[maxn];
int f[maxn2][maxn2];
int top, Q[maxn];
//////

void enter()
{
    scanf("%d%d\n", &n, &W);
    forn(i, 1, n) scanf("%d", &a[i]);
}
//////

void minimize(int &x, int y) {if (x>y) x=y;}

void process()
{
    res=0;
    bool upd=false;
    forn(i, 1, n)
    {
        f[i][1]=a[i];
        if (a[i]<=W) res=1, upd=true;
    }
    if (!upd) return;
    forn(k, 2, n)
    {
        upd=false;
        forn(i, 1, n)
        {
            f[i][k]=oo;
            if (f[i][k-1]<W)
            forn(j, 1, i-1)
                if (a[i]>a[j]) minimize(f[i][k], f[j][k-1]+a[i]);
            if (f[i][k]<=W) res=k, upd=true;
        }
        if (!upd) return;
    }
}
//////

void process2()
{
    top=0; Q[0]=0;
    forn(i, 1, n)
    {
        int pos=lower_bound(Q, Q+top+1, a[i])-Q;
        if (pos>top) Q[++top]=a[i]; else Q[pos]=a[i];
    }
    res=top;
}
//////

int main()
{
    freopen("wiseq.inp", "r", stdin);
    freopen("wiseq.out", "w", stdout);
    enter();
    if (n>500) process2(); else
    process();
    cout << res;
    return 0;
}
