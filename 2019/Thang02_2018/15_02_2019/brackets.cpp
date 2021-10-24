#include <iostream>
#include <stdio.h>
#include <string.h>

using namespace std;
////////

const
    int maxn=5e2+10,
    maxsl=1e2,
    base=1e9;

int n, k;
int f[maxn][maxn][maxsl], g[maxn][maxn][maxsl];
////////

void enter()
{
    scanf("%d%d", &n, &k);
}
////////

void chuyensl(int x, int a[])
{
    a[0]=0;
    while (x>0)
    {
        a[0]++;
        a[a[0]]=x%base;
        x/=base;
    }
}
////////

void insl(int a[])
{
    cout << a[a[0]];
    for (int i=a[0]-1; i>=1; i--)
    {
        int cou=0, x=a[i];
        while (x>0)
        {
            x/=10;
            cou++;
        }
        for (int j=1; j<=9-cou; j++) cout << 0;
        if (a[i]!=0) cout << a[i];
    }
    cout << '\n';
}
////////

void cong(int a[], int b[], int c[])
{
    c[0]=max(a[0],b[0]);
    int nho=0;
    for (int i=1; i<=c[0]; i++)
    {
        if (i>a[0]) a[i]=0;
        if (i>b[0]) b[i]=0;
        c[i]=a[i]+b[i]+nho;
        if (c[i]>=base)
        {
            nho=1;
            c[i]-=base;
        }
        else nho=0;
    }
    if (nho>0)
    {
        c[0]++;
        c[c[0]]=nho;
    }
}
////////

void tru(int a[], int b[], int c[])
{
    c[0]=a[0];
    int nho=0;
    for (int i=1; i<=c[0]; i++)
    {
        if (i>a[0]) a[i]=0;
        if (i>b[0]) b[i]=0;
        c[i]=a[i]-b[i]-nho;
        if (c[i]<0)
        {
            nho=1;
            c[i]+=base;
        }
        else nho=0;
    }
    while (c[0]>0 && c[c[0]]==0) c[0]--;
}
////////

/*

<< nhan so lon thi phai dung long long >>

void nhan(long long a[], long long b[], long long c[])
{
    c[0]=a[0]+b[0];
    for (int i=1; i<=c[0]; i++) c[i]=0;
    long long nho;
    for (int i=1; i<=a[0]; i++)
    {
        nho=0;
        for (int j=1; j<=b[0]; j++)
        {
            c[i+j-1]+=a[i]*b[j]+nho;
            nho=c[i+j-1]/base;
            c[i+j-1]%=base;
        }
        c[i+b[0]]+=nho;
    }
    nho=0;
    for (int i=1; i<=c[0]; i++)
    {
        c[i]+=nho;
        nho=c[i]/base;
        c[i]%=base;
    }
    if (c[c[0]]==0) c[0]--;
}
*/
////////

void process()
{
    n=n/2+1;
    for (int i=1; i<=n; i++)
        for (int j=1; j<=i; j++)
            if (i-j<=k)
            {
                if (i==1 && j==1) chuyensl(1, f[i][j]); else
                cong(f[i-1][j], f[i][j-1], f[i][j]);
            }
    for (int i=1; i<=n; i++)
        for (int j=1; j<=i; j++)
            if (i-j<k)
            {
                if (i==1 && j==1) chuyensl(1, g[i][j]); else
                cong(g[i-1][j], g[i][j-1], g[i][j]);
            }
    int res[maxsl];
    tru(f[n][n], g[n][n], res);
    insl(res);
}
////////

void process2()
{
    long long f[maxn][maxn], g[maxn][maxn];
    for (int i=0; i<=n; i++)
        for (int j=0; j<=n; j++)
        {
            f[i][j]=0;
            g[i][j]=0;
        }
    for (int i=1; i<=n; i++)
        for (int j=1; j<=i; j++)
            if (i-j<=k)
            {
                if (i==1 && j==1) f[i][j]=1; else
                f[i][j]=f[i-1][j]+f[i][j-1];
            }
    for (int i=1; i<=n; i++)
        for (int j=1; j<=i; j++)
            if (i-j<k)
            {
                if (i==1 && j==1) g[i][j]=1; else
                g[i][j]=g[i-1][j]+g[i][j-1];
            }
    cout << f[n][n]-g[n][n];
}
////////

int main()
{
    freopen("brackets.inp", "r", stdin);
    freopen("brackets.out", "w", stdout);
    enter();
    if (n%1==1) cout << 0; else
    process();
    //process2();
}
