#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define repn(i,a,b) for(int i=(a); i<(b); i++)
using namespace std;
//////

const
    int maxn=200;
int X, Y, n, x[maxn], y[maxn];
char s[maxn];
//////

void enter()
{
    scanf("%s\n", s+1);
    n=strlen(s+1);
    x[0]=0; y[0]=0;
    forn(i, 1, n)
    {
        x[i]=x[i-1]; y[i]=y[i-1];
        if (s[i]=='U') y[i]++; else
        if (s[i]=='D') y[i]--; else
        if (s[i]=='L') x[i]--; else
        x[i]++;
    }
}
//////

bool process()
{
    int dx=x[n]-x[0], dy=y[n]-y[0];
    if (dx==0 && dy==0)
    {
        forn(i, 0, n)
            if (x[i]==X && y[i]==Y) return true;
    } else
    if (dx==0)
    {
        forn(i, 0, n)
            if (x[i]==X && (Y-y[i]) % dy==0 && (Y-y[i])/dy>=0) return true;
    } else
    if (dy==0)
    {
        forn(i, 0, n)
            if ((X-x[i]) % dx==0 && (X-x[i])/dx>=0 && y[i]==Y) return true;
    } else
    {
        forn(i, 0, n)
            if ((X-x[i]) % dx==0 && (X-x[i])/dx>=0 && (Y-y[i]) % dy==0 && (Y-y[i])/dy==(X-x[i])/dx) return true;
    }
    return false;
}
//////

int main()
{
    freopen("robot.inp", "r", stdin);
    freopen("robot.out", "w", stdout);
    while (scanf("%d%d\n", &X, &Y)!=EOF)
    {
        enter();
        if (process()) cout << "YES"; else cout << "NO";
        cout << '\n';
    }
}
