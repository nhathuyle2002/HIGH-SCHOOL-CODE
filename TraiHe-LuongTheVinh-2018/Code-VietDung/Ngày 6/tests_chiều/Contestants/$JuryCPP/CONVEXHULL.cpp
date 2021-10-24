#define taskname "CONVEXHULL"
#include <iostream>
#include <cstdio>
#include <algorithm>

using namespace std;
const int maxN = 1e5;
typedef long long TCoord;
struct TPoint
{
    TCoord x, y;
};
typedef TPoint TVector;
int n, m;
TPoint p[maxN], q[maxN + 1], A;

inline TCoord SqrLen(const TVector& u)
{
    return u.x * u.x + u.y * u.y;
}

inline TVector operator +(const TVector& u, const TVector& v)
{
    return {u.x + v.x, u.y + v.y};
}

inline TVector operator -(const TVector& u, const TVector& v)
{
    return {u.x - v.x, u.y - v.y};
}

inline TCoord operator %(const TVector& u, const TVector& v)
{
    return u.x * v.x + u.y * v.y;
}

inline TCoord operator *(const TVector& u, const TVector& v)
{
    return u.x * v.y - u.y * v.x;
}

inline bool CCW(const TPoint& A, const TPoint& B, const TPoint& C)
{
    return (B - A) * (C - B) > 0;
}

void Enter()
{
    cin >> n;
    for (int i = 0; i < n; ++i)
        cin >> p[i].x >> p[i].y;
}

void FindA()
{
    int j = 0;
    for (int i = 1; i < n; ++i)
        if (p[i].y < p[j].y || p[i].y == p[j].y && p[i].x < p[j].x)
            j = i;
    A = p[j]; p[j] = p[0]; p[0] = A;
}

void GrahamScan()
{
    sort(p + 1, p + n, [](const TPoint& B, const TPoint& C)
    {
        TVector u = B - A, v = C - A;
        TCoord temp = u * v;
        return temp > 0 || temp == 0 && SqrLen(u) < SqrLen(v);
    });
}

void FindConvexHull()
{
    m = 0;
    for (int i = 0; i < n; ++i)
    {
        while (m >= 2 && !CCW(q[m - 2], q[m - 1], p[i]))
            --m;
        q[m++] = p[i];
    }
}

void Print()
{
    q[m] = q[0];
    TCoord res = 0;
    for (int i = 0; i < m; ++i)
        res += q[i] * q[i + 1];
    cout << m << '\n';
    cout << res / 2 << '.' << (res % 2 == 0 ? 0:5) << '\n';
    for (int i = 0; i < m; ++i)
        cout << q[i].x << ' ' << q[i].y << '\n';
}

int main()
{
    ios_base::sync_with_stdio(false);
    cin.tie(nullptr);
    freopen(taskname".INP", "r", stdin);
    freopen(taskname".OUT", "w", stdout);
    Enter();
    FindA();
    GrahamScan();
    FindConvexHull();
    Print();
}
