#include <bits/stdc++.h>
#define forn(i,a,b) for (int i=(a); i<=(b); i++)
#define repn(i,a,b) for (int i=(a); i<(b); i++)

using namespace std;
//////

const
    int maxk=10, maxbitk=1 << 10, maxn=5e4+10, base=123457;
int dtru[maxbitk][maxbitk], d[maxbitk];
int k, n;
int a[maxn];
int f[2][maxbitk];
//////

int getb(int i, int x)
{
    return (x >> i) & 1;
}

void daob(int i, int &x)
{
    x=x ^ (1 << i);
}

void init()
{
    repn(i, 0, maxbitk)
    {
        d[i]=0;
        repn(t, 0, maxk)
            if (getb(t, i)==1) ++d[i];
    }

    repn(i, 0, maxbitk) repn(j, 0, maxbitk)
    {
        dtru[i][j]=0;
        repn(t, 0, maxk)
            if (getb(t, i)==1 && getb(t, j)==0) daob(t, dtru[i][j]);
    }
}
//////

void enter()
{
    scanf("%d%d\n", &k, &n);
    forn(i, 1, n)
    {
        int cou, x;
        a[n-i+1]=0;
        scanf("%d", &cou);
        forn(cc, 1, cou)
        {
            scanf("%d", &x);
            daob(x, a[n-i+1]);
        }
        scanf("\n");
    }
}
//////

void process()
{
    repn(x, 0, maxbitk) f[0][x]=0;
    int id=0;
    forn(i, 1, n)
    {
        id=1-id;
        repn(x, 0, maxbitk) f[id][x]=f[1-id][x];
        repn(x, 0, maxbitk) f[id][dtru[a[i]][x]]=(f[id][dtru[a[i]][x]]+f[1-id][x]) % base;
        ++f[id][a[i]];
    }

    int res=0;
    repn(x, 0, maxbitk)
        if (d[x]>=k) res=(res+f[id][x]) % base;
    cout << res;
}

int main()
{
    freopen("kstr.inp", "r", stdin);
    freopen("kstr.out", "w", stdout);
    init();
    enter();
    process();
}
