#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define repn(i,a,b) for(int i=(a); i<(b); i++)
using namespace std;
//////

const
    int maxn=1e6+100, maxg=1e5+100;
int n, m;
int a[maxn], nt[maxg];
long long d[maxg];
bool d2[maxg];
//////

void init_prime()
{
    repn(i, 2, maxg)
        if (nt[i]==0)
        {
            nt[i]=i;
            forn(j, i, (maxg-1)/i) nt[i*j]=i;
        }
}
//////

void enter()
{
    scanf("%d\n", &n);
    repn(x, 1, maxg) d2[x]=true;
    forn(i, 1, n)
    {
        scanf("%d", &a[i]);
        int x=a[i];
        while (x>1)
        {
            if (d2[nt[x]]) d[nt[x]]++;
            d2[nt[x]]=false;
            x/=nt[x];
        }
        x=a[i];
        while (x>1)
        {
            d2[nt[x]]=true;
            x/=nt[x];
        }
    }
}
//////

void process()
{
    repn(x, 1, maxg) d[x]+=d[x-1];
    scanf("%d\n", &m);
    forn(i, 1, m)
    {
        int l, r;
        scanf("%d%d\n", &l, &r);
        r=min(r, maxg-1);
        cout << d[r]-d[l-1] << '\n';
    }
}
//////

int main()
{
    freopen("prime.inp", "r", stdin);
    freopen("prime.out", "w", stdout);
    init_prime();
    enter();
    process();
}
