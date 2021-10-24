/*
#Divide & Conquer
*/
#define taskname "DIGIT"
#include <iostream>
#include <cstdio>
typedef unsigned long long llu;
typedef long long lli;
typedef long double ld;

using namespace std;

llu a, b, k;

llu Mul(llu x, llu y)
{
    x %= b; y %= b;
    llu q = (ld)x * y / b;
    lli r = lli(x * y - q * b) % lli(b);
    if (r < 0) r += b;
    return r;
}

llu Power10(llu k)
{
    if (k == 0) return 1 % b;
    llu t = Power10(k / 2);
    t = Mul(t, t);
    if (k % 2 == 1) t = t * 10 % b;
    return t;
}

int main()
{
    ios_base::sync_with_stdio(false);
    cin.tie(nullptr);
    freopen(taskname".inp", "r", stdin);
    freopen(taskname".out", "w", stdout);
    cin >> a >> b >> k;
    cout << Mul(a, Power10(k - 1)) * 10 / b;
}
