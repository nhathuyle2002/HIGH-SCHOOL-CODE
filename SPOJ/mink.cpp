#include <iostream>
#include <stdio.h>
#include <deque>

using namespace std;

const
    int maxn=200010;

int t,n,k;
int a[maxn];
deque<int> q;

void enter()
{
    scanf("%d%d", &n, &k);
    for (int i=1; i<=n; i++) scanf("%d", &a[i]);
}

void process()
{
    q.clear();
    for (int i=1; i<k; i++)
    {
        while ((!q.empty()) && (a[i]<=a[q.back()])) q.pop_back();
        q.push_back(i);
    }
    for (int i=k; i<=n; i++)
    {
        while ((!q.empty()) && (q.front()<=i-k)) q.pop_front();
        while ((!q.empty()) && (a[i]<=a[q.back()])) q.pop_back();
        q.push_back(i);
        cout << a[q.front()] << ' ';
    }
    cout << '\n';
}

int main()
{
    //freopen("mink.inp", "r", stdin);
    //freopen("mink.out", "w", stdout);
    scanf("%d", &t);
    for (int i=1; i<=t; i++)
    {
        enter();
        process();
    }
    return 0;
}
