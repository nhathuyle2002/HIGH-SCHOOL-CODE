#include <iostream>
#include <queue>
#include <stdio.h>

using namespace std;

const
    int maxquece=15000;

priority_queue<int> q;
int cou;
int a[maxquece+100];

int main()
{
    //freopen("qbheap.inp", "r", stdin);
    //freopen("qbheap.out", "w", stdout);
    char tt;
    int x;
    while (scanf("%c", &tt)!=EOF)
    {
        if (tt=='-' && !q.empty())
        {
            x=q.top();
            while (!q.empty() && q.top()==x) q.pop();
        }
        else
        if (tt=='+' && q.size()<maxquece)
        {
            scanf("%d", &x);
            q.push(x);
        }
        scanf("\n");
    }
    cou=0;
    x=int(1e9)+100;
    while (q.size()>0)
    {
            if (q.top()!=x)
            {
                cou++;
                x=q.top();
                a[cou]=x;
            }
            q.pop();
    }
    cout << cou << '\n';
    for (int i=1; i<=cou; i++)
        cout << a[i] << '\n';
    return 0;
}
