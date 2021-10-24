#include <iostream>
#include <stdio.h>

using namespace std;
//////

const
    int maxn=16+2, maxbit=1 << maxn;

int n;
int a[maxn];
long long m;
int start, finish;
int cou, stc;
int q[maxbit], d[maxbit];
//////

void enter()
{
    scanf("%d%lld\n", &n, &m);
    for (int i=1; i<=n; i++)
        scanf("%d\n", &a[i]);
    start=0;
    for (int i=n; i>=1; i--) start=start*2+a[i];
}
//////

int getb(int i, int x)
{
    return x >> (i-1) & 1;
}

int  daob(int i, int x)
{
    int k=getb(i, x);
    if (k==0) return x | (1 << (i-1)); else
    return x & (~ (1 << (i-1)));
}
//////

void process()
{
    for (int i=0; i<=(1 << n)-1; i++) d[i]=0;
    cou=1; q[1]=start;
    d[start]=1;
    do
    {
        int x=q[cou], y=x;
        for (int i=1; i<=n; i++)
            if (getb(i, x)==1)
        {
            if (i==n) y=daob(1, y); else
                y=daob(i+1, y);
        }
        if (d[y]==0)
        {
            cou++; q[cou]=y;
            d[y]=cou;
        } else
        {
            stc=d[y];
            break;
        }
    }
    while (true);
    m++;
    if (m>=stc)
    {
        m=m-stc+1;
        m=(m-1) % (cou-stc+1)+1+ stc-1;
    }
    for (int i=1; i<=n; i++)
        cout << getb(i, q[m]) << '\n';
}
//////

int main()
{
    freopen("blink.inp", "r", stdin);
    freopen("blink.out", "w", stdout);
    enter();
    process();
}
