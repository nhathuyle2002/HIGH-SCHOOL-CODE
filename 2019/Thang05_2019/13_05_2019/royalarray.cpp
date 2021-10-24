#include <bits/stdc++.h>
#define forn(i, a, b) for (int i=(a); i<=(b); ++i)
#define ford(i, a, b) for (int i=(a); i>=(b); --i)
using namespace std;
//////

struct data
{
    int L, R;
    long long w, w1, w2, sum;
};
struct data4
{
    long long w, w1, w2, sum;
};

const
    int maxn=2e5+100;
const
    long long oo=1e15;
int n, q;
int a[maxn], leaf[maxn];
data it[4*maxn];
int qr[maxn][3];
long long res[maxn];
//////

void enter()
{
    scanf("%d%d\n", &n, &q);
    forn(i, 1, n) scanf("%d", &a[i]);
    forn(i, 1, q)
        scanf("%d%d%d\n", &qr[i][0], &qr[i][1], &qr[i][2]);
}
//////

void build(int id, int L, int R)
{
    it[id].L=L; it[id].R=R;
    it[id].w=-oo; it[id].w1=-oo; it[id].w2=-oo; it[id].sum=-oo;

    if (L==R) leaf[L]=id; else
    {
        int mid=(L+R)/2;
        build(id*2, L, mid);
        build(id*2+1, mid+1, R);
    }
}
//////

void update(int i, int x)
{
    int id=leaf[i];
    it[id].w=x; it[id].w1=x; it[id].w2=x; it[id].sum=x;
    id/=2;
    while (id>0)
    {
        it[id].sum=it[id*2].sum+it[id*2+1].sum;
        it[id].w1=max(it[id*2].w1, it[id*2].sum+it[id*2+1].w1);
        it[id].w2=max(it[id*2+1].w2, it[id*2].w2+it[id*2+1].sum);
        it[id].w=max(max(it[id*2].w, it[id*2+1].w), it[id*2].w2+it[id*2+1].w1);
        id/=2;
    }
}
//////

data4 query(int id, int dd, int cc)
{
    int L=it[id].L, R=it[id].R;
    if (cc<L || dd>R) return {-oo, -oo, -oo, 0};
    if (dd<=L && R<=cc) return {it[id].w, it[id].w1, it[id].w2, it[id].sum};
    data4 q1=query(id*2, dd, cc);
    data4 q2=query(id*2+1, dd, cc);
    data4 rr;
    rr.sum=q1.sum+q2.sum;
    rr.w1=max(q1.w1, q1.sum+q2.w1);
    rr.w2=max(q2.w2, q1.w2+q2.sum);
    rr.w=max(max(q1.w, q2.w), q1.w2+q2.w1);
    return rr;
}
//////

void process()
{
    build(1, 1, n);
    forn(i, 1, n)
        if (i % 2==0) update(i, a[i]); else update(i, -a[i]);
    forn(i, 1, q)
        if (qr[i][0]==1)
        {
            if (qr[i][1] % 2==0) update(qr[i][1], qr[i][2]);
            else update(qr[i][1], -qr[i][2]);
        } else
        {
            data4 p=query(1, qr[i][1], qr[i][2]);
            res[i]=p.w;
        }

    build(1, 1, n);
    forn(i, 1, n)
        if (i % 2==1) update(i, a[i]); else update(i, -a[i]);
    forn(i, 1, q)
        if (qr[i][0]==1)
        {
            if (qr[i][1] % 2==1) update(qr[i][1], qr[i][2]);
            else update(qr[i][1], -qr[i][2]);
        } else
        {
            data4 p=query(1, qr[i][1], qr[i][2]);
            res[i]=max(res[i], p.w);
        }

    forn(i, 1, q)
        if (qr[i][0]==2) cout << res[i] << '\n';
}
//////

int main()
{
    freopen("royalarray.inp", "r", stdin);
    freopen("royalarray.out", "w", stdout);
    enter();
    process();
}
