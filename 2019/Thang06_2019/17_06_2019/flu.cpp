#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=1e5+100;//1e5+100;
int n, posr;
int a[maxn], t[maxn], trace[maxn], bit[maxn+1];
long long f[maxn];
vector<int> op;
//////

void enter()
{
    scanf("%d\n", &n);
    forn(i, 1, n) scanf("%d", &a[i]);
    forn(i, 1, n) scanf("%d", &t[i]);
}
//////

int query(int last)
{
    int pos=0;
    for(int i=last; i>0; i-=i & (-i))
        if (f[bit[i]]>f[pos]) pos=bit[i];
    return pos;
}

void update(int st, int x)
{
    for(int i=st; i<=maxn; i+=i & (-i))
        if (f[bit[i]]<f[x]) bit[i]=x;
}

void process()
{
    f[0]=0; posr=0;
    forn(i, 1, maxn) bit[i]=0;
    forn(i, 1, n)
    {
        int p=query(t[i]-1);
        f[i]=f[p]+a[i]; trace[i]=p;
        update(t[i], i);
        if (f[i]>f[posr]) posr=i;
    }

    cout << f[posr] << '\n';
    op.clear();
    while (posr>0)
    {
        op.push_back(posr);
        posr=trace[posr];
    }
    cout << op.size() << '\n';
    ford(i, op.size()-1, 0) cout << op[i] << ' ';
}
//////

int main()
{
    freopen("flu.inp", "r", stdin);
    freopen("flu.out", "w", stdout);
    enter();
    process();
}
