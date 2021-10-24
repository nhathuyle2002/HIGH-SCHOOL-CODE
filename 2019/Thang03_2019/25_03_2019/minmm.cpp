#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define repn(i,a,b) for(int i=(a); i<(b); i++)
using namespace std;
//////

const
    int maxn=1e6+100;
int n, k, res;
int a[maxn], h[maxn];
deque<int> q;
//////

void enter()
{
    scanf("%d%d\n", &n, &k);
    forn(i, 1, n) scanf("%d", &a[i]);
    sort(a+1, a+n+1);
    forn(i, 2, n) h[i]=a[i]-a[i-1];
}
//////

void process()
{
    res=1e9;
    q.clear();
    forn(i, 2, n)
    {
        while (!q.empty() && h[i]<=h[q.back()]) q.pop_back();
        q.push_back(i);
        if (i>=n-k)
        {
            while (!q.empty() && q.front()<=i-n+k+1) q.pop_front();
             res=min(res, a[i]-a[i-n+k+1]+h[q.front()]);
        }
    }
    cout << res;
}

int main()
{
    freopen("minmm.inp", "r", stdin);
    freopen("minmm.out", "w", stdout);
    enter();
    process();
}
