#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=1e6+100;
int n, k;
pair<long long, int> a[maxn];
//////

void enter()
{
    scanf("%d%d\n", &n, &k);
    long long sum=0;
    a[0]={0, 0}; //make_pair(0, 0);
    forn(i, 1, n)
    {
        int x;
        scanf("%d", &x);
        sum+=x-k;
        a[i]={sum, i}; //make_pair(sum, i);
    }
}
//////

void process()
{
    sort(a, a+n+1);
    int res=0, pos_min=n+1;

    forn(i, 0, n)
    {
        int pos=a[i].second;
        if (pos-pos_min==92) cout << pos << '\n';
        res=max(res, pos-pos_min);
        pos_min=min(pos_min, pos);
    }

    cout << res;
}
//////

int main()
{
    freopen("aver.inp", "r", stdin);
    freopen("aver.out", "w", stdout);
    enter();
    process();
}
