#include <iostream>
#include <stdio.h>
#include <vector>

using namespace std;
//////

const
    int maxn=210, maxg=maxn*maxn;

int n, s;
int a[maxn], d[maxn*2];
bool f[maxn][maxg*2+1];
vector<int> q, ot;
//////

void enter()
{
    scanf("%d%d", &n, &s);
    for (int i=1; i<=n; i++) scanf("%d", &a[i]);
}
//////

void init()
{
    f[0][0+maxg]=1;
    for (int i=1; i<=n; i++)
        for (int j=0; j<=maxg*2; j++)
        {
            if (j-a[i]>=0 && f[i-1][j-a[i]]) f[i][j]=1;
            if (j+a[i]<=maxg*2 && f[i-1][j+a[i]]) f[i][j]=1;
        }
    int i=n, j=s+maxg;
    while (i>0)
    {
        if (j-a[i]>=0 && f[i-1][j-a[i]])
        {
            d[i]=1;
            j=j-a[i];
        } else
        if (j+a[i]<=maxg*2 && f[i-1][j+a[i]])
        {
            d[i]=-1;
            j=j+a[i];
        }
        i--;
    }
    //for (int i=1; i<=n; i++) cout << d[i] << ' ';
}
///////

void process()
{
    ot.clear();
    q.clear();
    d[0]=0;
    for (int i=1; i<=n; i++)
    if (d[i]!=d[i-1]) q.push_back(i);
    if (q.size()==1) return;
    q.push_back(n+1);
    //for (int i=0; i<q.size(); i++) cout << q[i] << ' ';

    for (int i=q.size()-2; i>1; i--)
            for (int j=1; j<=q[i+1]-q[i]; j++) ot.push_back(q[i]-1);
    int dcou=0;
    if (d[1]==1)
    {
        for (int i=1; i<=q[1]-q[0]-1; i++)
        {
            ot.push_back(q[2]-1-dcou);
            dcou++;
        }
        for (int i=1; i<=q[2]-q[1]; i++)
            ot.push_back(1);
    } else
    if (d[1]==-1)
    {
        for (int i=1; i<=q[2]-q[1]-1; i++)
        {
            ot.push_back(q[1]-1);
            dcou++;
        }
        for (int i=1; i<=q[1]-q[0]; i++)
        {
            ot.push_back(q[2]-1-dcou);
            dcou++;
        }
    }
}
///////

int main()
{
    freopen("reduce.inp", "r", stdin);
    freopen("reduce.out", "w", stdout);
    enter();
    init();
    process();
    for (int i=0; i<ot.size(); i++) cout << ot[i]-1 << ' ';
}
