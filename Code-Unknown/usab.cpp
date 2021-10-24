#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

typedef pair<int, int> pii;
const
    int maxn=110, oo=1e9;
int n, n2, L, R;
pii a[maxn];
vector<int> a1, a2;
//////

void enter()
{
    scanf("%d\n", &n);
    forn(i, 1, n) scanf("%d%d\n", &a[i].first, &a[i].second);
    n2=min(15, n/2);
}
//////

void dequy(int i, int R, int s)
{
    if (i>R)
    {
        a2.push_back(s);
        return;
    }
    forn(j, 0, a[i].second)
    {
        dequy(i+1, R, s);
        if (oo/a[i].first>=s) s*=a[i].first; else break;
    }
}

void init()
{
    a2.clear(); dequy(1, n2, 1);
    a1=a2;
    a2.clear(); dequy(n2+1, n, 1);
    sort(a1.begin(), a1.end());
    sort(a2.begin(), a2.end());
}
//////

long long calc(int S)
{
    long long rr=0;
    int j=a2.size()-1;
    forn(i, 0, a1.size()-1)
    {
        while (j>=0 && S/a1[i]<a2[j]) --j;
        rr+=j+1;
    }
    return rr;
}
//////

int main()
{
    freopen("usab.inp", "r", stdin);
    freopen("usab.out", "w", stdout);
    enter();
    init();
    forn(t, 1, 3)
    {
        scanf("%d%d\n", &L, &R);
        cout << calc(R) -calc(L-1) << '\n';
    }
}


/*#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=110;
int n, A, B;
int p[maxn], k[maxn];
int res;
//////

void enter()
{
    scanf("%d\n", &n);
    forn(i, 1, n) scanf("%d%d\n", &p[i], &k[i]);
}
//////

void dequy(int i, int s)
{
    if (i>n)
    {
        if (s>=A) res++;
        return;
    }
    if (s<=B) dequy(i+1, s);
    forn(j, 1, k[i])
        if (B/p[i]>=s)
        {
            s=s*p[i];
            dequy(i+1, s);
        } else break;
}

void process()
{
    forn(t, 1, 3)
    {
        scanf("%d%d\n", &A, &B);
        res=0;
        dequy(1, 1);
        cout << res << '\n';
    }
}
//////

int main()
{
    freopen("usab.inp", "r", stdin);
    freopen("usab.out", "w", stdout);
    enter();
    process();
}*/
