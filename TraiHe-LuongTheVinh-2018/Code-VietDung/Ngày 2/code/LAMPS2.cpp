#include <iostream>
#include <stdio.h>
#include <vector>
#define For(i,a,b) for(int i=a; i<=b; i++)
#define Fod(i,a,b) for(int i=a; i>=b; i--)

using namespace std;
const int N = 3010;
int s[N][N], khu[N][N], c[N], vt[N], dd[N];
int n, tests;

void nhap()
{
    freopen("LAMPS2.INP","r",stdin);
    freopen("LAMPS2.OUT","w",stdout);
    scanf("%d%d", &n, &tests);
    int u, v;
    For(i,1,n)
    {
        s[i][i] = 1;
        scanf("%d%d\n", &u, &v);
        s[u][v] = s[v][u] = 1;
    }
}
void khu_gauss()
{
    int d[N], r;
    Fod(x,n,1)
    {
        vt[x] = 0;
        Fod(y,n,1)
            if (s[x][y] == 1 && !dd[y])
            {
                vt[x] = y; r = 0;
                For(i,1,y)
                    if (s[x][i] == 1) d[++r] = i;
                For(u,1,n)
                    if ( u != x && s[u][y] == 1)
                    {
                        khu[x][++khu[x][0]] = u;
                        For(i,1,r) s[u][d[i]]^= 1;
                    }
                dd[y] = 1;
                break;
            }
    }
}
void xuly()
{
    Fod(u,n,1)
    if (c[u] > 0)
    For(i,1,khu[u][0])
    {
        int v = khu[u][i];
        c[v] = (c[u]+c[v]) & 1;
    }
    int kq = 0;
    For(i,1,n)
        if (vt[i] == 0 && c[i] == 1)
        {
            printf("-1\n"); return;
        }
        else if (vt[i] > 0 && c[i] == 1) kq++;
    printf("%d", kq);
    For(i,1,n)
        if (vt[i] > 0 && c[i] == 1) printf(" %d", vt[i]);
    printf("\n");
}
void run()
{
    while (tests--)
    {
        For(i,1,n)
        {
            scanf("%d", &c[i]);
            c[i] = c[i]^= 1;
        }
        xuly();
    }
}

int main()
{
    nhap();
    khu_gauss();
    run();
    return 0;
}
