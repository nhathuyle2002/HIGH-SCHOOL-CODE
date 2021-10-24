#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=1e5+100;
double a, b, c, d;
long long res;
//////

void enter()
{
    scanf("%lf%lf%lf%lf", &a, &b, &c, &d);
}
//////

int ltl(long double x)
{
    return ceil(x);
    //if (x==int(x)) return int(x); else return int(x)+1;
}
int ltx(long double x)
{
    return floor(x);
    //return int(x);
}

void process()
{
    res=0;
    forn(x, 1, sqrt(b))
    {
        int L=max(ltl(a/x), ltl(c/2-x)), R=min(ltx(b/x), ltx(d/2-x));
        L=max(L, x);
        if (L<=R) res+=R-L+1;
    }
    cout << res;
}
//////

int main()
{
    freopen("hall.inp", "r", stdin);
    freopen("hall.out", "w", stdout);
    enter();
    process();
}
