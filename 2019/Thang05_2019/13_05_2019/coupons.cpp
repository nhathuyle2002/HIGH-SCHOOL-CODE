#include <bits/stdc++.h>
#define forn(i, a, b) for (int i=(a); i<=(b); ++i)
#define ford(i, a, b) for (int i=(a); i>=(b); --i)
using namespace std;
//////

typedef pair<int, int> pii;
const
    int maxn=1e5+100;
int n, k;
long long m;
int a[maxn], b[maxn], c[maxn];
set<pii> Qa, Qb, Qc;
bool d[maxn];
//////

void enter()
{
    scanf("%d%d%lld", &n, &k, &m);
    forn(i, 1, n)
    {
        scanf("%d%d\n", &a[i], &b[i]);
        c[i]=a[i]-b[i];
    }
}
//////

void process()
{
    Qa.clear(); Qb.cbegin(); Qc.clear();
    forn(i, 1, n)
    {
        d[i]=false;
        Qa.insert({a[i], i});
        Qb.insert({b[i], i});
    }

    forn(i, 1, k)
    {
        if (Qb.empty()) break;
        int pos=Qb.begin()->second; Qb.erase(Qb.begin());
        m-=b[pos];
        if (m<0) break;
        d[pos]=true;
        Qc.insert({c[pos], pos});
    }

    do
    {
        while (!Qa.empty() && d[Qa.begin()->second]) Qa.erase(Qa.begin());
        while (!Qb.empty() && d[Qb.begin()->second]) Qb.erase(Qb.begin());
        if (Qb.empty()) break;
        if (!Qc.empty() && Qb.begin()->first+Qc.begin()->first<Qa.begin()->first)
        {
            int pos=Qb.begin()->second;
            m-=b[pos]+Qc.begin()->first;
            if (m<0) break;
            d[pos]=true;
            Qc.erase(Qc.begin());
            Qb.erase(Qb.begin());
            Qc.insert({c[pos], pos});
        }
        else
        {
            int pos=Qa.begin()->second;
            Qa.erase(Qa.begin());
            m-=a[pos];
            if (m<0) break;
            d[pos]=true;
        }
    }
    while (true);
}
//////

int main()
{
    freopen("coupons.inp", "r", stdin);
    freopen("coupons.out", "w", stdout);
    enter();
    process();
    int res=0;
    forn(i, 1, n)
        if (d[i]) res++;
    cout << res;
}
