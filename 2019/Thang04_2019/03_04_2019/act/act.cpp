#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define ford(i,a,b) for(int i=(a); i>=(b); i--)

using namespace std;
//////

const
    int maxn=1e6+100;
const
    int c[6]={4, 3, 1, 5, 4, 10};
bool d[6][6];
int f[maxn][6], g[maxn];
///////

void enter()
{
    forn(i, 0, 5) d[0][i]=false;
    d[0][2]=true;
    forn(i, 0, 5) d[1][i]=true;
    forn(i, 0, 5) d[2][i]=true;
    forn(i, 0, 5) d[3][i]=false;
    d[3][5]=true;
    forn(i, 0, 5) d[4][i]=false;
    d[4][3]=true;
    forn(i, 0, 5) d[5][i]=true;

    forn(i, 0, 5) f[0][6]=0;
    forn(x, 1, int(1e6))
    {
        forn(i, 0, 5)
        {
            f[x][i]=maxn+1;
            forn(j, 0, 5)
                if (d[j][i] && x-c[i]>=0) f[x][i]=min(f[x][i], f[x-c[i]][j]+1);
        }
        g[x]=min(f[x][1], min(f[x][2], f[x][5]));
    }
}
///////

void process()
{
    int T; scanf("%d\n", &T);
    while (T--)
    {
        int x; scanf("%d\n", &x);
        cout << g[x] << '\n';
    }
}
///////

int main()
{
    freopen("act.inp", "r", stdin);
    freopen("act.out", "w", stdout);
    enter();
    process();
}
