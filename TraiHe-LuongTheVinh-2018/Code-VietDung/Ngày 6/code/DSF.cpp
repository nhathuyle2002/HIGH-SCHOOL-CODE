#include <iostream>
#include <stdio.h>
#define For(i,a,b) for(int i=a; i<=b; i++)

using namespace std;
const int N = 100100;
int root[N], kq, n, m;

void nhap()
{
    freopen("DSF.INP","r",stdin);
    freopen("DSF.OUT","w",stdout);
    scanf("%d%d", &n, &m);
}
int find_root(int u)
{
    if (root[u] != u) root[u] = find_root(root[u]);
    return root[u];
}
void xuly()
{
    For(u,1,n) root[u] = u;
    int u, v;
    kq = n;
    For(i,1,m)
    {
        scanf("%d%d\n", &u, &v);
        int tu = find_root(u);
        int tv = find_root(v);
        if (tu != tv)
        {
            root[tu] = tv;
            kq--;
        }
        printf("%d\n", kq);
    }
}

int main()
{
    nhap();
    xuly();
    return 0;
}
