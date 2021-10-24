#include <bits/stdc++.h>
#define forn(i, a, b) for (int i=(a); i<=(b); ++i)
#define ford(i, a, b) for (int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=110, maxg=maxn*maxn;
int n, k;
int a[maxn];
bool f[maxn][2*maxg+1];
int d[maxn];
//////

void enter()
{
    scanf("%d%d\n", &n, &k);
    forn(i, 1, n) scanf("%d", &a[i]);
}
//////

void process()
{
    f[1][a[1]+maxg]=true;
    forn(i, 1, n-1)
        forn(j, 0, 2*maxg)
        if (f[i][j])
        {
            if (j+a[i+1]<=2*maxg) f[i+1][j+a[i+1]]=true;
            if (j-a[i+1]>=0) f[i+1][j-a[i+1]]=true;
        }
    int i=n, j=k+maxg;
    while (i>1)
    {
        if (j-a[i]>=0 && f[i-1][j-a[i]])
        {
            d[i]=1;





            j-=a[i];
        } else
        {
            d[i]=-1;
            j+=a[i];
        }
        i--;
    }
    forn(i, 2, n)
        if (d[i]==1) cout << '+'; else cout << '-';
}
//////

int main()
{
    freopen("expression.inp", "r", stdin);
    freopen("expression.out", "w", stdout);
    enter();
    process();
}
