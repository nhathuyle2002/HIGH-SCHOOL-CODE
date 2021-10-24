#include <iostream>
#include <stdio.h>
#include <algorithm>

using namespace std;
////////

struct data
{
    long long x; int cou;
    bool operator < (const data &A) const
    {
        if (x!=A.x) return x<A.x;
        return (cou<A.cou);
    }
};
data make_data(long long _x, int _cou)
{
    data y;
    y.x=_x; y.cou=_cou;
    return y;
}
////////

typedef long long ll;

const   int maxn=35, maxbit=1 << 18;
int n, m, n1, maxb1, n2, maxb2;
ll maxb;
bool d[maxn][maxn];
int fcou1[maxbit];
ll f1[maxbit], f2[maxbit];
data b[maxbit];
int res;
////////

int getb(int &i, int &x)
{
    return (x >> (i-1)) & 1;
}

int daob(int &i, int &x)
{
    return x xor (1 << (i-1));
}

ll daobll(int &i, ll &x)
{
    return x xor (ll(1) << (i-1));
}
////////

void enter()
{
    scanf("%d%d\n", &n, &m);
    for (int i=1; i<=m; i++)
    {
        int u, v;
        scanf("%d%d\n", &u, &v);
        d[u][v]=true;
        d[v][u]=true;
    }
    for (int i=1; i<=n; i++) d[i][i]=true;

    n1=n/2; maxb1=(1 << n1)-1;
    n2=n-n1; maxb2=(1 << n2)-1;

    for (int x=0; x<=maxb2; x++)
    {
        fcou1[x]=0;
        for (int i=1; i<=n2; i++)
            if (getb(i, x)==1) fcou1[x]++;
    }
}
////////

void init1()
{
    f1[0]=0;
    for (int x=1; x<=maxb1; x++)
    {
        int i2;
        for (int i=1; i<=n1; i++)
            if (getb(i, x)==1)
        {
            f1[x]=f1[daob(i, x)];
            i2=i;
            break;
        }
        for (int j=1; j<=n; j++)
            if (d[i2][j]) f1[x]=daobll(j, f1[x]);
    }
}

void init2()
{
    f2[0]=0; b[0]=make_data(0, 0);
    for (int x=1; x<=maxb2; x++)
    {
        int i2;
        for (int i=1; i<=n2; i++)
            if (getb(i, x)==1)
        {
            f2[x]=f2[daob(i, x)];
            i2=i;
            break;
        }
        for (int j=1; j<=n; j++)
            if (d[n1+i2][j]) f2[x]=daobll(j, f2[x]);
        b[x]=make_data(f2[x], fcou1[x]);
    }
}

////////

void process()
{
    sort(b, b+maxb2+1);
    res=n+1;
    maxb=(ll(1) << n)-1;
    for (int x=0; x<=maxb1; x++)
    {
        int p=lower_bound(b, b+maxb2+1, make_data(maxb-f1[x], 0))-b;
        if (p<=maxb2 && maxb-f1[x]==b[p].x)
            res=min(res, fcou1[x]+b[p].cou);
    }
    //for (int i=0; i<=maxb2; i++) cout << b[i].x << ' ' << b[i].cou << '\n';
    cout << res;
}
////////

int main()
{
    freopen("lights.inp", "r", stdin);
    freopen("lights.out", "w", stdout);
    enter();
    init1();
    init2();
    process();
}
