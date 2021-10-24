#define taskname "INTSLE"
#include <iostream>
#include <cstdio>
using namespace std;
typedef long long lli;
const int resinf = 1;
const int resnosol = 2;
lli a1, b1, c1, a2, b2, c2, x, y;

void Enter()
{
    cin >> a1 >> b1 >> c1;
    cin >> a2 >> b2 >> c2;
}

lli gcd(lli x, lli y)
{
    while (y != 0)
    {
        lli r = x % y;
        x = y;
        y = r;
    }
    return x;
}

int Solve(lli& x, lli& y)
{
    lli d, dx, dy;
    d = a1 * b2 - a2 * b1;
    dx = c1 * b2 - c2 * b1;
    dy = a1 * c2 - a2 * c1;
    if (d != 0)
    {
        if (dx % d == 0 && dy % d == 0)
        {
            x = dx / d; y = dy / d;
            return 0;
        }
        else
            return resnosol;
    }
    if (dx != 0 || dy != 0) return resnosol;
    bool sol1 = a1 == 0 && b1 == 0 ? c1 == 0 : c1 % gcd(a1, b1) == 0;
    bool sol2 = a2 == 0 && b2 == 0 ? c2 == 0 : c2 % gcd(a2, b2) == 0;
    if (sol1 && sol2) return resinf;
    else return resnosol;
}

int main()
{
    ios_base::sync_with_stdio(false);
    cin.tie(nullptr);
    freopen(taskname".inp", "r", stdin);
    freopen(taskname".out", "w", stdout);
    int q;
    cin >> q;
    for (; q > 0; --q)
    {
        Enter();
        int res = Solve(x, y);
        switch (res)
        {
            case 0: cout << x << ' ' << y << '\n'; break;
            case resnosol: cout << "NO SOLUTION\n"; break;
            case resinf: cout << "INFINITE\n";
        }
    }
}
