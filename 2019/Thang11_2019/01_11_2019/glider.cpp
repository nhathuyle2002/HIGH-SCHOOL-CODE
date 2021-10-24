#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

const
    int maxn=3e5+100;
int n, H;
pair<int, int> a[maxn];
int sum[maxn];
long long res;
//////

void fastscan(int &number)
{
    number=0;
    register char c=getchar();
    bool negative=false;
    if (c=='-') negative=true, c=getchar();
    for(; c>47 && c<58; c=getchar())
        number=number*10+c-48;
    if (negative) number=-number;
}

void enter()
{
    scanf("%d%d\n", &n, &H);
    sum[0]=0;
    forn(i, 1, n) fastscan(a[i].first), fastscan(a[i].second), sum[i]=sum[i-1]+a[i].second-a[i].first;
}
//////

void process()
{
    res=0;
    int j=1;
    forn(i, 1, n)
    {
        while (j<=n)
            if (H-(a[j].second-a[i].first)+(sum[j]-sum[i-1])>0) ++j; else break;
        res=max(res, (long long)a[j-1].second-a[i].first+H-(a[j-1].second-a[i].first)+(sum[j-1]-sum[i-1]));
    }
    cout << res;
}
//////

int main()
{
    freopen("glider.inp", "r", stdin);
    freopen("glider.out", "w", stdout);
    enter();
    process();
}
