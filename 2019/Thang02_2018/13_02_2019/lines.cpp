#include <iostream>
#include <stdio.h>
#include <vector>
#include <algorithm>

using namespace std;

const
    int maxn=1e5+100;

int n;
int match[maxn], a[maxn];
int bit[maxn], trace[maxn], f[maxn];
int pr;

void enter()
{
    scanf("%d", &n);
    int pos[maxn];
    for (int i=1; i<=n; i++)
    {
        scanf("%d", &a[i]);
        pos[a[i]]=i;
    }
    for (int i=1; i<=n; i++)
    {
        int x;
        scanf("%d", &x);
        match[pos[x]]=i;
    }
}

int quece(int i)
{
    if (i==0) return 0;
    int pos=quece(i-(i & (-i)));
    if (f[bit[i]]>f[pos]) return bit[i]; else return pos;
}

void update(int i, int pos)
{
    if (i>n) return;
    if (f[bit[i]]<f[pos])
    {
        bit[i]=pos;
        update(i+(i & (-i)), pos);
    }
}

void process()
{
    for (int i=0; i<=n; i++)
    {
        bit[i]=0;
        trace[i]=0;
    }
    pr=0;
    for (int i=1; i<=n; i++)
    {
        int pos=quece(match[i]-1);
        trace[i]=pos;
        f[i]=f[pos]+1;
        update(match[i], i);
        if (f[i]>f[pr]) pr=i;
    }
}

void print()
{
    vector<int> q;
    q.clear();
    while (pr!=0)
    {
        q.push_back(a[pr]);
        pr=trace[pr];
    }
    sort(q.begin(), q.end());
    cout << q.size() << '\n';
    for (int i=0; i<q.size(); i++)
        cout << q[i] << '\n';
}

int main()
{
    freopen("lines.inp", "r", stdin);
    freopen("lines.out", "w", stdout);
    enter();
    process();
    print();
}
