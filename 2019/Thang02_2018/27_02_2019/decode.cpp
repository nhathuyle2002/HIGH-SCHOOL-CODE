#include <iostream>
#include <stdio.h>
#include <string.h>

using namespace std;
////////

const
    int maxn=1e5+100;
char x[30], y[30], h[100];
char s[maxn];
int n, m;
int l[maxn], r[maxn];
////////

void enter()
{
    scanf("%s\n", x+1);
    scanf("%s\n", s+1); n=strlen(s+1);
    scanf("%d\n", &m);
    for (int i=1; i<=m; i++)
        scanf("%d%d\n", &l[i], &r[i]);
}
////////

void init()
{
    int n2=strlen(x+1);
    for (int i=1; i<=n2+1; i++) y[i]=x[i];
    for (int i=1; i<=n2; i++)
        for (int j=i+1; j<=n2; j++)
            if (y[j]<y[i]) swap(y[i], y[j]);
    for (int i=1; i<=n2; i++)
        h[y[i]]=x[i];
}
////////

void process()
{
    for (int t=m; t>=1; t--)
    {
        char x=s[r[t]];
        for (int i=r[t]-1; i>=l[t]; i--)
            s[i+1]=h[s[i]];
        s[l[t]]=h[x];
    }
    cout << s+1;
}
////////

int main()
{
    freopen("decode.inp", "r", stdin);
    freopen("decode.out", "w", stdout);
    enter();
    init();
    process();
}
