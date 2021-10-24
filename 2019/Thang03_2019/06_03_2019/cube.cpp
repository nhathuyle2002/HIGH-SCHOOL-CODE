#include <iostream>
#include <stdio.h>

using namespace std;

///////

int res;
int d[33][33][33];

///////

int pow2(int i)
{
    return 1 << i;
}

void solve(int n, int x, int y, int z, int a, int b, int c)
{
    if (n==1)
    {
        res++;
        for (int i=a; i<=a+1; i++) for (int j=b; j<=b+1; j++) for (int k=c; k<=c+1; k++)
            if (i!=x || j!=y || k!=z) d[i][j][k]=res;
        return;
    }

    int pos, m=pow2(n-1);
    if (x<a+m && y<b+m && z<c+m) pos=1; else
    if (x<a+m && y<b+m && z>=c+m) pos=2; else
    if (x<a+m && y>=b+m && z<c+m) pos=3; else
    if (x<a+m && y>=b+m && z>=c+m) pos=4; else
    if (x>=a+m && y<b+m && z<c+m) pos=5; else
    if (x>=a+m && y<b+m && z>=c+m) pos=6; else
    if (x>=a+m && y>=b+m && z<c+m) pos=7; else
    if (x>=a+m && y>=b+m && z>=c+m) pos=8;

    solve(1, 0, 0, 0, a+m-1, b+m-1, c+m-1);// o bang 0 thi se bi phu lai cuoi cung gan d[x][y][z]=0;

    if (pos==1) solve(n-1, x, y, z, a, b, c); else
        solve(n-1, a+m-1, b+m-1, c+m-1, a, b, c);

    if (pos==2) solve(n-1, x, y, z, a, b, c+m); else
        solve(n-1, a+m-1, b+m-1, c+m, a, b, c+m);

    if (pos==3) solve(n-1, x, y, z, a, b+m, c); else
        solve(n-1, a+m-1, b+m, c+m-1, a, b+m, c);

    if (pos==4) solve(n-1, x, y, z, a, b+m, c+m); else
        solve(n-1, a+m-1, b+m, c+m, a, b+m, c+m);

    if (pos==5) solve(n-1, x, y, z, a+m, b, c); else
        solve(n-1, a+m, b+m-1, c+m-1, a+m, b, c);

    if (pos==6) solve(n-1, x, y, z, a+m, b, c+m); else
        solve(n-1, a+m, b+m-1, c+m, a+m, b, c+m);

    if (pos==7) solve(n-1, x, y, z, a+m, b+m, c); else
        solve(n-1, a+m, b+m, c+m-1, a+m, b+m, c);

    if (pos==8) solve(n-1, x, y, z, a+m, b+m, c+m); else
        solve(n-1, a+m, b+m, c+m, a+m, b+m, c+m);
}

///////

int main()
{
    freopen("cube.inp", "r", stdin);
    freopen("cube.out", "w", stdout);

    int n, x, y, z;
    scanf("%d%d%d%d", &n, &x, &y, &z);

    for (int i=1; i<=pow2(n); i++) for (int j=1; j<=pow2(n); j++)
        for (int k=1; k<=pow2(n); k++) d[i][j][k]=0;
    res=0;
    solve(n, x, y, z, 1, 1, 1);
    d[x][y][z]=0;

    for (int i=1; i<=pow2(n); i++) for (int j=1; j<=pow2(n); j++)
    {
        for (int k=1; k<=pow2(n); k++) cout << d[i][j][k] << ' ';
        cout << '\n';
    }
}
