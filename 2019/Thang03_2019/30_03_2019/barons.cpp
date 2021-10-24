#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define ford(i,a,b) for(int i=(a); i>=(b); i--)
using namespace std;
//////

typedef pair<int, int> pii;
const
    int maxn=55, oo=1e7;
int n;
pii a[maxn];
int f[maxn][maxn];
int dl[maxn][maxn], dr[maxn][maxn];
//////

void addedge(int u, int v)
{
    int dx=a[v].first-a[u].first, dy=a[v].second-a[u].second;
    if (dx<=0 || dy<=0)
    {
        dl[u][v]=-1; dr[u][v]=oo;
        return;
    }
    ford(L, 10000, 0)
    {
        if (L==0)
        {
            dl[u][v]=-1; dr[u][v]=oo;
            return;
        }
        int R=L+dy-1, sum=(R+L)*(R-L+1)/2;
        if (sum<=dx)
        {
            dl[u][v]=L;
            dr[u][v]=R;
            if (sum<dx) dr[u][v]++;
            return;
        }
    }
}

void enter()
{
    scanf("%d\n", &n);
    forn(i, 1, n) scanf("%d%d\n", &a[i].first, &a[i].second);
    sort(a+1, a+n+1);

    a[0].first=0; a[0].second=0;
    forn(u, 0, n)
        forn(v, u+1, n)
            addedge(u, v);
    /*forn(u, 1, n)
    {
        int x=a[u].first, y=a[u].second, sum=y*(y-1)/2;
        if (y==1)
        {
            dl[0][u]=1; dr[0][u]=0;
            continue;
        }
        if (sum<=x-1)
        {
            dl[0][u]=1; dr[0][u]=y-1;
        } else
        {
            dl[0][u]=-1; dr[0][u]=oo;
        }
    }*/
}
//////

void process()
{
    forn(u, 1, n)
        if (dl[0][u]>-1) f[0][u]=1; else f[0][u]=-1;

    forn(u, 1, n)
        forn(v, u+1, n)
        {
            f[u][v]=-1;
            forn(t, 0, u-1)
                if (f[t][u]>-1 && dr[t][u]<dl[u][v])
                    f[u][v]=max(f[u][v], f[t][u]+1);
        }
    f[0][0]=0;
    int ur, vr;
    forn(u, 0, n)
        forn(v, u+1, n)
        {
            if (f[u][v]>f[0][0])
            {
                ur=u;
                vr=v;
            }
            f[0][0]=max(f[0][0], f[u][v]);
        }
    cout << f[0][0];
    //cout << ' ' << a[ur].first << ' ' << a[ur].second << ' ' << a[vr].first << ' ' << a[vr].second;
}
//////

int main()
{
    freopen("barons.inp", "r", stdin);
    freopen("barons.out", "w", stdout);
    enter();
    process();
}
