#include <iostream>
#include <stdio.h>
#include <algorithm>
#define For(i,a,b) for(int i=a; i<=b; i++)
#define Fod(i,a,b) for(int i=a; i>=b; i--)
#define gt first
#define vt second

using namespace std;
const int N = 1010;
int e[N][N], lk[N][N], tests, n, chan[N], le[N], kq;
typedef pair<int, int> data;
data a[N];

void open()
{
    freopen("FOOTBALL.INP","r",stdin);
    freopen("FOOTBALL.OUT","w",stdout);
    scanf("%d", &tests);
}
void fillchar()
{
    le[0] = chan[0] = 0;
    For(u,1,n) e[u][0] = 0;
}
void nhap()
{
    scanf("%d", &n);
    For(i,1,n)
    {
        scanf("%d", &a[i].gt);
        a[i].vt = i;
    }
}
void add(int u, int v)
{
    e[u][++e[u][0]] = v;   lk[u][v] = tests;
}
void build()
{
    sort(a+1, a+1+n);
    int le;
    Fod(i,n,1)
    {
        le = 0;
        int t = i - a[i].gt, pos;
        if (t < 1) {kq = -1; return;}
        Fod(j,i-1,t)
            if (a[j].gt > a[t].gt)
            {
                add(a[i].vt, a[j].vt);
                add(a[j].vt, a[i].vt);
                a[j].gt--;
                if (a[j].gt < 0) {kq = -1; return;}
            } else {le = j-t+1; break;}
        while (t > 1 && a[t].gt == a[t-1].gt) t--;
        For(j,t,t+le-1)
        {
            add(a[i].vt, a[j].vt);
            add(a[j].vt, a[i].vt);
            a[j].gt--;
            if (a[j].gt < 0) {kq = -1; return;}
        }
    }
}
void dfs(int u, int t)
{
    bool ok = true;
    int v;
    do{
        if (e[u][0] == 0)
        {
            ok = false; break;
        }
        v = e[u][1];
        e[u][1] = e[u][e[u][0]];
        e[u][0]--;
    } while (lk[u][v] != tests);
    if (!ok) return;
    lk[v][u] = 0;
    dfs(v, t);
    printf("%d %d ", u, v);
}
void xuly()
{
    For(u,1,n)
        if (e[u][0] % 2 == 1) le[++le[0]] = u;
        else chan[++chan[0]] = u;
    For(i,1,le[0])
        if (e[le[i]][0] > 0) dfs(le[i], 1);
    For(i,1,chan[0])
        if (e[chan[i]][0] > 0) dfs(chan[i], 0);
}

int main()
{
    open();
    tests++;
    while (tests-- > 1)
    {
        nhap();
        fillchar();
        build();
        if (kq == -1) printf("-1");
            else xuly();
        printf("\n");
    }
    return 0;
}
