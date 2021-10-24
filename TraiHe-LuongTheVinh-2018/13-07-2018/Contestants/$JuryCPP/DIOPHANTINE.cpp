#include <iostream>
#include <cstdio>
using namespace std;

int main()
{
  long long a, b, c, m, n, p, q, r, xm, xn, xr, maxx, res;
  freopen("DIOPHANTINE.INP", "r", stdin);
  freopen("DIOPHANTINE.OUT", "w", stdout);
  cin >> a >> b >> c;
  m = a; xm = 1;
  n = b; xn = 0;
  while (n > 0)
  {
    q = m / n;
    r = m - q * n;
    xr = xm - q * xn;
    m = n; xm = xn;
    n = r; xn = xr;
  }
  if (c % m != 0) res = 0;
  else
  {
    p = b / m;
    xm = xm * c / m % p;
    xm = (xm % p + p) % p;
    maxx = (c - b) / a;
    if (maxx < xm) res = 0;
    else
    {
        res = (maxx - xm) / p;
        if (xm != 0) res++;
    }
  }
  cout << res;
}
