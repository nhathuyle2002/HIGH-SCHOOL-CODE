#include <iostream>
#include <cstdio>
#include <cstdlib>
using namespace std;
#define taskname "COUNTMOD"
typedef long long lli;

lli d[4], r[4];

lli DoMulMod(lli x, lli y, lli m)
{
    if (y == 0) return 0;
    lli res = 2 * DoMulMod(x, y / 2, m) % m;
    if (y % 2 == 1)
        res = (res + x) % m;
    return res;
}

inline lli MulMod(lli x, lli y, lli m)
{
    x = ((x % m) + m) % m;
    y = ((y % m) + m) % m;
    return DoMulMod(x, y, m);
}

inline bool SolveDiophantine(lli a, lli b, lli c, lli &x)
{
    lli m, n, q, r, xm, xn, xr;
    m = abs(a); xm = 1;
    n = abs(b); xn = 0;
    while (n != 0)
    {
        q = m / n;
        r = m - q * n;
        xr = xm - q * xn;
        m = n; xm = xn;
        n = r; xn = xr;
    }
    if (c % m != 0) return false;
    x = MulMod(xm, abs(c) / m, abs(b) / m);
    if ((a < 0) != (c < 0)) x = -x;
    return true;
}

inline lli LCM(lli a, lli b)
{
    lli res = a * b;
    while (b != 0)
    {
        lli r = a % b; a = b; b = r;
    }
    return res / a;
}

void Enter()
{
    for (int i = 0; i < 4; i++)
        cin >> d[i] >> r[i];
}

lli Solve()
{
    for (int i = 2; i >= 0; i--)
    {
        lli y, x, newd;
        if (!SolveDiophantine(d[i], -d[i + 1], r[i + 1] - r[i], y)) return -1;
        newd = LCM(d[i], d[i + 1]);
        x = (MulMod(y, d[i], newd) + r[i]) % newd;
        d[i] = newd; r[i] = x;
    }
    return r[0];
}

void SolveAll()
{
    int m;
    cin >> m;
    for (; m > 0; m--)
    {
        Enter();
        cout << Solve() << '\n';
    }
}

int main()
{
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);
    freopen(taskname".inp", "r", stdin);
    freopen(taskname".out", "w", stdout);
    SolveAll();
}

