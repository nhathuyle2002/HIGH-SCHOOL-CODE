#include <bits/stdc++.h>
#define For(i,a,b) for(int i=a; i<=b; i++)

using namespace std;
const int N = 100100;
unordered_map<int, int> m[N];
unordered_map<int, int> ::iterator it;
int n, edge, c[N], root[N];
long long kq;

void nhap()
{
    freopen("VCPAIRS.INP","r",stdin);
    freopen("VCPAIRS.OUT","w",stdout);
    scanf("%d%d", &n, &edge);
    For(i,1,n) scanf("%d", &c[i]);
}
int find_root(int u)
{
    if (root[u] != u) root[u] = find_root(root[u]);
    return root[u];
}
void xuly()
{
    long long kq = 0;
    For(i,1,n)
    {
        m[i][c[i]] = 1;  root[i] = i;
    }
    int u, v;
    while (edge--)
    {
        scanf("%d%d\n", &u, &v);
        int tu = find_root(u);
        int tv = find_root(v);
        if (tu != tv)
        {
            if (m[tu].size() > m[tv].size()) swap(tu, tv);
            for(it = m[tu].begin(); it != m[tu].end(); it++)
            {
                int mau = (*it).first, cnt = (*it).second;
                kq+= 1LL*m[tv][mau] * cnt;
                m[tv][mau]+= cnt;
                root[tu] = tv;
            }
        }
        printf("%lld\n", kq);
    }
}

int main()
{
    nhap();
    xuly();
    return 0;
}
