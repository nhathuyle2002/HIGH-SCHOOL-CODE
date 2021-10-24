#include <bits/stdc++.h>
#define foru(i, a, b) for(int i=a; i<=b; i++)

const int maxn=2e5+5;

using namespace std;

int n, m;
int a[maxn], b[maxn], bi[maxn];

void enter()
{
    scanf("%d", &n);
    foru (i, 1, n) scanf("%d", &a[i]);
    scanf("%d", &m);
    foru (i, 1, m) scanf("%d", &b[i]);
}

void up(int m, int k)
{
    while (m <= n)
    {
        bi[m] += k;
        m += (m & (-m));
    }
}

int get(int m)
{
    int re= 0;
    while (m > 0)
    {
        re += bi[m];
        m -= (m & (-m));
    }
    return re;
}

int check(int x)
{
    return (a[x] + get(x));
}

void solve()
{
    sort(a+1, a+1+n);

    int d, c, mid, t, kq;
    foru (i, 1, m)
    {
        d = lower_bound(a+1, a+1+n, b[i]) - a; c = n; mid = (d+c)/2;

        while (d != mid && c != mid)
        {
            t = check(mid);
            if (t >= b[i]) c = mid; else d = mid;
            mid = (d+c) / 2;
        }

        kq = 0;
        foru (j, d, c) if (check(j) >= b[i])
        {
            up(j, -1);
            kq = n-j+1;
            break;
        }
        cout << kq << '\n';
    }
}

int main()
{
    freopen("CANDIES.inp", "r", stdin);
    freopen("CANDIES.OUT", "w", stdout);

    enter();
    solve();
}
