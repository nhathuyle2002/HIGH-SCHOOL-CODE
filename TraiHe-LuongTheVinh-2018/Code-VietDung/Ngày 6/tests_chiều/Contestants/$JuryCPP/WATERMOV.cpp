#define taskname "WATERMOV"
#include <iostream>
#include <cstdio>
using namespace std;
typedef long long lli;
const int maxN = 1e6 + 1;
struct TPoint
{
    lli x, y;
};
typedef TPoint TVector;
int n, m;
TPoint p[maxN], q[maxN];

inline int ReadInt()
{
    char c;
    for (c = getchar(); c < '0' || c > '9'; c = getchar());
    int res = c - '0';
    for (c = getchar(); c >= '0' && c <= '9'; c = getchar())
        res = res * 10 + c - '0';
    return res;
}

void WriteInt(lli x)
{
    if (x > 9) WriteInt(x / 10);
    putchar(x % 10 + '0');
}

void Enter()
{
    n = ReadInt();
    p[0] = {0, 0};
    for (int i = 1; i <= n; ++i)
        p[i] = {i, p[i - 1].y + ReadInt()};
}

inline lli operator *(const TVector& u, const TVector& v)
{
    return u.x * v.y - u.y * v.x;
}

inline TVector operator-(const TPoint& a, const TPoint& b)
{
    return {b.x - a.x, b.y - a.y};
}

inline bool CCW(const TPoint& a, const TPoint& b, const TPoint& c)
{
    return (b - a) * (c - b) > 0;
}

inline lli Area(const TPoint& a, const TPoint& b, const TPoint& c)
{
    return -((b - a) * (c - b));
}

lli Solve()
{
    lli res = 0;
    m = 0;
    for (int i = 0; i <= n; ++i)
    {
        while (m >= 2 && !CCW(q[m - 2], q[m - 1], p[i]))
        {
            res += Area(q[m - 2], q[m - 1], p[i]);
            --m;
        }
        q[m++] = p[i];
    }
    return res;
}


int main()
{
    ios_base::sync_with_stdio(false);
    cin.tie(nullptr);
    freopen(taskname".inp", "r", stdin);
    freopen(taskname".out", "w", stdout);
    Enter();
    lli res = Solve();
    WriteInt(res / 2);
    putchar('.');
    putchar(res % 2 == 0 ? '0' : '5');
}
