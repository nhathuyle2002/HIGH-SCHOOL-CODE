/*
*/
#define taskname "ARCHER"
#include <iostream>
#include <cstdio>
#include <map>
#include <algorithm>
using namespace std;
const int maxN = 2000;
int n, bx[maxN], by[maxN], bz[maxN];

struct TVector
{
    int x, y, z;
    inline bool operator < (const TVector& other) const
    {
        if (x != other.x) return x < other.x;
        if (y != other.y) return y < other.y;
        return z < other.z;
    }
};

void ReadInput()
{
    cin >> n;
    for (int i = 0; i < n; ++i)
        cin >> bx[i] >> by[i] >> bz[i];
}

inline int gcd(int x, int y)
{
    if (x < 0) x = -x;
    if (y < 0) y = -y;
    while (y != 0)
    {
        int r = x % y;
        x = y;
        y = r;
    }
    return x;
}

typedef pair<TVector, int> TMapElement;
inline bool lfreq(const TMapElement& a, const TMapElement& b)
{
    return a.second < b.second;
}

int Solve1(int k)
{
    map<TVector, int> f;
    int cz = 0;
    for (int i = k; i < n; ++i)
    {
        int x = bx[i] - bx[k], y = by[i] - by[k], z = bz[i] - bz[k];
        if (x == 0 && y == 0 && z == 0)
        {
            ++cz;
            continue;
        }
        if (z == 0)
            continue;
        int d = gcd(gcd(x, y), z);
        TVector v;
        if (z > 0)
            v = {x / d, y / d, z / d};
        else
            v = {-x / d, -y / d, -z / d};
        auto insres = f.insert({v, 0});
        ++(insres.first->second);
    }
    int res1;
    if (!f.empty())
        res1 = max_element(f.begin(), f.end(), lfreq)->second;
    else
        res1 = 0;
    return res1 + cz;
}

void Solve()
{
    int res = 0;
    for (int i = 0; i < n; ++i)
    {
        int temp = Solve1(i);
        if (temp > res)
            res = temp;
    }
    cout << res;
}

int main()
{
    ios_base::sync_with_stdio(false);
    cin.tie(nullptr);
    freopen(taskname".inp", "r", stdin);
    freopen(taskname".out", "w", stdout);
    ReadInput();
    Solve();
}
