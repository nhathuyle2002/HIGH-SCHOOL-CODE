#include <iostream>
#include <stdio.h>

using namespace std;
///////

const
    int maxx=101;
int n;
int d[maxx*3+1][maxx*3+1], f[maxx*3+1][maxx*3+1];
///////

void enter()
{
    scanf("%d\n", &n);
    for (int i=1; i<=n; i++)
    {
        int c, r;
        scanf("%d%d\n", &c, &r);
        d[c+maxx-r][c+maxx+r]=1;
    }
}
///////

void process()
{
    for (int kc=1; kc<=maxx*3; kc++)
        for (int x=1; x<=maxx*3-kc; x++)
        {
            int y=x+kc;
            f[x][y]=d[x][y];
            for (int k=x+1; k<y; k++)
                f[x][y]=max(f[x][y], f[x][k]+f[k][y]+d[x][y]);
        }
    cout << n-f[1][maxx*3];
}

///////

int main()
{
    freopen("circles.inp", "r", stdin);
    freopen("circles.out", "w", stdout);
    enter();
    process();
}
