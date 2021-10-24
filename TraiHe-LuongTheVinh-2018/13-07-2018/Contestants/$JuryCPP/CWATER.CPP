#include <iostream>
#include <cstdlib>
#include <cstdio>
typedef long long TInt;
using namespace std;

TInt a, b, c;

void Diophante(TInt a, TInt b, TInt &d, TInt&x)
{
  TInt m, n, r, q, xm, xn, xr;
  m = a; xm = 1;
  n = b; xn = 0;
  while (n != 0)
  {
    q = m / n;
    r = m - q * n;
    xr = xm - q * xn;
    m = n; xm = xn;
    n = r; xn = xr;
  }
  d = m;
  x = xm;
}

TInt Solve(TInt a, TInt b, TInt c)
{
  TInt d, p, x, y;
  if (a > b)
  {
    d = a; a = b; b = d;
  }
  Diophante(a, b, d, x);
  if (c % d != 0) return -1;
  p = b / d;
  x = x * (c / d) % p;
  if (x < 0) x += p;
  y = (c - a * x) / b;
  int res1 = abs(x) + abs(y);
  x -= p;
  y = (c - a * x) / b;
  int res2 = abs(x) + abs(y);
  return res1 < res2 ? res1 : res2;
}

int main()
{
  int k;
  ios_base::sync_with_stdio(false);
  freopen("CWATER.INP", "r", stdin);
  freopen("CWATER.OUT", "w", stdout);
  cin.tie(0);
  cin >> k;
  for (; k > 0; k--)
  {
    cin >> a >> b >> c;
    cout << Solve(a, b, c) << '\n';
  }
}
