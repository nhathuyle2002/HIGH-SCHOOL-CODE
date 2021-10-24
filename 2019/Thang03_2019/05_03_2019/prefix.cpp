#include <iostream>
#include <stdio.h>
#include <algorithm>
#include <string.h>

using namespace std;
//////

struct data
{
    int leng;
    long long h[11];
    bool operator < (const data &A) const {return leng<A.leng;}
};

const   int maxn=2e4+100;
const   int base=28;
int n;
data a[maxn];

int nb, nc;
long long b[maxn], c[maxn];
int db[maxn], dc[maxn];
int res;
//////

void enter()
{
    scanf("%d\n", &n);
    for (int i=1; i<=n; i++)
    {
        char s[11];
        scanf("%s\n", s+1);
        a[i].leng=strlen(s+1);
        a[i].h[0]=0;
        for (int j=1; j<=a[i].leng; j++)
            a[i].h[j]=(a[i].h[j-1]*base+s[j]-96);
    }

    sort(a+1, a+n+1);
}
//////

void process()
{
    res=0;
    int l=1, r=1;

    for (int len=1; len<=10; len++)
    {
        while (l<=n && a[l].leng<len) l++;
        while (r<=n && a[r].leng<=len) r++;
        if (l>n) break;

        for (int i=l; i<r; i++)
            b[i-l+1]=a[i].h[len];
        sort(b+1, b+r-l+1);
        nb=0; b[0]=-1;
        for (int i=1; i<=r-l; i++)
            if (b[i]>b[nb])
            {
                nb++;
                b[nb]=b[i]; db[nb]=1;
            }
            else db[nb]++;

        for (int i=r; i<=n; i++)
            c[i-r+1]=a[i].h[len];
        sort(c+1, c+n-r+2);
        nc=0;
        for (int i=1; i<=n-r+1; i++)
            if (c[i]>c[nc])
            {
                nc++;
                c[nc]=c[i]; dc[nc]=1;
            }
            else dc[nc]++;

        for (int i=1; i<=nb; i++)
        {
            res+=db[i]*(db[i]-1)/2;
            int p=lower_bound(c+1, c+nc+1, b[i])-c;
            if (p<=nc && c[p]==b[i]) res+=db[i]*dc[p];
        }
    }
    cout << res;
}
//////

void process2()
{
    res=0;
    for (int i=1; i<=n; i++)
        for (int j=i+1; j<=n; j++)
    {
        int l1=a[i].leng;
        if (a[i].h[l1]==a[j].h[l1]) res++;
    }
    cout << '\n' << res;
}
//////

int main()
{
    freopen("prefix.inp", "r", stdin);
    freopen("prefix.out", "w", stdout);
    enter();
    process();
    //process2();
}
