#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=1e5+100;
int n;
set<int> Q;
//////

void enter()
{
    scanf("%d\n", &n);
    forn(i, 1, n)
    {
        int x;
        scanf("%d", &x);
        Q.insert(x);
    }
}
//////

void process()
{
    cout << Q.size();
}
//////

int main()
{
    freopen("disnum.inp", "r", stdin);
    freopen("disnum.out", "w", stdout);
    enter();
    process();
}
