#include <bits/stdc++.h>
#define forn(i, a, b) for (int i=(a); i<=(b); ++i)
#define ford(i, a, b) for (int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=1e6+100;
int n;
char s[maxn];
int f[maxn][2], tt[maxn];
//////

void enter()
{
    scanf("%s", s+1);
    n=strlen(s+1);
    forn(i, 1, n)
        if (s[i]==s[i-1]) tt[i]=tt[i-1]; else tt[i]=i-1;
}
//////

void process()
{
    forn(i, 1, n)
        if (s[i]=='A')
        {
            f[i][0]=f[i-1][0];
            f[i][1]=min(f[i-1][1]+1, f[tt[i]][0]+1);
        } else
        {
            f[i][0]=min(f[i-1][0]+1, f[tt[i]][1]+1);
            f[i][1]=f[i-1][1];
        }
    cout << f[n][0];
}
//////

int main()
{
    freopen("str.inp", "r", stdin);
    freopen("str.out", "w", stdout);
    enter();
    process();
}
