#include <bits/stdc++.h>
#define forn(i, a, b) for (int i=(a); i<=(b); ++i)
#define ford(i, a, b) for (int i=(a); i>=(b); --i)
using namespace std;
//////

int a, b, c, d, v;
//////

void enter()
{

}
//////

void process()
{
    if (c==0 && d==0) cout << "NONE"; else
    if (v*d==b && v*c==a) cout << "MULTIPLE"; else
    if (v*d==b || v*c==a) cout << "NONE"; else
    {
        int x=v*d-b, y=a-v*c, g=__gcd(x, y);
        x/=g; y/=g;
        if (y<0)
        {
            x=-x;
            y=-y;
        }
        if (c*x==-d*y) cout << "NONE"; else
        cout << "X = " << x << "/" << y;
    }
    cout << '\n';
}
//////

int main()
{
    freopen("equation.inp", "r", stdin);
    freopen("equation.out", "w", stdout);
    while (scanf("%d%d%d%d%d\n", &a, &b, &c, &d, &v)!=EOF)
    {
        //enter();
        process();
    }
}
