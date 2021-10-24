#include <bits/stdc++.h>

using namespace std;
//////

long long A, B, C, D;

long long GCD(long long x, long long y)
{
    if (y==0) return x;
    return GCD(y, x % y);
}

int main()
{
    freopen("npairs.inp", "r", stdin);
    freopen("npairs.out", "w", stdout);
    scanf("%lld%lld%lld%lld", &A, &B, &C, &D);

    cout << abs(A*D-B*C)-GCD(A, C)-GCD(B, D)+1;
}

/* solution trong thu muc */
