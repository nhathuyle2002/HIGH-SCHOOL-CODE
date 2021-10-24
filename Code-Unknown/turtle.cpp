#include <bits/stdc++.h>
#define forn(i, a, b) for (int i=(a); i<=(b); ++i)
#define ford(i, a, b) for (int i=(a); i>=(b); --i)
using namespace std;
//////

int a[5];
long long res;
//////

void enter()
{
    forn(i, 1, 4) scanf("%d", &a[i]);
}
//////

void process()
{
    res=0;
    forn(i, 1, 4)
        forn(j, 1, 4)
        if (j!=i)
            forn(k, 1, 4)
            if (k!=i && k!=j)
                forn(t, 1, 4)
                if (t!=i && t!=j && t!=k)
                    res=max(res, 1LL*min(a[i], a[j])*min(a[k], a[t]));
    cout << res;
}
//////

int main()
{
    freopen("turtle.inp", "r", stdin);
    freopen("turtle.out", "w", stdout);
    enter();
    process();
}
