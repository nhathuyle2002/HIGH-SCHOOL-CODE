#include <iostream>
#include <stdio.h>
#include <stack>

using namespace std;
///////////

const
    int maxn=2e5+100;

int n;
int a[maxn], res[maxn];
stack<int> q;
///////////

void enter()
{
    scanf("%d", &n);
    for (int i=1; i<=n; i++) scanf("%d", &a[i]);
}
////////////

void process()
{
    int j=1;
    for (int i=1; i<=2*n; i++)
    {
        if (q.empty() || q.top()>i)
        {
            res[i]=1;
            q.push(i+a[j]+1);
            //cout << i+a[j]+1 << '\n';
            j++;
        } else
        if (q.top()==i)
        {
            res[i]=0;
            q.pop();
        }
        //cout << q.size() << '\n';
    }
}

int main()
{
    freopen("brackets.inp", "r", stdin);
    freopen("brackets.out", "w", stdout);
    enter();
    process();
    for (int i=1; i<=2*n; i++)
        if (res[i]==1) cout << '(';
        else cout << ')';
}
