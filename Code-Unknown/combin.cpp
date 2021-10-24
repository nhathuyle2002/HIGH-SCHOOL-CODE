#include <bits/stdc++.h>
#define forn(i, a, b) for (int i=(a); i<=(b); ++i)
#define ford(i, a, b) for (int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=33;
int n, k, m;
int f[maxn][maxn];
int a[maxn];
//////

void enter()
{
    scanf("%d%d%d", &n, &k, &m);
    m++;
    f[0][0]=1;
    forn(i, 1, n)
    {
        f[i][0]=1;
        forn(j, 1, i)
            f[i][j]=f[i-1][j]+f[i-1][j-1];
    }
}
//////

void process()
{
    a[0]=0;
    forn(i, 1, k)
    {
        int sum=0;
        forn(j, a[i-1]+1, n)
        {
            if (sum+f[n-j][k-i]>=m)
            {
                a[i]=j;
                m-=sum;
                break;
            }
            sum+=f[n-j][k-i];
        }
    }
    forn(i, 1, k) cout << a[i] << ' ';
}
//////

int main()
{
    freopen("combin.inp", "r", stdin);
    freopen("combin.out", "w", stdout);
    enter();
    process();
}
