#include <iostream>
#include <stdio.h>
#include <algorithm>
#include <vector>

#define FOR(i,a,b) for (int(i)=(a); i<=(b); i++)

using namespace std;

const
    int maxn=1e5+100;

struct data
{
    int x, y, w;
    data (int _x, int _y, int _w): x(_x), y(_y), w(_w) {};
};

int n;
int x[maxn], y[maxn], z[maxn], id[maxn];
vector<data> e;
int root[maxn];
long long res;

bool cmp1(int i, int j) {return x[i]<x[j];}
bool cmp2(int i, int j) {return y[i]<y[j];}
bool cmp3(int i, int j) {return z[i]<z[j];}
bool cmp4(data i, data j) {return i.w<j.w;}

int findroot(int x)
{
    while (root[x]!=x) x=root[x];
    return x;
}

void enter()
{
    scanf("%d", &n);
    FOR(i, 1, n)
        scanf("%d%d%d", &x[i], &y[i], &z[i]);

    e.clear();

    FOR(i, 1, n) id[i]=i;
    sort(id+1, id+n+1, cmp1); id[n+1]=id[1];
    FOR(i, 1, n)
        e.emplace_back(data(id[i], id[i+1], abs(x[id[i]]-x[id[i+1]])));

    FOR(i, 1, n) id[i]=i;
    sort(id+1, id+n+1, cmp2); id[n+1]=id[1];
    FOR(i, 1, n)
        e.emplace_back(data(id[i], id[i+1], abs(y[id[i]]-y[id[i+1]])));

    FOR(i, 1, n) id[i]=i;
    sort(id+1, id+n+1, cmp3); id[n+1]=id[1];
    FOR(i, 1, n)
        e.emplace_back(data(id[i], id[i+1], abs(z[id[i]]-z[id[i+1]])));
}

void process()
{
    sort(e.begin(), e.end(), cmp4);
    FOR(i, 1, n) root[i]=i;

    res=0;
    int cou=0;
    FOR(i, 0, int(e.size())-1)
    {
        int x0=findroot(e[i].x);
        int y0=findroot(e[i].y);
        if (x0!=y0)
        {
            res+=e[i].w;
            cou++;
        }
        root[y0]=x0; root[e[i].x]=x0; root[e[i].y]=x0;
        if (cou==n-1) break;
    }
    printf("%lld", res);
}

int main()
{
    //freopen("vnempire.inp", "r", stdin);
    //freopen("vnempire.out", "w", stdout);
    enter();
    process();
    return 0;
}
