#include <iostream>
#include <stdio.h>
#include <vector>
#include <math.h>
#define For(i,a,b) for(int i=a; i<=b; i++)
#define Fod(i,a,b) for(int i=a; i>=b; i--)

using namespace std;
const int N = 300100;
int h[N], a[N], p[N][20], in[N], it[4*N], pos[N], n, dem;
int doi[N];
struct data{int k, l,r;};
vector<int> e[N];

int Max(int i, int j)
{
    if (i == -1) return j;
    if (j == -1) return i;
    if (a[i] >= a[j]) return i; return j;
}
void nhap()
{
    freopen("SALARY.INP","r",stdin);
    freopen("SALARY.OUT","w",stdout);
    scanf("%d", &n);
    scanf("%d", &a[0]);
    For(i,1,n)
    {
        scanf("%d%d\n", &a[i], &p[i][0]);
        e[p[i][0]].push_back(i);
    }
}
void dfs(int u)
{
    int r = 0;
    doi[++r] = u;
    in[u] = ++dem;
    for(int i=0; i<e[u].size(); i++)
    {
        h[e[u][i]] = h[u]+1;
        dfs(e[u][i]);
    }
}
int LCA(int u, int v)
{
    if (h[u] < h[v]) swap(u, v);
    if (v == n+2) return v;
    int k = log2(h[u]);
    Fod(i,k,0)
        if (h[u] - (1 << i) >= h[v]) u = p[u][i];
    if (u == v) return u;
    Fod(i,k,0)
        if (p[u][i] != 0 && p[u][i] != p[v][i])
        {
            u = p[u][i];   v = p[v][i];
        }
    return p[u][0];
}
void build(int k, int l, int r)
{
    it[k] = -1;
    if (l == r)
    {
        pos[l] = k; return;
    }
    int mid = (r+l)/2;
    build(k*2, l, mid);
    build(k*2+1, mid+1, r);
}
void init()
{
    int l = log2(n);
    For(j,1,l)
    For(i,1,n)
        if (p[i][j-1] != 0)
            p[i][j] = p[p[i][j-1]][j-1];
}
void update(int u)
{
    it[pos[in[u]]] = u;
    u = pos[in[u]]/2;
    while (u)
    {
        it[u] = Max(it[u*2+1], it[u*2]);
        u/= 2;
    }
}
data get_left(int k, int l, int r, int u)
{
    if (l >= in[u]) return {-1, -1, -1};
    if (r <= in[u])
    {
        if (a[it[k]] >= a[u]) return {k, l, r};
        else return {-1, -1, -1};
    }
    int mid = (r+l) >> 1;
    data t = get_left(k*2+1, mid+1, r, u);
    if (t.k != -1 ) return t;
    t = get_left(k*2, l, mid, u);
    if (t.k != -1 ) return t;
    return {-1, -1, -1};
}
data get_right(int k, int l, int r, int u)
{
    if (r <= in[u]) return {-1, -1, -1};
    if (l >= in[u])
    {
        if (a[it[k]] >= a[u]) return {k, l, r};
        else return {-1, -1, -1};
    }
    int mid = (r+l) >> 1;
    data t = get_right(k*2, l, mid, u);
    if (t.k != -1 ) return t;
    t = get_right(k*2+1, mid+1, r, u);
    if (t.k != -1 ) return t;
    return {-1, -1, -1};
}
int tim_trai(int k, int l, int r, int u)
{
    if (l == r) return it[k];
    int mid = (r+l) >> 1;
    if (a[it[k*2+1]] >= a[u]) return tim_trai(k*2+1, mid+1, r, u);
    return tim_trai(k*2, l, mid, u);
}
int tim_phai(int k, int l, int r, int u)
{
    if (l == r) return it[k];
    int mid = (r+l) >> 1;
    if (a[it[k*2]] >= a[u]) return tim_phai(k*2, l, mid, u);
    return tim_phai(k*2+1, mid+1, r, u);
}

void xuly()
{
    update(0);
    For(u,1,n)
    {
        data trai = get_left(1, 1, dem, u);
        data phai = get_right(1, 1, dem, u);
        int le = n+2, ri = n+2;
        if (trai.k != -1) le = tim_trai(trai.k, trai.l, trai.r, u);
        if (phai.k != -1) ri = tim_phai(phai.k, phai.l, phai.r, u);
        int t1 = LCA(le, u),  t2 = LCA(ri, u);
        printf("%d\n", h[u] - max(h[t1], h[t2]) - 1);
        update(u);
    }
}
int main()
{
    nhap();
    h[0] = 1;
    dfs(0);
    build(1, 1, dem);
    init();
    xuly();
    return 0;
}

/*
24
2293
3554 0
4019 1
4667 0
6434 1
7338 4
9552 4
9071 4
11223 4
11636 0
9317 9
14090 9
12601 8
14343 8
16488 10
14959 5
18211 9
20214 14
19555 16
18213 16
23788 19
20507 18
23956 20
25707 21
27977 18

1
2
1
2
3
3
0
3
1
0
2
3
4
3
3
2
4
1
0
4
1
5
5
4
*/
