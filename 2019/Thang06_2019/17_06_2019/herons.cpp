#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=1e5+100;
int a, b;
//////

void enter()
{
    cin >> a >> b;
}
//////

void process()
{
    cout << (max(a, b)+1)/2 << ' ' << min(a, b);
}
//////

int main()
{
    freopen("herons.inp", "r", stdin);
    freopen("herons.out", "w", stdout);
    enter();
    process();
}
