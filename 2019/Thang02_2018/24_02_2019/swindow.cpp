#include <iostream>
#include <stdio.h>
#include <string.h>

using namespace std;
///////

const
    int maxn=1e6+100;

int na, nb, nc, k;
char a[maxn], b[maxn];
int z[maxn*2], d[maxn*2];
char c[maxn*2];
int res;
///////

void enter()
{
    scanf("%[^\n]\n", a); na=strlen(a);
    scanf("%[^\n]\n", b); nb=strlen(b);
    scanf("%d", &k);
}
///////

void gan(char x[], char y[])
{
    int ny=strlen(y);
    for (int i=0; i<ny; i++) x[i]=y[i];
    x[ny]='\0';
}

void noi(char x[], char y[])
{
    int nx=strlen(x), ny=strlen(y);
    for (int i=0; i<ny; i++) x[nx+i]=y[i];
    x[nx+ny]='\0';
}

void process()
{
    res=0;
    if (nb>k) return;

    gan(c, b);
    noi(c, "@"); noi(c, a);
    nc=strlen(c);
    z[0]=0;

    int l=0, r=0;
    for (int i=1; i<nc; i++)
    {
        z[i]=0;
        if (i<=r) z[i]=min(r-i+1, z[i-l]);
        while (i+z[i]<nc && c[i+z[i]]==c[z[i]]) z[i]++;
        if (i+z[i]-1>r)
        {
            l=i; r=i+z[i]-1;
        }
        if (z[i]>=nb)
        {
            d[max(0, i-k+nb)]++;
            d[i+1]--;
        }
    }

    for (int i=0; i<nc-k+1; i++)
    {
        if (i>0) d[i]+=d[i-1];
        if (d[i]>0) res++;
    }
    cout << res;
}

int main()
{
    freopen("swindow.inp", "r", stdin);
    freopen("swindow.out", "w", stdout);
    enter();
    process();
}
