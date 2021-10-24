#include <iostream>
#include <stdio.h>
#include <string.h>

using namespace std;
////////

const
    int maxl=1e5+100;
int n, ns, csc, csl;
char s[maxl], fb1[maxl*2], fb2[maxl*2];
long long f[111];
////////

void gan(char a[], char b[])
{
    int nb=strlen(b);
    for (int i=0; i<nb; i++) a[i]=b[i];
    a[nb]='\0';
}

void noi(char a[], char b[])
{
    int na=strlen(a), nb=strlen(b);
    for (int i=0; i<nb; i++) a[na+i]=b[i];
    a[na+nb]='\0';
}

int z_function(char a[], char b[])
{
    if (strlen(a)<strlen(b)) return 0;
    char c[maxl*3];
    int z[maxl*3];
    c[0]='\0';
    noi(c, b); noi(c, "@"); noi(c, a);
    z[0]=0;

    int rr=0, nc=strlen(c), nb=strlen(b), l=0, r=0;
    for (int i=1; i<nc; i++)
    {
        z[i]=0;
        if (i<=r) z[i]=min(z[i-l], r-i+1);
        while (i+z[i]<nc && c[z[i]]==c[i+z[i]]) z[i]++;
        if (z[i]==nb) rr++;
        if (i+z[i]-1>r)
        {
            l=i; r=i+z[i]-1;
        }
    }
    return rr;
}
////////

void process()
{
    ns=strlen(s);
    char ftm[maxl*2];
    int p=0;
    gan(fb1, "A"); f[1]=z_function(fb1, s);
    gan(fb2, "B"); f[2]=z_function(fb2, s);
    for (int i=3; i<=n; i++)
    {
        gan(ftm, fb2);
        noi(fb2, fb1);
        gan(fb1, ftm);
        f[i]=z_function(fb2, s);
        if (i>5 && strlen(fb1)>=ns)
        {
            p=i;
            break;
        }
    }
    if (p==0) return;
    char d1[maxl], c1[maxl*2], d2[maxl], c2[maxl*2];

    int nf1=strlen(fb1), nf2=strlen(fb2);
    gan(d1, fb1); d1[ns-1]='\0';
    gan(d2, fb2); d2[ns-1]='\0';

    for (int i=0; i<ns-1; i++)
    {
        c1[i]=fb1[i+nf1-ns+1];
        c2[i]=fb2[i+nf2-ns+1];
    }
    c1[ns-1]='\0';
    c2[ns-1]='\0';
    noi(c2, d1);
    noi(c1, d2);

    csl=z_function(c2, s);
    csc=z_function(c1, s);
    if (p % 2==1) swap(csc, csl);

    for (int i=p+1; i<=n; i++)
        if (i % 2==0) f[i]=f[i-1]+f[i-2]+csc; else
        f[i]=f[i-1]+f[i-2]+csl;
}

int main()
{
    freopen("fibistr.inp", "r", stdin);
    freopen("fibistr.out", "w", stdout);
    while (scanf("%d%s\n", &n, s)>0)
    {
        process();
        cout << f[n] << '\n';
    }
}
