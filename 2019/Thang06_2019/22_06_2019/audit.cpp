#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

typedef pair<int, int> pii;
const
    int maxn=1e5+100;
int n, T;
int a[maxn], b[maxn];
set<pii> Q;
long long res, sum;
//////

void enter()
{
    scanf("%d%d\n", &n, &T);
    res=0; sum=0;
    forn(i, 1, n)
    {
        scanf("%d%d\n", &a[i], &b[i]);
        res+=a[i];
        sum+=b[i];
        if (b[i]>0) Q.insert({a[i]/b[i], i});
    }
}
//////

void process()
{
    cout << res << '\n';
    forn(t, 1, T)
    {
        while (!Q.empty() && t>(*Q.begin()).first)
        {
            int pos=(*Q.begin()).second;
            res-=a[pos]%b[pos];
            sum-=b[pos];
            Q.erase(Q.begin());
        }
        res-=sum;
        cout << res << '\n';
    }
}
//////

int main()
{
    freopen("audit.inp", "r", stdin);
    freopen("audit.out", "w", stdout);
    enter();
    process();
}
