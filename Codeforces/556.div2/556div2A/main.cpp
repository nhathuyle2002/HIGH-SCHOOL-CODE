#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define ford(i,a,b) for(int i=(a); i>=(b); i--)
using namespace std;
//////

const
    int maxn=40;
int n, m, r;
int a[maxn], b[maxn];
//////

void enter()
{
    scanf("%d%d%d\n", &n, &m, &r);
    a[0]=1000; b[0]=0;
    forn(i, 1, n)
    {
        scanf("%d", &a[i]);
        a[0]=min(a[0], a[i]);
    }
    forn(i, 1, m)
    {
        scanf("%d", &b[i]);
        b[0]=max(b[0], b[i]);
    }
    if (a[0]>=b[0]) cout << r; else
    {
        int d=r/a[0];
        cout << d*b[0]+r % a[0];
    }
}
//////

void process()
{

}
//////

int main()
{
    //freopen("main.inp", "r", stdin);
    freopen("main.out", "w", stdout);
    enter();
    process();
}
