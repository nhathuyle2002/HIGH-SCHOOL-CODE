#include <iostream>
#include <stdio.h>
#include <queue>
#include <algorithm>

#define data pair<int, int>

using namespace std;

const
    int maxn=50010;


int m,n,k;
int a[maxn], b[maxn];

struct cmp
{
    bool operator()(data x, data y)
    {
        return a[x.first]+b[x.second]>a[y.first]+b[y.second];
    }
};

priority_queue<data, vector<data>, cmp> q;

void enter()
{
    scanf("%d%d%d", &m, &n, &k);
    for (int i=1; i<=m; i++) scanf("%d", &a[i]);
    for (int i=1; i<=n; i++) scanf("%d", &b[i]);
    sort(a+1,a+m+1);
    sort(b+1,b+n+1);
}

void process()
{
    for (int i=1; i<=m; i++) q.push(make_pair(i,1));
    for (int i=1; i<=k; i++)
    {
        data p=q.top();
        q.pop();
        cout << a[p.first]+b[p.second] << '\n';
        if (p.second+1<=n) q.push(make_pair(p.first, p.second+1));
    }
}

int main()
{
    //freopen("kmin.inp", "r", stdin);
    //freopen("kmin.out", "w", stdout);
    enter();
    process();
    return 0;
}
