#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define X first
#define Y second
using namespace std;
//////

typedef pair<long long, long long> pLL;
const
    int maxn=1e5+100;
int n;
pLL a[maxn];
int top, Q[maxn];
long double f[maxn];
//////

void enter()
{
    scanf("%d\n", &n);
    forn(i, 1, n) scanf("%lld%lld\n", &a[i].X, &a[i].Y);
}
//////

long long area(pLL a, pLL b, pLL c)
{
    long long sum=(b.X-a.X)*(b.Y+a.Y)+(c.X-b.X)*(c.Y+b.Y)+(a.X-c.X)*(a.Y+c.Y);
    if (sum>0) return 1; else
    if (sum==0) return 0; else
    return -1;
}

long double _distance(pLL a, pLL b)
{
    return sqrt((a.X-b.X)*(a.X-b.X)+(a.Y-b.Y)*(a.Y-b.Y));
}

void process()
{
    top=1; Q[1]=1; f[1]=0;
    forn(i, 2, n)
    {
        f[i]=1e15;
        while (top>=2 && area(a[Q[top-1]], a[Q[top]], a[i])<=0)
        {
            f[i]=min(f[i], max(f[Q[top]], _distance(a[Q[top]], a[i])));
            top--;
        }
        f[i]=min(f[i], max(f[Q[top]], _distance(a[Q[top]], a[i])));
        Q[++top]=i;
    }
    cout << setprecision(10) << fixed << f[n];
}
//////

int main()
{
    freopen("swoop.inp", "r", stdin);
    freopen("swoop.out", "w", stdout);
    enter();
    process();
}
