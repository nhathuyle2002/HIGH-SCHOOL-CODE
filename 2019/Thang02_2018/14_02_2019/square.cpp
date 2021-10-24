#include <iostream>
#include <stdio.h>
#include <stack>
#include <string.h>

using namespace std;
///////////

const
    int maxn=1e3+100;

int m, n;
char a[maxn][maxn];
int h[maxn];
stack<int> q;
int l[maxn], r[maxn];
int res;
///////////

void enter()
{
    scanf("%d%d", &m, &n);
    for (int i=1; i<=m; i++)
            scanf("%s", a[i]+1);
}
//////////

void process()
{
    res=0;
    for (int j=1; j<=n; j++) h[j]=0;
    for (int i=1; i<=m; i++)
    {
        for (int j=1; j<=n; j++)
            if (a[i][j]=='*') h[j]++; else h[j]=0;

        while (!q.empty()) q.pop();
        h[0]=-1; q.push(0);

        for (int j=1; j<=n; j++)
        {
            while (h[j]<=h[q.top()]) q.pop();
            l[j]=q.top();
            q.push(j);
        }

        while (!q.empty()) q.pop();
        h[n+1]=-1; q.push(n+1);

        for (int j=n; j>=1; j--)
        {
            while (h[j]<=h[q.top()]) q.pop();
            r[j]=q.top();
            q.push(j);
        }

        for (int j=1; j<=n; j++)
            res=max(res, min(h[j], r[j]-l[j]-1));
    }
}


int main()
{
    freopen("square.inp", "r", stdin);
    freopen("square.out", "w", stdout);
    enter();
    process();
    cout << res;
}
