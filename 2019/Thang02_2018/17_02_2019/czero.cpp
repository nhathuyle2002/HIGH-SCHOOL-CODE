#include <iostream>
#include <stdio.h>

using namespace std;
////////

const
    int maxk=32;

long long f[40][40];
long long n, k, res;
int n2;
////////

void create()
{
    f[0][0]=1;
    for (int i=1; i<=maxk; i++)
    {
        f[i][0]=1; f[i][i]=1;
        for (int j=1; j<i; j++)
            f[i][j]=f[i-1][j]+f[i-1][j-1];
    }
}
////////

void enter()
{
    //scanf("%lld%lld", &n, &k);
    long long x=n; n2=0;
    while (x>0)
    {
        n2++;
        x/=2;
    }
}
////////

int getb(int i, long long x)
{
    return (x>>(i-1)&1);
}

void process()
{
    res=0;
    if (k>32) return;
    int cou=0;
    for (int i=n2-1; i>=1; i--)
    {
        res+=f[i-1][k];
        if (getb(i, n)==0) cou++; else
        if (k>cou) res+=f[i-1][k-cou-1];
    }
    if (cou==k) res++;
}

int main()
{
    freopen("czero.inp", "r", stdin);
    freopen("czero.out", "w", stdout);
    create();
    while (scanf("%lld%lld", &n, &k)>0)
    {
        enter();
        process();
        cout << res << '\n';
    }
}
