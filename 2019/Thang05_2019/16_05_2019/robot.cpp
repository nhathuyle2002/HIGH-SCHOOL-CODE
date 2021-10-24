#include <bits/stdc++.h>
#define forn(i, a, b) for (int i=(a); i<=(b); ++i)
#define ford(i, a, b) for (int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=1e5+100, maxm=1e6+100;
const
    int dx[4]={-1, 0, 1, 0}, dy[4]={0, 1, 0, -1};
int n, m;
int x[maxn], y[maxn];
long long sx[maxn], sy[maxn];
int rx[maxm], ry[maxm];
char s[maxm];
//////

void enter()
{
    scanf("%d%d\n", &n, &m);
    forn(i, 1, n) scanf("%d%d\n", &x[i], &y[i]);
    sort(x+1, x+n+1); sort(y+1, y+n+1);
    forn(i, 1, n+1)
    {
        sx[i]=sx[i-1]+x[i];
        sy[i]=sy[i-1]+y[i];
    }

    scanf("%s", s+1);
    rx[0]=0; ry[0]=0;
    forn(i, 1, m)
    {
        rx[i]=rx[i-1]; ry[i]=ry[i-1];
        if (s[i]=='E') rx[i]++; else
        if (s[i]=='S') ry[i]--; else
        if (s[i]=='N') ry[i]++; else
        if (s[i]=='W') rx[i]--;
    }
}
//////

void process()
{
    forn(i, 1, m)
    {
        long long res=0;
        int pos=upper_bound(x+1, x+n+1, rx[i])-x-1;
        //res=1LL*rx[i]*pos-sx[pos]+sx[n]-sx[pos]-1LL*(n-pos)*rx[i];
        res=1LL*(2*pos-n)*rx[i]+sx[n]-2*sx[pos];

        pos=upper_bound(y+1, y+n+1, ry[i])-y-1;
        //res+=1LL*ry[i]*pos-sy[pos]+sy[n]-sy[pos]-1LL*(n-pos)*ry[i];
        res+=1LL*(2*pos-n)*ry[i]+sy[n]-2*sy[pos];
        cout << res << '\n';
    }
}
//////

int main()
{
    freopen("robot.inp", "r", stdin);
    freopen("robot.out", "w", stdout);
    enter();
    process();
}
