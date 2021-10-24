/*
    #Extended Euclid, #Inverse Modulo
*/
#define taskname "PAPERS"
#include <iostream>
#include <cstdio>

using namespace std;
typedef long long lli;
const lli MOD = 1e9 + 7;

lli m, n;

void ReadInput()
{
    cin >> m >> n;
    for (int i = 0; i < n; ++i)
    {
        lli a;
        cin >> a;
        m -= a - 1;
    }
}

lli Inverse(lli a)
{
    lli m = a, n = MOD;
    lli xm = 1, xn = 0;
    while (n != 0)
    {
        lli q = m / n;
        lli r = m - q * n;
        lli xr = xm - q * xn;
        m = n; xm = xn;
        n = r; xn = xr;
    }
    return (xm % MOD + MOD) % MOD;
}

lli Solve()
{
    if (m < n) return 0;
    lli a = 1, b = 1;
    for (int i = m - n + 1; i <= m - 1; ++i) a = a * i % MOD;
    for (int i = 1; i <= n - 1; ++i) b = b * i % MOD;
    return a * Inverse(b) % MOD;
}

int main()
{
    ios_base::sync_with_stdio(false);
    cin.tie(nullptr);
    freopen(taskname".inp", "r", stdin);
    freopen(taskname".out", "w", stdout);
    ReadInput();
    cout << Solve();
}
