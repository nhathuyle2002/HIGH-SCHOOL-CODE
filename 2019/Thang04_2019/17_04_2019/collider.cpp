#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=2e5+100;
int n, m;
stack<int> Q;
int cou, t[maxn];
//////

void enter()
{
    scanf("%d\n", &n);
    cou=0;
    forn(i, 1, n)
    {
        int x, e;
        scanf("%d%d\n", &x, &e);
        if (e==1) Q.push(x); else
        if (!Q.empty())
        {
            cou++;
            t[cou]=(x-Q.top()+1)/2;
            Q.pop();
        }
    }
    sort(t+1, t+cou+1);
}
//////

void process()
{
    scanf("%d\n", &m);
    int j=1;
    forn(i, 1, m)
    {
        int x;
        scanf("%d", &x);
        while (j<=cou && t[j]<=x) j++;
        cout << n-2*(j-1) << '\n';
    }
}
//////

int main()
{
    freopen("collider.inp", "r", stdin);
    freopen("collider.out", "w", stdout);
    enter();
    process();
}
