#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

struct point
{
    double x, y;
};
const
    int maxn=1e5+100;
int n;
point S, a[maxn];
double res;
//////

void enter()
{
    scanf("%d\n", &n);
    scanf("%lf%lf\n", &S.x, &S.y);
    forn(i, 1, n)
        scanf("%lf%lf\n", &a[i].x, &a[i].y);
    a[n+1]=a[1];
}
//////

double area(point x, point y, point z)
{
    return (y.x-x.x)*(y.y+x.y)+(z.x-y.x)*(z.y+y.y)+(x.x-z.x)*(x.y+z.y);
}

bool namtrong(point x, point y, point p)
{
    if (min(x.x, y.x)>p.x || p.x>max(x.x, y.x)) return false;
    if (min(x.y, y.y)>p.y || p.y>max(x.y, y.y)) return false;
    return true;
}

double distan(point x, point y)
{
    return sqrt((y.x-x.x)*(y.x-x.x)+(y.y-x.y)*(y.y-x.y));
}

void process()
{
    res=1e9;

    forn(i, 1, n)
    {
        if (area(S, a[i], a[i+1])==0)
        {
            if (namtrong(a[i], a[i+1], S)) res=0; else
            res=min(res, min(distan(S, a[i]), distan(S, a[i+1])));
        }
        double x1=a[i].x, y1=a[i].y, x2=a[i+1].x, y2=a[i+1].y, x0=S.x, y0=S.y;
        double t=-1.0*((x2-x1)*(x1-x0)+(y2-y1)*(y1-y0))/((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1));
        double x=x1+(x2-x1)*t, y=y1+(y2-y1)*t;
        if (namtrong(a[i], a[i+1], {x, y})) res=min(res, distan(S, {x, y})); else
            res=min(res, min(distan(S, a[i]), distan(S, a[i+1])));
    }

    res=trunc(res*10000+0.5)/10000;
    printf("%0.4f", res);
}
//////

int main()
{
    freopen("bill.inp", "r", stdin);
    freopen("bill.out", "w", stdout);
    enter();
    process();
}
