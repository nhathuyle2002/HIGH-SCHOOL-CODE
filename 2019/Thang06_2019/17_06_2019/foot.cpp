#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=1e5+100;
int n, k;
int a[maxn], bf_pos[maxn];
long long res;
deque<int> Q;
//////

void enter()
{
    scanf("%d%d\n", &n, &k);
    forn(i, 1, n) scanf("%d", &a[i]);
}
//////

void process()
{
    Q.clear();
    forn(i, 1, n)
    {
        while (!Q.empty() && Q.front()<=i-k) Q.pop_front();
        while (!Q.empty() && a[i]<=a[Q.back()]) Q.pop_back();
        Q.push_back(i);
        bf_pos[i]=Q.front();
    }

    res=0;
    int i=n;
    while (i>0)
    {
        int pos=bf_pos[i];
        res+=2LL*a[pos]*(i-pos+1);
        i=pos-1;
    }
    cout << res;
}
//////

int main()
{
    freopen("foot.inp", "r", stdin);
    freopen("foot.out", "w", stdout);
    enter();
    process();
}
