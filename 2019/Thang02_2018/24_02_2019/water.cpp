#include <iostream>
#include <stdio.h>
#include <queue>
#include <utility>

#define FOR(i,a,b) for (int i=(a); i<=(b); i++)
#define pii pair<int, int>
#define fi first
#define se second

using namespace std;

const
    int maxn=1e3+10,
    maxh=1e6+10;
const
    int di[]={-1, 1, 0, 0}, dj[]={0, 0, -1, 1};

int m, n;
int h[maxn][maxn], d[maxn][maxn];
int cou1, cou2;
long long res;

struct cmp
{
    bool operator() (pii x, pii y) {return h[x.fi][x.se]>h[y.fi][y.se];}
};

priority_queue<pii, vector<pii>, cmp> q1,q2;

void enter()
{
    scanf("%d%d", &m, &n);
    FOR(i, 1, m)
        FOR(j, 1, n)
        {
            scanf("%d", &h[i][j]);
            q1.push(pii(i,j));
            d[i][j]=0;
            if (i==1 || j==1 || i==m || j==n)
            {
                d[i][j]=1;
                q2.push(pii(i,j));
            }
        }
}

void process()
{
    res=0; cou1=0; cou2=0;
    FOR(high, 1, maxh)
    {
        while (!q1.empty())
        {
            pii p=q1.top();
            if (h[p.fi][p.se]>high) break;
            q1.pop(); cou1++;
        }
        while (!q2.empty())
        {
            pii p=q2.top();
            if (h[p.fi][p.se]>high) break;
            q2.pop(); cou2++;
            FOR(t, 0, 3)
            {
                int i=p.fi+di[t];
                int j=p.se+dj[t];
                if (i>0 && i<=m && j>0 && j<=n && d[i][j]==0)
                {
                    d[i][j]=1;
                    q2.push(pii(i,j));
                }
            }
        }
        res+=cou1-cou2;
    }
    cout << res;
}

int main()
{
    freopen("water.inp", "r", stdin);
    freopen("water.out", "w", stdout);
    enter();
    process();
    return 0;
}
