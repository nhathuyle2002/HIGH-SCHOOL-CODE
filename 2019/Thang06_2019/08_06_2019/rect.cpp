#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=1e5+100;
int k, l, m, n, delta;
//////

void enter()
{

}
//////

void process()
{
    delta=(l-2*k+2)*(l-2*k+2)-4*(l-k+1);
    m=l-2*k+2+sqrt(delta);
    n=l-2*k+2-sqrt(delta);
    cout << n/2 << ' ' << m/2 << '\n';
}
//////

int main()
{
    freopen("rect.inp", "r", stdin);
    freopen("rect.out", "w", stdout);
    while (scanf("%d%d\n", &k, &l)!=EOF)
    process();
}
