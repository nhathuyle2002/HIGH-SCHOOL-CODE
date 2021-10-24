#include <iostream>
#include <stdio.h>

using namespace std;
//////

const
    int maxn=210, oo=2e9+100;
int T, n;
int l[maxn], p[maxn];
int f[2][maxn*maxn];
//////

void enter()
{
    scanf("%d\n", &n);
    for (int i=1; i<=n; i++) scanf("%d", &l[i]);
    scanf("\n");
    for (int i=1; i<=n; i++) scanf("%d", &p[i]);
    scanf("\n");
}
//////

void process()
{
    int min_pos, max_pos=0, pos, id=0;
    f[0][0]=0;
    for (int i=1; i<=n; i++)
    {
        id=1-id;
        pos=max_pos;
        if (l[i]>0) max_pos+=l[i];

        for (int j=0; j<=pos; j++) f[id][j]=f[1-id][j];
        for (int j=pos+1; j<=max_pos; j++) f[id][j]=-oo;

        min_pos=pos+l[i];
        for (int j=max(0, l[i]); j<=min_pos; j++)
            f[id][j]=max(f[id][j], f[1-id][j-l[i]]+p[i]);
    }

    int res=-oo;
    for (int j=0; j<=max_pos; j++)
        res=max(res, f[id][j]);
    cout << res << '\n';
}
//////

int main()
{
    freopen("dance.inp", "r", stdin);
    freopen("dance.out", "w", stdout);
    scanf("%d/n", &T);
    while (T--)
    {
        enter();
        process();
    }
}
