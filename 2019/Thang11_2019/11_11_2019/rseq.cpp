#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

const
    int maxn=1e5+100;
int n, T;
int a[maxn], t[maxn], d[maxn];
int root[maxn], high[maxn];
long long sum[maxn], res, ans[maxn];
//////

void fastscan(int &number)
{
    number=0;
    register char c=getchar();
    while (c!='-' && (c<48 || c>57)) c=getchar();
    bool negative=false;
    if (c=='-') negative=true, c=getchar();
    for(; c>47 && c<58; c=getchar())
        number=number*10+c-48;
    if (negative) number=-number;
}

void enter()
{
    fastscan(n); fastscan(T);
    forn(i, 1, n) fastscan(a[i]);
    forn(i, 1, T) fastscan(t[i]), d[t[i]]=1;
}
//////

int find_root(int p)
{
    if (root[p]==p) return p;
    return root[p]=find_root(root[p]);
}

long long union_(int x, int y)
{
    int x0=find_root(x), y0=find_root(y);
    if (x0==y0) return sum[x0];
    if (high[y0]>high[x0]) swap(x0, y0);
    if (high[x0]==high[y0]) high[x0]++;
    sum[x0]+=sum[y0];
    root[x]=x0; root[y]=x0; root[y0]=x0;
    return sum[x0];
}

void process()
{
    forn(i, 1, n)
        if (d[i]==0)
        {
            root[i]=i; sum[i]=a[i];
            res=max(res, sum[i]);
            if (i>1 && d[i-1]==0) res=max(res, union_(i, i-1));
        }
    ford(i, T, 1)
    {
        ans[i]=res;
        root[t[i]]=t[i]; sum[t[i]]=a[t[i]];
        d[t[i]]=0;
        res=max(res, sum[t[i]]);
        if (t[i]>1 && d[t[i]-1]==0) res=max(res, union_(t[i], t[i]-1));
        if (t[i]<n && d[t[i]+1]==0) res=max(res, union_(t[i], t[i]+1));
    }
    forn(i, 1, T) cout << ans[i] << '\n';
}
//////

int main()
{
    freopen("rseq.inp", "r", stdin);
    freopen("rseq.out", "w", stdout);
    enter();
    process();
}
