#include <iostream>
#include <stdio.h>

using namespace std;
///////

const
    int maxn=1e5+100;
int n, k, m;
int xx[maxn], yy[maxn], nnum[maxn];
///////

void enter()
{
    scanf("%d%d%d", &n, &k, &m);
    for (int i=1; i<=m; i++) scanf("%d%d%d", &xx[i], &nnum[i], &yy[i]);
}
///////

int dequy(int i, int pos)
{
    if (i==0) return pos;
    int x=xx[i], y=yy[i], num=nnum[i];
    if (y<=pos && pos<=y+num-1) pos=x+pos-y; else
    if (pos<y)
    {
        if (pos>=x) pos+=num; else pos=pos;
    } else
    if (pos>y+num-1)
    {
        pos-=num;
        if (pos>=x) pos+=num; else pos=pos;
    }
    return dequy(i-1, pos);
}

void process()
{
    for (int i=1; i<=k; i++) cout << dequy(m, i) << ' ';
}
///////

int main()
{
    freopen("cards.inp", "r", stdin);
    freopen("cards.out", "w", stdout);
    enter();
    process();
}
