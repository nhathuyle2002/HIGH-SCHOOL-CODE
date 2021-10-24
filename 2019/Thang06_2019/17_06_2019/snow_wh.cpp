#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

typedef pair<int, int> pii;
const
    int maxn=2e5+100;
struct data
{
    int L, R, pos_min, pos_max;
};

int n, m;
int a[maxn], leaf[maxn];
data IT[4*maxn];
//////

void build(int i, int L, int R)
{
    IT[i].L=L; IT[i].R=R;
    if (L==R) leaf[L]=i;
    else
    {
        int mid=(L+R)/2;
        build(i*2, L, mid);
        build(i*2+1, mid+1, R);
    }
}

void enter()
{
    scanf("%d%d\n", &n, &m);
    forn(i, 1, n) scanf("%d", &a[i]);
    build(1, 1, n);
}
//////

void update(int i, int pos)
{
    i=leaf[i];
    IT[i].pos_max=pos;
    IT[i].pos_min=pos;
    i/=2;
    while (i>0)
    {
        IT[i].pos_max=max(IT[i*2].pos_max, IT[i*2+1].pos_max);
        IT[i].pos_min=min(IT[i*2].pos_min, IT[i*2+1].pos_min);
        i/=2;
    }
}

pii query(int i, int dd, int cc)
{
    int L=IT[i].L, R=IT[i].R;
    if (cc<L || R<dd) return {0, n+1};
    if (dd<=L && R<=cc) return {IT[i].pos_max, IT[i].pos_min};
    pii rr1=query(i*2, dd, cc), rr2=query(i*2+1, dd, cc);
    return {max(rr1.first, rr2.first), min(rr1.second, rr2.second)};
}

void process()
{
    forn(i, 1, n) update(a[i], i);
    while (m--)
    {
        int typ, p1, p2;
        scanf("%d%d%d\n", &typ, &p1, &p2);
        if (typ==1)
        {
            update(a[p1], p2);
            update(a[p2], p1);
            swap(a[p1], a[p2]);
        } else
        {
            pii p=query(1, p1, p2);
            if (p.first-p.second==p2-p1) cout << "YES"; else cout << "NO";
            cout << '\n';
        }
    }
}
//////

int main()
{
    freopen("snow_wh.inp", "r", stdin);
    freopen("snow_wh.out", "w", stdout);
    enter();
    process();
}
