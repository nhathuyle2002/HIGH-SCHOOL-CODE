#include <iostream>
#include <stdio.h>
#include <string.h>

using namespace std;
///////

const int maxn=21, maxbit=(1 << 20)+1;

int n, maxb;
char s[maxn][maxn];
int l[maxn];
bool d[maxn][maxn][maxn];
bool f[maxbit];
int ll[maxbit];
///////

int getb(int &i, int &x)
{
    return (x >> (i-1) & 1);
}

int daob(int &i, int &x)
{
    return x ^ (1 << (i-1));
}

///////

void enter()
{
    scanf("%d\n", &n);
    maxb=(1 << n)-1;
    for (int i=1; i<=n; i++)
    {
        scanf("%s\n", s[i]+1);
        l[i]=strlen(s[i]+1);
    }
}
///////

void init()
{
    for (int i=1; i<=n; i++)
        for (int j=1; j<=n; j++)
            for (int k=1; k<=l[i]; k++)
    {
        d[i][j][k]=true;
        if (k+l[j]-1>l[i]) d[i][j][k]=false; else
        for (int t=1; t<=l[j]; t++)
            if (s[i][k+t-1]!=s[j][t])
        {
            d[i][j][k]=false;
            break;
        }
    }
    ll[0]=0;
    for (int x=1; x<=maxb; x++)
        for (int i=1; i<=n; i++)
            if (getb(i, x)==1) ll[x]+=l[i];
}
///////

int xulibit(int &t)
{
    f[0]=true;
    for (int x=1; x<=maxb; x++)
    {
        f[x]=false;
        if (ll[x]>l[t] || getb(t, x)==1) continue;
        for (int i=1; i<=n; i++)
            if (getb(i, x)==1)
        {
            int y=daob(i, x);
            if (f[y] && d[t][i][ll[x]-l[i]+1])
            {
                f[x]=true;
                break;
            }
        }
        if (f[x] && ll[x]==l[t]) return x;
    }
    return -1;
}

void truyvet(int &t, int &x)
{
    for (int i=1; i<=n; i++)
        if (getb(i, x)==1)
    {
        int y=daob(i, x);
        if (f[y] && d[t][i][ll[x]-l[i]+1])
        {
            truyvet(t, y);
            cout << i << ' ';
            break;
        }
    }
}


void process()
{
    for (int t=1; t<=n; t++)
    {
        int x=xulibit(t);
        if (x==-1) continue;
        cout << 1 << '\n';
        cout << s[t]+1 << '\n';
        cout << 2 << '\n';
        cout << t << '\n';
        truyvet(t, x);
        return;
    }
    cout << 0;
}
///////

int main()
{
    freopen("code.inp", "r", stdin);
    freopen("code.out", "w", stdout);
    enter();
    init();
    process();
}
