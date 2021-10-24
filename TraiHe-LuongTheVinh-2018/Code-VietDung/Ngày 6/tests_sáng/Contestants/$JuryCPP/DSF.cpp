/*
Disjoint-Set Forest
*/
#include <iostream>
#include <cstdio>
using namespace std;
const int maxN = 1e5;

int n, m, lab[maxN + 1], ncc;

int FindSet(int u)
{
    return lab[u] < 0 ? u : lab[u] = FindSet(lab[u]);
}

void Union(int r, int s)
{
    if (lab[r] > lab[s]) swap(r, s);
    lab[r] += lab[s];
    lab[s] = r;
}

int main()
{
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);
    freopen("DSF.inp", "r", stdin);
    freopen("DSF.out", "w", stdout);

    cin >> n >> m;
    fill_n(&lab[1], n, -1);
    ncc = n;
    for (; m > 0; m--)
    {
        int u, v, r, s;
        cin >> u >> v;
        r = FindSet(u);
        s = FindSet(v);
        if (r != s)
        {
            Union(r, s);
            ncc--;
        }
        cout << ncc << '\n';
    }
}
