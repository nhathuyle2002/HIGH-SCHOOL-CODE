#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=210;
int ns, n, m, degs;
long long M;
long long p26[maxn];
int a[maxn];
//////

void prepare()
{
    p26[0]=1;
    forn(i, 1, 200)
    {
        if (p26[i-1]==-1) p26[i]=-1; else p26[i]=p26[i-1]*26;
        if (p26[i-1]>1e13) p26[i]=-1;
    }
}
//////

void enter()
{
    ns=n;
    while (degs>0)
    {
        n=(n+1)/2;
        degs--;
    }

    if (n==1) m=0; else m=(n+1)/2;
}
//////

void process()
{
    forn(i, 1, n) a[i]=0;

    forn(i, 1, m)
        if (p26[n-i]==-1) a[i]=1; else
            forn(x, 1, 27)
                if (p26[n-i]-p26[m-i]<M) M-=p26[n-i]-p26[m-i]; else
                {
                    a[i]=x;
                    break;
                }

    bool choose=false;

    forn(i, m+1, n)
        if (p26[n-i]==-1) a[i]=1; else
        {
            if (!choose) M++;
            forn(x, 1, 27)
                if (p26[n-i]<M) M-=p26[n-i]; else
                {
                    a[i]=x;
                    break;
                }
            if (!choose)
            {
                if (a[i]>a[n-i+1])
                {
                    choose=true;
                    continue;
                }
                if (a[i]<=a[n-i+1])
                {
                    if (a[i]<a[n-i+1]) choose=true;
                    if (M>1) M--; else
                    {
                        M+=p26[n-i]-1;
                        a[i]--;
                    }
                }
            }
        }
}
//////

int query(int i, int nn)
{
    if (nn<=n) return a[i];
    if (i<=(nn+1)/2) query(i, (nn+1)/2);
    else query(nn-i+1, (nn+1)/2);
}

void print()
{
    forn(i, 1, ns) cout << char(query(i, ns)+'a'-1);
    cout << '\n';
}
//////

int main()
{
    freopen("palin.inp", "r", stdin);
    freopen("palin.out", "w", stdout);

    prepare();
    while (scanf("%d%d%lld\n", &n, &degs, &M)!=EOF)
    {
        enter();
        process();
        print();
    }
}
