#include <iostream>
#include <stdio.h>
#include <vector>
#define For(i,a,b) for(int i=a; i<=b; i++)

using namespace std;
const int N = 360;
int a[N][N],n,kq,dd[2*N],d[2*N];
vector<int> e[2*N], c[2*N];

void nhap()
{
    freopen("CNTab1.INP","r",stdin);
    freopen("CNTab1.OUT","w",stdout);
    scanf("%d", &n);
    For(i,1,n) For(j,1,n) scanf("%d", &a[i][j]);
    For(i,1,n)
    For(j,1,n)
    {
        int t;
        scanf("%d", &t);
             if (a[i][j] == 0 && t == 0) a[i][j] = -1;
        else if (a[i][j] == 0 || t == 0) {kq = -1; return;}
        else if (a[i][j] == t) a[i][j] = 0;
        else a[i][j] = 1;
    }
}
void dfs(int u, int t)
{
    dd[u] = t;
    For(i,0,(int)e[u].size()-1)
    {
        int v = e[u][i];
        if (dd[v] != 0)
        {
            if (dd[v] != dd[u]) kq = -1;
        } else dfs(v, t);
    }
    For(i,0,(int)c[u].size()-1)
    {
        int v = c[u][i];
        if (dd[v] != 0)
        {
            if (dd[v] == dd[u]) kq = -1;
        } else dfs(v, -t);
    }
}
void xuly()
{
    For(i,1,n)
    For(j,1,n)
        if (a[i][j] == 0)
        {
            e[i].push_back(n+j);
            e[n+j].push_back(i);
        }
        else if (a[i][j] == 1)
        {
            c[i].push_back(n+j);
            c[n+j].push_back(i);
        }
    For(i,1,2*n)
        if ( !dd[i] ) dfs(i, 1);
}
void in_kq()
{
    if (kq == -1) return;
    For(i,1,2*n)
        if (dd[i] > 0) d[++kq] = i;
}

int main()
{
    nhap();
    xuly();
    in_kq();
    printf("%d\n", kq);
    For(i,1,kq)
        if (d[i] <= n) printf("1 %d\n", d[i]);
        else printf("2 %d\n", d[i]-n);
    return 0;
}
