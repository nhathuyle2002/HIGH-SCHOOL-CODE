#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

typedef pair<int, int> pii;
const
    int maxn=1e5+100;
int n, k;
long long res1, res2;
vector<pii> d;
//////

void enter()
{
    scanf("%d%d\n", &n, &k);
    d.push_back({-1, 0});
    forn(i, 1, n)
    {
        int a, b, c;
        scanf("%d%d%d\n", &a, &b, &c);
        if (k>=a && (k-a) % b==0) d.push_back({(k-a)/b, c});
    }
    sort(d.begin()+1, d.end());
}
//////

void process()
{
    res1=0; res2=0;
    long long sum=0;
    forn(i, 1, d.size()-1)
    {
        res1+=d[i].second;
        if (d[i].first!=d[i-1].first)
        {
            res2=max(res2, sum);
            sum=0;
        }
        sum+=d[i].second;
    }
    res2=max(res2, sum);
    cout << res1 ;//<< ' ' << res2;
}
//////

int main()
{
    freopen("sought.inp", "r", stdin);
    freopen("sought.out", "w", stdout);
    enter();
    process();
}
