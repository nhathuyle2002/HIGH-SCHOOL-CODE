#include <bits/stdc++.h>
#define forn(i, a, b) for (int i=(a); i<=(b); ++i)
#define ford(i, a, b) for (int i=(a); i>=(b); --i)
using namespace std;
//////

struct data
{
    int a, b, c;
};
const
    int maxn=2e3+10;
int n, nd;
data p[maxn];
data d[maxn*maxn], e[maxn*maxn];
long long res, res2;
//////

int GCD(int a, int b)
{
    if (b==0) return a;
    return GCD(b, a % b);
}

bool comp(data x, data y)
{
    if (x.a!=y.a) return x.a<y.a;
    if (x.b!=y.b) return x.b<y.b;
    return x.c<y.c;
}

void enter()
{
    scanf("%d\n", &n);
    forn(i, 1, n) scanf("%d%d\n", &p[i].a, &p[i].b);
    nd=0;
    forn(i, 1, n)
        forn(j, i+1, n)
        {
            ++nd;
            int a=p[j].b-p[i].b, b=p[i].a-p[j].a;
            int gcd=GCD(a, b);
            a/=gcd; b/=gcd;
            if (a<0 || (a==0 && b<0))
            {
                a=-a; b=-b;
            }
            d[nd].a=a; d[nd].b=b;
            d[nd].c=-a*p[i].b-b*p[i].a;

            e[nd].a=p[i].a+p[j].a;
            e[nd].b=p[i].b+p[j].b;
            e[nd].c=(p[i].a-p[j].a)*(p[i].a-p[j].a)+(p[i].b-p[j].b)*(p[i].b-p[j].b);
        }
    sort(d+1, d+nd+1, comp);
    sort(e+1, e+nd+1, comp);
}
//////

void process()
{
    d[0].a=-1;
    res=0;
    int cou, cou2;
    forn(i, 1, nd)
    {
        if (d[i].a!=d[i-1].a || d[i].b!=d[i-1].b || d[i].c!=d[i-1].c)
        {
            cou+=cou2;
            cou2=0;
        }
        if (d[i].a!=d[i-1].a || d[i].b!=d[i-1].b) cou=0;
        res+=cou;
        cou2++;
    }

    res2=0;
    forn(i, 1, nd)
    {
        if (e[i].a!=e[i-1].a || e[i].b!=e[i-1].b || e[i].c!=e[i-1].c) cou=0;
        res2+=cou;
        cou++;
    }

    cout << res-res2;
}
//////

int main()
{
    freopen("trapezium.inp", "r", stdin);
    freopen("trapezium.out", "w", stdout);
    enter();
    process();
}
