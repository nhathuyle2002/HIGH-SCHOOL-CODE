#include <iostream>
#include <stdio.h>
#include <deque>

using namespace std;
///////

const
    int maxn=3e6+100;
int n, T, res;
long long a[maxn];
deque<int> q1, q2;
///////

void enter()
{
    scanf("%d%d\n", &n, &T);
    for (int i=1; i<=n; i++) scanf("%lld", &a[i]);
}
///////

void Push(int i)
{
    while (!q1.empty() && a[q1.back()]<=a[i]) q1.pop_back();
    q1.push_back(i);
    while (!q2.empty() && a[q2.back()]>=a[i]) q2.pop_back();
    q2.push_back(i);
}

void Pop(int i)
{
    while (!q1.empty() && q1.front()<=i) q1.pop_front();
    while (!q2.empty() && q2.front()<=i) q2.pop_front();
}

void process()
{
    q1.clear(); q2.clear();
    res=0; int j=1;

    for (int i=1; i<=n; i++)
    {
        Push(i);
        while (j<i && a[q1.front()]-a[q2.front()]>T)
        {
            Pop(j); j++;
        }
        res=max(res, i-j+1);
    }
    cout << res;
}
///////

int main()
{
    freopen("fgarden.inp", "r", stdin);
    freopen("fgarden.out", "w", stdout);
    enter();
    process();
}
