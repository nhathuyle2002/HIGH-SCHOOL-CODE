#include <iostream>
#include <stdio.h>
#include <algorithm>
#include <vector>

using namespace std;
////////

struct data
{
    int r, w, pos;
    bool operator < (const data &x) const {return r<x.r;}
};

struct data2
{
    int x, pos;
    bool operator < (const data2 &p) const {return x<p.x;}
};

const   int maxn=1e3+10;

int n, dd;
data a[maxn];
long long f[maxn][maxn];
vector<int> ot;
////////

void enter()
{
    scanf("%d%d\n", &n, &dd);
    for (int i=1; i<=n; i++) scanf("%d", &a[i].r);
    for (int i=1; i<=n; i++) scanf("%d", &a[i].w);
    for (int i=1; i<=n; i++) a[i].pos=i;
    sort(a+1, a+n+1);
}
////////

void process()
{
    for (int i=1; i<=n; i++)
        for (int j=1; j<=i; j++)
    {
        f[i][j]=f[i-1][j];
        if (j*dd<=a[i].r) f[i][j]=max(f[i][j], f[i-1][j-1]+a[i].w);
    }
    int jres=0;
    for (int j=1; j<=n; j++)
        if (f[n][j]>f[n][jres]) jres=j;
    cout << f[n][jres] << '\n';
    ot.clear();
    int i=n, j=jres;
    while (i>0 && j>0)
    {
        if (f[i-1][j-1]+a[i].w==f[i][j])
        {
            ot.push_back(a[i].pos);
            j--;
        }
        i--;
    }
    for (int i=0; i<ot.size(); i++) cout << ot[i] << ' ';
}
////////

int main()
{
    freopen("music.inp", "r", stdin);
    freopen("music.out", "w", stdout);
    enter();
    process();
}
