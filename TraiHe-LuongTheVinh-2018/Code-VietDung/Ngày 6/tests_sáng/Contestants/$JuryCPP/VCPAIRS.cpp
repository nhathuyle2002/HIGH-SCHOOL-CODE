#define taskname "VCPAIRS"
#include <iostream>
#include <cstdio>
#include <unordered_map>
using namespace std;
typedef long long lli;
const int maxN = 1e5 + 1;
int n, m, lab[maxN];
typedef unordered_map<int, int> TSet;
typedef TSet* PSet;
PSet Set[maxN];
lli res;

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

int FindSet(int u)
{
    return lab[u] <= 0 ? u : lab[u] = FindSet(lab[u]);
}

int Union(int r, int s)
{
    if (lab[r] < lab[s]) return lab[s] = r;
    else
    {
        if (lab[r] == lab[s]) --lab[s];
        return lab[r] = s;
    }
}

inline lli Comb(int x)
{
    return (lli)x * (x - 1) / 2;
}

inline void Update(int a, int b)
{
    res -= Comb(a) + Comb(b);
    res += Comb(a + b);
}

PSet UnionSet(PSet& r, PSet& s)
{
    if (r->size() < s->size()) swap(r, s);
    for (const auto& srec: *s)
    {
        auto FindRes = r->find(srec.first);
        if (FindRes == r->end())
            r->insert(srec);
        else
        {
            Update(FindRes->second, srec.second);
            FindRes->second += srec.second;
        }
    }
    delete s;
    return r;
}

int main()
{
    ios_base::sync_with_stdio(false);
    cin.tie(nullptr);
    freopen(taskname".inp", "r", stdin);
    freopen(taskname".out", "w", stdout);
    n = ReadInt(); m = ReadInt();
    fill_n(&lab[1], n, 0);
    for (int i = 1; i <= n; ++i)
    {
        int c = ReadInt();
        Set[i] = new TSet;
        Set[i]->insert({c, 1});
    }
    res = 0;
    for (; m > 0; --m)
    {
        int u, v;
        u = ReadInt(); v = ReadInt();
        u = FindSet(u); v = FindSet(v);
        if (u != v)
        {
            int r = Union(u, v);
            Set[r] = UnionSet(Set[u], Set[v]);
        }
        WriteInt(res);
        putchar('\n');
    }
}
