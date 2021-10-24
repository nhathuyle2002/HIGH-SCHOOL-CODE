#include <iostream>
#include <stdio.h>
#include <algorithm>
#include <string.h>

using namespace std;
//////

int n;
int a[20], h[20], b[20];
long long sum;
int d[10], c[10];
long long res1, res2, res3;
//////

void enter()
{
    char s[20];
    scanf("%s\n", s+1);
    n=strlen(s+1);
    for (int i=1; i<=n; i++) a[i]=s[i]-'0';
    for (int i=1; i<=n; i++) scanf("%d", &h[i]);
    sum=0;
    for (int i=1; i<=n; i++) sum=sum*10+a[i];
}
//////

long long process1()
{
    for (int i=1; i<=n; i++)
        if (a[i]==h[i]) return -1;
    return sum;
}
//////

bool ccc(int i)
{
    for (int j=1; j<i; j++)
        if (a[j]==h[j]) return false;
    return true;
}

bool check(int len)
{
    for (int x=1; x<=9; x++)
            if (d[x]+c[x]>len) return 0;
    return 1;
}

int find1(int l, int r, int len, int kk)
{
    for (int x=l; x<=r; x++)
        if (d[x]>0 && d[x]+c[x]==len && x!=kk) return x;
    return -1;
}

int find2(int l, int r, int kk)
{
    for (int x=l; x<=r; x++)
        if (d[x]>0 && x!=kk) return x;
    return -1;
}

int find3(int l, int r, int len, int kk)
{
    for (int x=r; x>=l; x--)
        if (d[x]>0 && d[x]+c[x]==len && x!=kk) return x;
    return -1;
}

int find4(int l, int r, int kk)
{
    for (int x=r; x>=l; x--)
        if (d[x]>0 && x!=kk) return x;
    return -1;
}
//////

long long process2()
{
    long long rr;
    int y;

    for (int i=n-1; i>=1; i--)
    {
        if (!ccc(i)) continue;

        for (int x=1; x<=9; x++)
        {
            d[x]=0; c[x]=0;
        }
        for (int j=i; j<=n; j++)
        {
            d[a[j]]++;
            c[h[j]]++;
        }

        if (!check(n-i+1)) break;
        y=find3(1, a[i]-1, n-i+1, h[i]);
        if (y==-1) y=find4(1, a[i]-1, h[i]);
        if (y==-1) break;
        b[i]=y; d[y]--; c[h[i]]--;

        for (int j=i+1; j<=n; j++)
        {
            y=-1;
            if (!check(n-i+1)) break;
            y=find3(1, 9, n-i+1, h[j]);
            if (y==-1) y=find4(1, 9, h[j]);
            if (y==-1) break;
            b[j]=y; d[y]--; c[h[j]]--;
        }
        if (y==-1) break;

        rr=0;
        for (int j=1; j<i; j++) rr=rr*10+a[j];
        for (int j=i; j<=n; j++) rr=rr*10+b[j];
        return rr;
    }
    return -1;
}
//////

long long process3()
{
    long long rr;
    int y;

    for (int i=n-1; i>=1; i--)
    {
        if (!ccc(i)) continue;

        for (int x=1; x<=9; x++)
        {
            d[x]=0; c[x]=0;
        }
        for (int j=i; j<=n; j++)
        {
            d[a[j]]++;
            c[h[j]]++;
        }

        if (!check(n-i+1)) break;
        y=find1(a[i]+1, 9, n-i+1, h[i]);
        if (y==-1) y=find2(a[i]+1, 9, h[i]);
        if (y==-1) break;
        b[i]=y; d[y]--; c[h[i]]--;

        for (int j=i+1; j<=n; j++)
        {
            y=-1;
            if (!check(n-i+1)) break;
            y=find1(1, 9, n-i+1, h[j]);
            if (y==-1) y=find2(1, 9, h[j]);
            if (y==-1) break;
            b[j]=y; d[y]--; c[h[j]]--;
        }
        if (y==-1) break;

        rr=0;
        for (int j=1; j<i; j++) rr=rr*10+a[j];
        for (int j=i; j<=n; j++) rr=rr*10+b[j];
        return rr;
    }
    return -1;
}
//////

int main()
{
    freopen("password.inp", "r", stdin);
    freopen("password.out", "w", stdout);
    enter();
    res1=process1();
    if (res1!=-1) cout << res1; else
    {
        res2=process2();
        res3=process3();
        if (res1==-1) res1=res2;
        if (res1==-1) res1=res3; else
        {
            if (sum-res1>res3-sum) res1=res3;
        }
        cout << res1;
    }
}
