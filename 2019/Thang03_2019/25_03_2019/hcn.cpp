#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define repn(i,a,b) for(int i=(a); i<(b); i++)
using namespace std;
//////

struct data
{
    int x1, y1, x2, y2;
    bool operator < (const data &A) const
    {
        if (x2-x1!=A.x2-A.x1) return x2-x1<A.x2-A.x1;
        return y2-y1<A.y2-A.y1;
    }
};
const
    int maxn=500;
int n, res;
data a[maxn];
int f[maxn];
//////

void enter()
{
    scanf("%d\n", &n);
    forn(i, 1, n) scanf("%d%d%d%d\n", &a[i].x1, &a[i].y1, &a[i].x2, &a[i].y2);
    sort(a+1, a+n+1);
}
//////

bool in(int x, int L, int R)
{
    return x>=L && x<=R;
}

bool trong(data a, data b)
{
    return in(a.x1, b.x1, b.x2) && in(a.x2, b.x1, b.x2)
    && in(a.y1, b.y1, b.y2) && in(a.y2, b.y1, b.y2);
}

void process()
{
    res=0;
    forn(i, 1, n)
    {
        f[i]=1;
        forn(j, 1, i-1)
            if (trong(a[j], a[i])) f[i]=max(f[i], f[j]+1);
        res=max(res, f[i]);
    }
    cout << res;
}

int main()
{
    freopen("hcn.inp", "r", stdin);
    freopen("hcn.out", "w", stdout);
    enter();
    process();
}
