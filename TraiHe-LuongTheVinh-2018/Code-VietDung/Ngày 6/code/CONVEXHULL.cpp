#include <iostream>
#include <stdio.h>
#include <algorithm>
#define For(i,a,b) for(int i=a; i<=b; i++)
#define sqr(x) (x)*(x)

using namespace std;
const int N = 100100;
struct point{long long x,y;};
int n, d[N], xmin, ymin, r;
long long s;
point a[N];

bool ss(point a, point b) {return a.y*b.x < b.y*a.x || (a.y*b.x == b.y*a.x && sqr(a.x) +sqr(a.y) < sqr(b.x)+sqr(b.y));}
bool check(point a, point b, point c) {return a.x*(b.y-c.y) + b.x*(c.y-a.y) + c.x*(a.y-b.y) > 0;}
void nhap()
{
    freopen("CONVEXHULL.INP","r",stdin);
    freopen("CONVEXHULL.OUT","w",stdout);
    scanf("%d", &n);
    xmin = ymin = 1e9;
    For(i,1,n)
    {
        scanf("%lld%lld\n", &a[i].x, &a[i].y);
        if (a[i].y < ymin || (a[i].y == ymin && a[i].x < xmin))
        {
            xmin = a[i].x;
            ymin = a[i].y;
        }
    }
}
void xuly()
{
    For(i,1,n)
    {
        a[i].x-= xmin, a[i].y-= ymin;
    }
    sort(a+1, a+1+n, ss);

    For(i,1,n)
    {
        while (r > 1 && !check(a[d[r-1]], a[d[r]], a[i])) r--;
        d[++r] = i;
    }
    d[0] = d[r]; d[r+1] = d[1];
    For(i,1,r) s+= 1LL*a[d[i]].x*(a[d[i+1]].y - a[d[i-1]].y);
}

int main()
{
    nhap();
    xuly();
    printf("%d\n", r);
    printf("%lld.%lld\n", s/2, (s&1LL)*5);
    For(i,1,r) printf("%lld %lld\n", a[d[i]].x + xmin, a[d[i]].y + ymin);
    return 0;
}
/*
    a[1] = {0, 0};  a[2] = {2, 1};  a[3] = {1, 2};
    bool t = check(a[1], a[2], a[3]);
*/
