#include <bits/stdc++.h>
#define forn(i,a,b) for (int i=(a); i<=(b); i++)
#define ford(i,a,b) for (int i=(a); i>=(b); i--)
using namespace std;
//////

const
    int maxn=110;
const
    int dx[4]={-1, 0, 1, 0}, dy[4]={0, 1, 0, -1};

int n, m, k, res, cou;
int a[maxn][maxn], d[maxn][maxn];
vector<int> Q;
//////

void enter()
{
    scanf("%d%d%d", &n, &m, &k);
    forn(i, 1, n)
    {
        char s[maxn];
        scanf("\n%s", s+1);
        forn(j, 1, m)
            a[i][j]=s[j]-48;
    }
}
//////

void dfs(int x, int y)
{
    cou++;
    d[x][y]=0;
    forn(div, 0, 3)
    {
        int _x=x+dx[div], _y=y+dy[div];
        if (_x>=0 && _y>=0 && _x<=3 && _y<=3 && d[_x][_y]==1) dfs(_x, _y);
    }
}

void create()
{
    Q.clear();
    forn(_xx, 0, (1<<16)-1)
    {
        cou=0;
        forn(x, 0, 3)
            forn(y, 0, 3)
                d[x][y]=0;
        bool okx=false, oky=false;

        int x, y;
        forn(i, 0, 15)
            if (((_xx>>i)&1)==1)
            {
                x=i/4; y=i%4;
                d[x][y]=1;
                cou++;
                if (x==0) okx=true;
                if (y==0) oky=true;
            }

        if (cou!=k || !okx || !oky) continue;
        cou=0;
        dfs(x, y);
        if (cou==k) Q.push_back(_xx);
    }
}
//////

void process()
{
    res=0;
    forn(i, 1, n)
        forn(j, 1, m)
            for(int _xx : Q)
            {
                bool ok=true;
                forn(t, 0, 15)
                    if (((_xx>>t)&1)==1)
                    {
                        int x=t/4, y=t%4;
                        if (i-x<=0 || j-y<=0 || a[i-x][j-y]!=0)
                        {
                            ok=false;
                            break;
                        }
                    }
                if (ok) res++;
            }

    if (k==5)
    {
        forn(i, 1, n)
            forn(j, 1, m)
            {
                bool okx=true, oky=true;
                forn(t, 0, 4)
                {
                    if (i-t<=0 || a[i-t][j]!=0) okx=false;
                    if (j-t<=0 || a[i][j-t]!=0) oky=false;
                }
                if (okx) res++;
                if (oky) res++;
            }
    }
    cout << res;
}
//////

int main()
{
    freopen("colorgraph.inp", "r", stdin);
    freopen("colorgraph.out", "w", stdout);
    enter();
    create();
    process();
}
