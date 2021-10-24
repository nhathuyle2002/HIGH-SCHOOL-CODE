#include <iostream>
#include <stdio.h>
#include <deque>

#define _x first
#define _y second

using namespace std;
///////

typedef pair<int, int> pii;
const
    int maxn=3010;
const
    int di[]={0, 0, 1}, dj[]={-1, 1, 0};
int n, x0, y0;
int a[maxn][maxn], d[maxn][maxn];
deque<pii> q;

///////

void enter()
{
    scanf("%d%d%d\n", &n, &x0, &y0);
    for (int i=1; i<=n; i++)
    {
        for (int j=1; j<=n; j++)
            scanf("%d", &a[i][j]);
        scanf("\n");
    }
}
///////

void process()
{
    q.clear();
    d[1][1]=1; q.push_back(pii(1, 1));
    while (!q.empty())
    {
        pii u=q.front(); q.pop_front();
        int x, y;
        for (int k=0; k<=2; k++)
        {
            x=u._x+di[k];
            y=u._y+dj[k];
            if (x<1 || x>n || y<1 || y>n || d[x][y]>0 || a[x][y]==1) continue;
            d[x][y]=d[u._x][u._y]+1;
            q.push_back(pii(x, y));
        }
        if (d[x0][y0]>0) break;
    }
    cout << d[x0][y0];
}
///////

int main()
{
    freopen("congian.inp", "r", stdin);
    freopen("congian.out", "w", stdout);
    enter();
    process();
}
