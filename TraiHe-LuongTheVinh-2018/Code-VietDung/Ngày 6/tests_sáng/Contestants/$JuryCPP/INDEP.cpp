#define taskname "INDEP"
#include <iostream>
#include <cstdio>
#include <string>
using namespace std;
const int maxN = 1e6;
const int neginf = -maxN - 1;
string s;

struct TNet
{
    int f, fi, fo, fio;
};

TNet g, L[maxN];
int top = -1;

void Enter()
{
    getline(cin, s);
    g.f = 0;
    g.fi = 1;
    g.fo = 1;
    g.fio = neginf;
}

TNet S(const TNet& x, const TNet y)
{
    TNet res;
    res.f = max(x.f + y.f, x.fo + y.fi - 1);
    res.fi = max(x.fi + y.f, x.fio + y.fi - 1);
    res.fo = max(x.f + y.fo, x.fo + y.fio - 1);
    res.fio = max(x.fi + y.fo, x.fio + y.fio - 1);
    return res;
}

TNet P(const TNet& x, const TNet& y)
{
    TNet res;
    res.f = x.f + y.f;
    res.fi = x.fi + y.fi - 1;
    res.fo = x.fo + y.fo - 1;
    res.fio = max(x.fio + y.fio - 2, neginf);
    return res;
}

void Solve()
{
    for (int i = s.length() - 1; i >= 0; i--)
        switch(s[i])
        {
        case 'g': L[++top] = g; break;
        case 'S': L[top - 1] = S(L[top - 1], L[top]); top--; break;
        case 'P': L[top - 1] = P(L[top - 1], L[top]); top--; break;
        }
    TNet& res = L[0];
    cout << max(max(res.f, res.fi), max(res.fo, res.fio));
}

int main()
{
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);
    freopen(taskname".inp", "r", stdin);
    freopen(taskname".out", "w", stdout);
    Enter();
    Solve();
}
