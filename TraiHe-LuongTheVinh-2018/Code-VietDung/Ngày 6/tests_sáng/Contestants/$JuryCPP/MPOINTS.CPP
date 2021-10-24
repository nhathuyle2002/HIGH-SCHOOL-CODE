/*
#Dijkstra, #Convex Hull Trick, #bignum
*/
#define taskname "MPOINTS"
#include <iostream>
#include <cstdio>
#include <vector>
#include <queue>
#include <array>
#include <algorithm>
using namespace std;
typedef long long lli;
const int maxN = 1e5 + 1;
const int maxW = 1e6;
const lli maxD = lli(maxN) * maxW;
struct TAdjNode
{
    int v, w;
};
int n, m, k;
vector<TAdjNode> adj[maxN];
lli d[maxN];

struct TPQNode
{
    int vertex;
    lli dist;
    inline bool operator < (const TPQNode& other) const
    {
        return dist > other.dist;
    }
};
priority_queue<TPQNode> pq;
inline int Sign(lli x)
{
    if (x < 0) return -1;
    else if (x > 0) return 1;
    else return 0;
}
struct TBigNum
{
    const lli Radix = 1e9;
    const int nd = 4;
    int sgn;
    array<lli, 4> d;
    TBigNum()
    {
        fill(d.begin(), d.end(), 0);
    }
    TBigNum(lli x)
    {
        sgn = Sign(x);
        x = abs(x);
        fill(d.begin(), d.end(), 0);
        for (int i = 0; i < nd; ++i)
        {
            d[i] = x % Radix; x /= Radix;
            if (x == 0) break;
        }
    }
    inline TBigNum operator * (const TBigNum& other) const
    {
        TBigNum res;
        res.sgn = sgn * other.sgn;
        if (res.sgn == 0)
        {
            fill(res.d.begin(), res.d.end(), 0);
            return res;
        }
        for (int i = 0; i < nd; ++i)
            for (int j = 0; j < nd; ++j)
            {
                int k = i + j;
                res.d[k] += d[i] * other.d[j];
                while (k < nd && res.d[k] > Radix)
                {
                    res.d[k + 1] += res.d[k] / Radix;
                    res.d[k] %= Radix;
                    ++k;
                }
            }
        return res;
    }
    inline bool operator > (const TBigNum& other)
    {
        if (sgn != other.sgn) return sgn > other.sgn;
        if (sgn == 0) return 0;
        int cmp = 0;
        for (int i = nd - 1; i >= 0; --i)
            if (d[i] != other.d[i])
            {
                cmp = Sign(d[i] - other.d[i]);
                break;
            }
        return cmp * sgn > 0;
    }
};
struct TVector
{
    lli x, y;
    TVector inline operator -(const TVector& other) const
    {
        return {x - other.x, y - other.y};
    }
    lli inline operator *(const TVector& other) const
    {
        TBigNum p1 = TBigNum(x) * TBigNum(other.y);
        TBigNum p2 = TBigNum(y) * TBigNum(other.x);
        if (p1 > p2) return 1;
        if (p2 > p1) return -1;
        return 0;
    }
};
typedef TVector TPoint;
TVector p[maxN], q[maxN];
int np, nq;

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
    n = ReadInt(); m = ReadInt(); k = ReadInt();
    for (; m > 0; --m)
    {
        int u = ReadInt();
        adj[u].push_back({ReadInt(), ReadInt()});
    }
}

inline int Extract()
{
    do
    {
        if (pq.empty()) return -1;
        TPQNode node = pq.top(); pq.pop();
        if (d[node.vertex] == node.dist) return node.vertex;
    }
    while (true);
}

inline void Update(int v, lli newd)
{
    if (newd < d[v])
    {
        d[v] = newd;
        pq.push({v, newd});
    }
}

void Dijkstra(int s)
{
    fill_n(&d[1], n, maxD);
    d[s] = 0;
    pq.push({s, 0});
    while (true)
    {
        int u = Extract();
        if (u < 0) break;
        for (const TAdjNode& node: adj[u])
            Update(node.v, d[u] + node.w);
    }
    //NO NEED to empty priority queue
}

void Measuring()
{
    Dijkstra(1);
    for (int i = 1; i <= n; ++i) p[i].x = d[i];
    Dijkstra(n);
    for (int i = 1; i <= n; ++i) p[i].y = d[i];
}

inline bool CCW(const TPoint& a, const TPoint& b, const TPoint& c)
{
    return (b - a) * (c - b) > 0;
}

void FindConvexLine()
{
    sort(p + 1, p + n + 1, [](const TPoint& a, const TPoint& b)
    {
        return a.x < b.x || a.x == b.x && a.y < b.y;
    });
    for (int i = 2; i <= n; ++i)
        if (p[i].x == p[i - 1].x) p[i].y = maxD;
    np = 0;
    for (int i = 1; i <= n; ++i)
        if (p[i].x < maxD && p[i].y < maxD) p[++np] = p[i];
    nq = 0;
    for (int i = 1; i <= np; ++i)
    {
        while (nq >= 2 && !CCW(q[nq - 1], q[nq], p[i])) --nq;
        q[++nq] = p[i];
    }
}

inline lli DotProd(const TVector& a, const TVector& b)
{
    return a.x * b.x + a.y * b.y;
}

inline bool GoBetter(int i, const TVector& v)
{
    if (i <= 1) return true;
    if (i > nq) return false;
    return DotProd(v, q[i - 1]) > DotProd(v, q[i]);
}

void Solve()
{
    for (; k > 0; --k)
    {
        TVector v;
        v.x = ReadInt(); v.y = ReadInt();
        int low = 2, high = nq; //low - 1: go better, high + 1: not
        while (low <= high)
        {
            int middle = (low + high) / 2;
            if (GoBetter(middle, v)) low = middle + 1;
            else high = middle - 1;
        }
        lli res = DotProd(v, q[high]);
        WriteInt(res);
        putchar('\n');
    }
}

int main()
{
    ios_base::sync_with_stdio(false);
    cin.tie(nullptr);
    freopen(taskname".inp", "r", stdin);
    freopen(taskname".out", "w", stdout);
    Enter();
    Measuring();
    FindConvexLine();
    Solve();
}
