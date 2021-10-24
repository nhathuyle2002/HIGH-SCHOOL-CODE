#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxx=2e6+100;
bool d[maxx+1];
int s[maxx+1];
int T, n;
//////

void init()
{
    forn(x, 1, maxx) d[x]=true;
    d[1]=false;
    forn(x, 2, maxx)
    {
        s[x]=s[x-1];
        if (d[x])
        {
            ++s[x];
            forn(j, x, maxx/x) d[x*j]=false;
        }
    }
}
//////

int main()
{
    freopen("ddb.inp", "r", stdin);
    freopen("ddb.out", "w", stdout);
    init();
    scanf("%d\n", &T);
    while (T--)
    {
        scanf("%d\n", &n);
        cout << s[2*n]-s[n] << '\n';
    }
}
