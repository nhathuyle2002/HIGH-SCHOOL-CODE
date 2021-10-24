#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=1e6;
int f[maxn+1];
//////

void enter()
{
    f[0]=0;
    forn(i, 1, maxn) f[i]=maxn+1;
    forn(i, 0, maxn-1)
    {
        f[i+1]=min(f[i+1], f[i]+1);
        forn(j, 1, i)
            if (i*j>maxn) break; else f[i*j]=min(f[i*j], f[i]+1);
    }
}
//////

void process()
{
    int q; scanf("%d\n", &q);
    while (q--)
    {
        int x; scanf("%d\n", &x);
        cout << f[x] << '\n';
    }
}
//////

int main()
{
    freopen("zero.inp", "r", stdin);
    freopen("zero.out", "w", stdout);
    enter();
    process();
}
