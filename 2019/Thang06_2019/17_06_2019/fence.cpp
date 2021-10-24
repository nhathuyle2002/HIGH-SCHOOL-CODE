#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=1e6+100;
int n, k;
int a[maxn], gmin[maxn], f[maxn];
deque<int> Q;
int cres;
long long res;
//////

void enter()
{
    scanf("%d%d\n", &n, &k);
    forn(i, 1, n) scanf("%d", &a[i]);
}
//////

void process()
{
    f[0]=0;
    Q.clear();
    forn(i, 1, n)
    {
        while (!Q.empty() && Q.front()<=i-k) Q.pop_front();
        while (!Q.empty() && a[i]<=a[Q.back()]) Q.pop_back();
        Q.push_back(i);
        gmin[i]=a[Q.front()];
    }

    Q.clear();
    ford(i, n, 1)
    {
        while (!Q.empty() && Q.front()>=i+k) Q.pop_front();
        while (!Q.empty() && gmin[i]>=gmin[Q.back()]) Q.pop_back();
        if (i>=k) Q.push_back(i);
        f[i]=gmin[Q.front()];
    }

    res=0; cres=0;
    int cou=0;
    forn(i, 1, n)
    {
        res+=a[i]-f[i];
        if (cou==k || f[i]!=f[i-1])
        {
            cou=0;
            cres++;
        }
        cou++;
    }

    cout << res << '\n' << cres;
}
//////

int main()
{
    freopen("fence.inp", "r", stdin);
    freopen("fence.out", "w", stdout);
    enter();
    process();
}
