#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=1e5+100;
int n, k, s;
long double v1, v2;
long long x[maxn];
int a[maxn], sum;
priority_queue<int> Q;
//////

void enter()
{
    scanf("%d%d\n", &n, &k);
    cin >> v1 >> v2;//scanf("%lf%lf\n", &v1, &v2);
    scanf("%d\n", &s);
    forn(i, 1, n) scanf("%lld%d\n", &x[i], &a[i]);
}
//////

void process()
{
    if (s==0)
    {
        cout << setprecision(6) << fixed << 0;
        return;
    }
    else
    if (v2<=v1)
    {
        cout << "inf";
        return;
    }
    sum=0;
    x[n+1]=1e17;
    forn(i, 1, n+1)
    {
        if (i-1>0) Q.push(a[i-1]);
        long double xr=(v1*v2*sum+v2*s)/(v2-v1);
        while (xr<=x[i] && k>0 && !Q.empty())
        {
            sum+=Q.top();
            Q.pop(); k--;
            xr=(v1*v2*sum+v2*s)/(v2-v1);
        }
        if (xr<=x[i])
        {
            cout << setprecision(6) << fixed << xr/v2+sum;
            return;
        }
    }
}
//////

int main()
{
    freopen("chase.inp", "r", stdin);
    freopen("chase.out", "w", stdout);
    enter();
    process();
}
