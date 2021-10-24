#include <iostream>
#include <stdio.h>
#include <queue>
#include <vector>

using namespace std;
//////

struct dataq
{
    int x, y, k, w;
};
struct comp
{
    bool operator() (dataq x, dataq y) {return x.w>y.w;}
};
struct data3
{
    int x, y, k;
};

const
    int maxn=1e3+10,
    oo=1e9;
const
    int di[4]={-1, 0, 1, 0}, dj[4]={0, 1, 0, -1};

int m, n, k;
int a[maxn][maxn];
int f[maxn][maxn][6];
data3 trace[maxn][maxn][6];
dataq rr;
vector<data3> ot;

priority_queue<dataq, vector<dataq>, comp> q;
//////

void enter()
{
    scanf("%d%d%d\n", &m, &n, &k);
    for (int i=1; i<=m; i++)
        for (int j=1; j<=n; j++)
            scanf("%d", &a[i][j]);
}
//////

void process()
{
    for (int i=1; i<=m; i++)
        for (int j=1; j<=n; j++)
            for (int l=0; l<=k; l++)
                f[i][j][l]=oo;
    for (int i=1; i<=m; i++)
    {
        f[i][1][0]=a[i][1];
        dataq u;
        u.x=i; u.y=1; u.k=0; u.w=a[i][1];
        q.push(u);
    }

    do
    {
        if (q.empty()) break;
        dataq u=q.top(); q.pop();
        if (f[u.x][u.y][u.k]<u.w) continue;
        if (u.y==n)
        {
            rr=u;
            break;
        }

        for (int k2=0; k2<4; k2++)
        {
            dataq v;
            v.x=u.x+di[k2]; v.y=u.y+dj[k2];
            if (v.x<=0 || v.x>m || v.y<=0 || v.y>n) continue;
            if (a[u.x][u.y]==0)
            {
                v.k=k-1; v.w=u.w;
                if (f[v.x][v.y][v.k]>v.w)
                {
                    f[v.x][v.y][v.k]=v.w;
                    data3 x;
                    x.x=u.x; x.y=u.y; x.k=u.k;
                    trace[v.x][v.y][v.k]=x;
                    q.push(v);
                }
            } else
            if (u.k==0)
            {
                v.k=u.k; v.w=u.w+a[v.x][v.y];
                if (f[v.x][v.y][v.k]>v.w)
                {
                    f[v.x][v.y][v.k]=v.w;
                    data3 x;
                    x.x=u.x; x.y=u.y; x.k=u.k;
                    trace[v.x][v.y][v.k]=x;
                    q.push(v);
                }
            } else
            if (u.k>0)
            {

                v.k=u.k-1; v.w=u.w;
                if (f[v.x][v.y][v.k]>v.w)
                {
                    f[v.x][v.y][v.k]=v.w;
                    data3 x;
                    x.x=u.x; x.y=u.y; x.k=u.k;
                    trace[v.x][v.y][v.k]=x;
                    q.push(v);
                }
            }
        }
    }
    while (true);
}
//////

void print()
{
    cout << rr.w << '\n';
    ot.clear();
    data3 u;
    u.x=rr.x; u.y=rr.y; u.k=rr.k;
    while (u.x>0)
    {
        ot.push_back(u);
        u=trace[u.x][u.y][u.k];
    }
    for (int i=(int)(ot.size())-1; i>=0; i--) cout << ot[i].x << ' ' << ot[i].y << '\n';
}
//////

int main()
{
    freopen("fair.inp", "r", stdin);
    freopen("fair.out", "w", stdout);
    enter();
    process();
    print();
}
