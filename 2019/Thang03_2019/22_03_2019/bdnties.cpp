#include <bits/stdc++.h>
#define forn(i,a,b) for (int i=(a); i<=(b); i++)
#define repn(i,a,b) for (int i=(a); i<(b); i++)
using namespace std;
//////

const
    int maxn=5e4+100;
int n, m;
int a[maxn];
long long res;
priority_queue<int, vector<int>, greater<int> > heap;

int main()
{
    freopen("bdnties.inp", "r", stdin);
    freopen("bdnties.out", "w", stdout);
    //cout << RAND_MAX << '\n';
    while (true)
    {
        scanf("%d%d\n", &n, &m);
        if (n==0 && m==0) break;
        forn(i, 1, n) scanf("%d", &a[i]);
        sort(a+1, a+n+1);

        while (!heap.empty()) heap.pop();
        forn(i, 1, m) heap.push(0);

        res=0;
        forn(i, 1, n)
        {
            int p=heap.top(); heap.pop();
            p+=a[i]; res+=p;
            heap.push(p);
        }
        cout << res << '\n'; scanf("\n");
    }
}
