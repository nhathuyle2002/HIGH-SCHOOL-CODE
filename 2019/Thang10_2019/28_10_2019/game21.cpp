#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

typedef pair<int, int> pii;
const
    int maxn=10;
const
    pii d1[5]={{0, 0}, {-1, 0}, {0, 1}, {1, 0}, {0, -1}},
    d2[9]={{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 0}, {0, 1}, {1, -1}, {1, 0}, {1, 1}};

int n, res, couk;
bool dd[maxn][maxn], dd1[maxn][maxn], dd2[maxn][maxn];
int a[maxn][maxn];
pii nex[maxn][maxn];
//////

void enter()
{
    forn(i, 1, 5)
        forn(j, 1, 5) dd[i][j]=true;
    dd[1][1]=false; dd[1][5]=false; dd[5][1]=false; dd[5][5]=false;
    forn(i, 1, 5)
        forn(j, 1, 5)
            if (dd[i][j]) cin >> a[i][j];

    int x;
    forn(i, 1, 5)
        forn(j, 1, 5)
            if (dd[i][j])
            {
                cin >> x;
                if (x!=a[i][j]) a[i][j]=1; else a[i][j]=0;
            }

    forn(i, 2, 4)
        forn(j, 2, 4)
            dd1[i][j]=true;

    dd2[2][3]=true; dd2[3][2]=true; dd2[3][3]=true; dd2[3][4]=true; dd2[4][3]=true;

    forn(i, 2, 4)
        forn(j, 2, 4)
            if (j==4) nex[i][j]={i+1, 2}; else
            nex[i][j]={i, j+1};
}
//////

void dao(int i, int j)
{
    a[i][j]=1-a[i][j];
    if (a[i][j]==0) --couk; else ++couk;
}

void change1(int x, int y)
{
    forn(div, 0, 4)
        dao(x+d1[div].first, y+d1[div].second);
}

void change2(int x, int y)
{
    forn(div, 0, 8)
        dao(x+d2[div].first, y+d2[div].second);
}

void dequy(int x, int y, int cou)
{
    if (cou>=res) return;
    if (couk==0)
    {
        res=cou;
        return;
    }
    if (x>4) return;

    dequy(nex[x][y].first, nex[x][y].second, cou);

    if (dd1[x][y])
    {
        change1(x, y);
        dequy(nex[x][y].first, nex[x][y].second, cou+1);
        change1(x, y);
    }

    if (dd2[x][y])
    {
        change2(x, y);
        dequy(nex[x][y].first, nex[x][y].second, cou+1);
        change2(x, y);
    }

    if (dd1[x][y] && dd2[x][y])
    {
        change1(x, y); change2(x, y);
        dequy(nex[x][y].first, nex[x][y].second, cou+2);
        change1(x, y); change2(x, y);
    }
}

void process()
{
    res=1e8;

    couk=0;
    forn(i, 1, 5)
        forn(j, 1, 5)
        if (dd[i][j])
            if (a[i][j]==1) couk++;
    dequy(2, 2, 0);

    couk=0;
    forn(i, 1, 5)
        forn(j, 1, 5)
        if (dd[i][j])
        {
            a[i][j]=1-a[i][j];
            if (a[i][j]==1) couk++;
        }
    dequy(2, 2, 1);

    if (res==1e8) cout << -1; else cout << res;
}
//////

int main()
{
    freopen("game21.inp", "r", stdin);
    freopen("game21.out", "w", stdout);
    enter();
    process();
}
