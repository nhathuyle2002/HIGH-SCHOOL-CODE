#include <iostream>
#include <stdio.h>
#include <string.h>

#define forn(i,a,b) for (int i=(a); i<=(b); i++)
#define repn(i,a,b) for (int i=(a); i<(b); i++)

using namespace std;
//////

char a[7][10];
int f[7][10][26];
int res;
//////

int calc(int i2, int j2, int i1, int j1, int k)
{
    return f[i2][j2][k]-f[i1-1][j2][k]-f[i2][j1-1][k]+f[i1-1][j1-1][k];
}

void process()
{
    forn(i, 1, 6) forn(j, 1, 9)
    {
        forn(k, 0, 25) f[i][j][k]=f[i-1][j][k]+f[i][j-1][k]-f[i-1][j-1][k];
        ++f[i][j][a[i][j]-'A'];
    }

    res=6*9;
    forn(x1, 0, 25) forn(x2, 0, 25) forn(x3, 0, 25)
        if (x2!=x1 && x2!=x3)
        {
            int sum=6*9-calc(2,9,1,1,x1)-calc(4,9,3,1,x2)-calc(6,9,5,1,x3);
            res=min(res, sum);
            sum=6*9-calc(6,3,1,1,x1)-calc(6,6,1,4,x2)-calc(6,9,1,7,x3);
            res=min(res, sum);
        }
    cout << res;
}
//////

int main()
{
    freopen("flags.inp", "r", stdin);
    freopen("flags.out", "w", stdout);
    forn(i, 1, 6) scanf("%s\n", a[i]+1);
    process();
}
