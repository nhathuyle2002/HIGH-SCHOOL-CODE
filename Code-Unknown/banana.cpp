#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define ford(i,a,b) for(int i=(a); i>=(b); i--)

using namespace std;
//////

const
    int maxn=5e3+100;
int n;
long long a[maxn];
int res;
///////

void enter()
{
    scanf("%d\n", &n);
    forn(i, 1, n)
    {
        scanf("%lld", &a[i]);
        a[i]+=a[i-1];
    }
}
///////

void process()
{
    res=0;
    int bf=0; long long sbf=0;
    forn(i, 1, n)
        if (a[i]-a[bf]>=sbf)
        {
            res++;
            sbf=a[i]-a[bf];
            bf=i;
        }
    cout << res;
}
///////

int main()
{
    freopen("banana.inp", "r", stdin);
    freopen("banana.out", "w", stdout);
    enter();
    process();
}
