/*
#double-ended queue, #dequeue
*/
#define taskname "GAS"
#include <iostream>
#include <cstdio>
#include <queue>
using namespace std;
typedef long long lli;
const int maxN = 1e6;
int n, k, c[maxN + 1];

struct TGasRec
{
    int cost, amount;
};

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
    n = ReadInt(); k = ReadInt();
    for (int i = 0; i < n; ++i)
        c[i] = ReadInt();
    c[n] = 0;
}

void Solve()
{
    lli res = 0;
    deque<TGasRec> Q;
    Q.push_back({c[0], k});
    for (int i = 1; i <= n; ++i)
    {
        res += Q.front().cost;
        --Q.front().amount;
        if (Q.front().amount == 0)
            Q.pop_front();
        int addable = 1;
        while (!Q.empty() && Q.back().cost >= c[i])
        {
            addable += Q.back().amount;
            Q.pop_back();
        }
        Q.push_back({c[i], addable});
    }
    WriteInt(res);
}

int main()
{
    ios_base::sync_with_stdio(false);
    cin.tie(nullptr);
    freopen(taskname".inp", "r", stdin);
    freopen(taskname".out", "w", stdout);
    Enter();
    Solve();
}
