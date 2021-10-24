#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define ford(i,a,b) for(int i=(a); i>=(b); i--)
using namespace std;
//////

const
    int maxn=2e5+100;
int n, c1, c2;
//////

void enter()
{
    scanf("%d\n", &n);
    forn(i, 1, n)
    {
        int x; scanf("%d", &x);
        if (x==1) c1++; else c2++;
    }
}

//////

void process()
{
    if (c1==0 || c2==0)
    {
        forn(i, 1, n)
            if (c1==0) cout << 2 << ' '; else cout << 1 << ' ';
    } else
    {
        cout << 2 << ' '; c2--;


        cout << 1 << ' '; c1--;
        forn(i, 1, c2) cout << 2 << ' ';
        forn(i, 1, c1) cout << 1 << ' ';
    }
}
//////

int main()
{
    freopen("main.inp", "r", stdin);
    freopen("main.out", "w", stdout);
    enter();
    process();
}
