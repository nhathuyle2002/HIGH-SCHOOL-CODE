#include <iostream>
#include <stdio.h>
#include <vector>

using namespace std;
////////

const
    int maxn=22;
int m, n, maxbit;
int a[maxn][maxn];
int d[maxn];
vector<int> row, col;
vector<int> rr, rc;
////////

void enter()
{
    scanf("%d%d", &m, &n);
    for (int i=1; i<=m ;i++)
        for (int j=1; j<=n; j++)
            scanf("%d", &a[i][j]);
    maxbit=(1 << m)-1;
}
////////

int getb(int i, int x)
{
    return (x >> (i-1)) and 1;
}

void process()
{
    rr.clear(); rc.clear();

    for (int x=1; x<=maxbit; x++)
    {
        row.clear();
        for (int i=1; i<=m; i++)
            if (getb(i, x)==1) row.push_back(i);
        if (row.size()<=rr.size()) continue;

        for (int j=1; j<=n; j++) d[j]=0;
        for (int i=0; i<row.size(); i++)
        {
            int ii=row[i];
            for (int j=1; j<=n; j++) d[j]+=a[ii][j];
        }

        int j=0;
        col.clear();
        for (int i=0; i<row.size(); i++)
        {
            int ii=row[i];
            j++;
            while (j<=n && (d[j]!=1 || a[ii][j]==0)) j++;
            if (j==n+1) break;
            col.push_back(j);
        }
        if (j==n+1) continue;
        rr=row; rc=col;
    }
}
////////

void dequy(int i0)
{
    if (row.size()>rr.size())
    {
        rr=row;
        rc=col;
    }
    for (int i=i0+1; i<=m; i++)
    {
        row.push_back(i);
        for (int j=1; j<=n; j++) d[j]+=a[i][j];

        int j=0;
        col.clear();
        for (int i=0; i<row.size(); i++)
        {
            int ii=row[i];
            j++;
            while (j<=n && (d[j]!=1 || a[ii][j]==0)) j++;
            if (j==n+1) break;
            col.push_back(j);
        }
        if (j<n+1) dequy(i);

        row.pop_back();
        for (int j=1; j<=n; j++) d[j]-=a[i][j];
    }
}
////////

void process2()
{
    for (int i=1; i<=n; i++) d[i]=0;
    row.clear(); col.clear();
    rr.clear(); rc.clear();
    dequy(0);
}
////////

void cvt(vector<int> v)
{
    for (int i=0; i<v.size(); i++) cout << v[i] << ' ';
    cout << '\n';
}

void print()
{
    cout << rr.size() << '\n';
    for (int i=1; i<=m; i++) d[i]=0;
    for (int i=0; i<rr.size(); i++) d[rr[i]]=1;
    for (int i=1; i<=m; i++)
        if (d[i]==0) cout << i << ' ';
    cout << '\n';
    for (int j=1; j<=n; j++) d[j]=0;
    for (int j=0; j<rc.size(); j++) d[rc[j]]=1;
    for (int j=1; j<=n; j++)
        if (d[j]==0) cout << j << ' ';
    cout << '\n';
}
////////

int main()
{
    freopen("matrix.inp", "r", stdin);
    freopen("matrix.out", "w", stdout);
    enter();
    //process();
    //print();
    process2();
    print();
}
