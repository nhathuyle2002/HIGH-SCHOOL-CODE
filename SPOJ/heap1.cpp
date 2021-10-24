#include <iostream>
#include <queue>
#include <stdio.h>

using namespace std;

int t,n;
long long res;
priority_queue<long long, vector<long long>, greater<long long> > q;

int main()
{
    freopen("heap1.inp", "r", stdin);
    freopen("heap1.out", "w", stdout);
    scanf("%d\n", &t);
    for (int i=1; i<=t; i++)
    {
        while (!q.empty()) q.pop();
        scanf("%d\n", &n);
        for (int i=1; i<=n; i++)
        {
            int x;
            scanf("%d", &x);
            q.push(x);
        }
        scanf("\n");
        res=0;
        while (q.size()>1)
        {
            long long x1=q.top(); q.pop();
            long long x2=q.top(); q.pop();
            res+=x1+x2;
            q.push(x1+x2);
        }
        cout << res << '\n';
    }
    return 0;
}
