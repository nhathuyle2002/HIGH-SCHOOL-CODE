#include <iostream>
#include <stdio.h>
#define For(i,a,b) for(int i=a; i<=b; i++)

using namespace std;
const int N = 1010;
int s[N][N], vt[N], dd[N],m,n,k,kq;

void nhap()
{
    freopen("BULB.INP","r",stdin);
    freopen("BULB.OUT","w",stdout);
    scanf("%d%d%d\n", &m, &n, &k);
    string ta, tb;
    getline(cin, ta);
    getline(cin, tb);
    For(i,0,m+n-1)
        if (ta[i] != tb[i]) s[i+1][k+1] = 1;
    int x, y;
    For(i,1,k)
    {
        scanf("%d%d\n", &x, &y);
        s[x][i] = 1;
        s[y+m][i] = 1;
    }
}
void khu_gauss()
{
    int d[N], r;
    n+= m;
    For(x,1,n)
    {
        For(y,1,k)
            if (s[x][y] == 1 && !dd[y])
            {
                vt[x] = y; r = 0;
                For(i,y,k+1)
                    if (s[x][i] == 1) d[++r] = i;
                For(u,1,n)
                    if ( u != x && s[u][y] == 1)
                    {
                        For(i,1,r) s[u][d[i]]^= 1;
                    }
                dd[y] = 1;
                break;
            }
        if (vt[x] == 0 && s[x][k+1] == 1) kq = -1;
    }
}
void xuly()
{
    if (kq == -1) {printf("-1"); return;}
    For(x,1,n)
        if (vt[x] > 0 && s[x][k+1] == 1) kq++;
    printf("%d\n", kq);
    For(x,1,n)
        if (vt[x] > 0 && s[x][k+1] == 1) printf("%d ", vt[x]);
}

int main()
{
    nhap();
    khu_gauss();
    xuly();
    return 0;
}
