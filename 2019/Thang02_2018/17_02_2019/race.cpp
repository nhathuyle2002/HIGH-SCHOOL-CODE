#include <iostream>
#include <stdio.h>
#include <algorithm>
#include <vector>

#define fi first
#define se second

using namespace std;
/////////

typedef pair<int, int> pii;
const
    int maxn=1e5+100;
int n;
pii a[maxn], b[maxn];
int match[maxn];
vector<int> q;
/////////

void enter()
{
    scanf("%d", &n);
    for (int i=1; i<=n; i++)
    {
        scanf("%d", &a[i].fi);
        a[i].se=i;
    }
    for (int i=1; i<=n; i++)
    {
        scanf("%d", &b[i].fi);
        b[i].se=i;
    }
}
//////////

void process()
{
    sort(a+1, a+1+n);
    sort(b+1, b+1+n);
    q.clear();
    int j=1;
    for (int i=1; i<=n; i++)
    {
        while (j<=n && b[j].fi<a[i].fi)
        {
            q.push_back(j);
            j++;
        }
        if (!q.empty())
        {
            match[a[i].se]=b[q.back()].se;
            a[i].fi=-1;
            b[q.back()].fi=-1;
            q.pop_back();
        }
    }
    q.clear();
    j=1;
    for (int i=1; i<=n; i++)
    if (a[i].fi!=-1)
    {
        while (j<=n && b[j].fi<=a[i].fi)
        {
            if (b[j].fi!=-1) q.push_back(j);
            j++;
        }
        if (!q.empty())
        {
            match[a[i].se]=b[q.back()].se;
            a[i].fi=-1;
            b[q.back()].fi=-1;
            q.pop_back();
        }
    }
    q.clear();
    for (j=1; j<=n; j++)
        if (b[j].fi!=-1) q.push_back(j);
    for (int i=1; i<=n; i++)
        if (a[i].fi!=-1)
        {
            match[a[i].se]=b[q.back()].se;
            q.pop_back();
        }
    for (int i=1; i<=n; i++)
        cout << i << ' ' << match[i] << '\n';
}

int main()
{
    freopen("race.inp", "r", stdin);
    freopen("race.out", "w", stdout);
    enter();
    process();
}
