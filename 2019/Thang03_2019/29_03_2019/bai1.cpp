#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define ford(i,a,b) for(int i=(a); i>=(b); i++)
using namespace std;
//////

const
    int maxn=1e5+100;
int n, d[3], c[3];
long long S, T;
long long a[maxn], f[maxn];
//////

void enter()
{
    scanf("%d\n", &n);
    forn(i, 0, 2) scanf("%d", &d[i]);
    forn(i, 0, 2) scanf("%d", &c[i]);
    scanf("%d%d\n", &S, &T);
    forn(i, 2, n) scanf("%d\n", &a[i]);
    S=a[S]; T=a[T];
    sort(a+1, a+n+1);
}
//////

void process()
{
    if (S==T)
    {
        cout << 0;
        return;
    }
    forn(i, 1, n)
        if (a[i]<=S) f[i]==0; else
    {
        f[i]=1e15;
        forn(j, 0, 2)
        {
            int pos=lower_bound(a+1, a+n+1, a[i]-d[j])-a;
            f[i]=min(f[i], f[pos]+c[j]);
        }
        if (a[i]==T)
        {
            cout << f[i];
            return;
        }
    }
}
//////

int main()
{
    freopen("bai1.inp", "r", stdin);
    freopen("bai1.out", "w", stdout);
    enter();
    process();
}
