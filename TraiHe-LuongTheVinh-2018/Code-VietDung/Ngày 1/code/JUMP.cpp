#include <iostream>
#include <stdio.h>
#define For(i,a,b) for(int i=a; i<=b; i++)

using namespace std;
const int N = 1000010;
int n, k, m, kq, n_prime, r;
int nt[80000], pos_it[80000], sl[80000], dd[N+100], vt[N+100], it[4*80000], kt[80000], d[80000];
int s[N][105];

void nhap()
{
    freopen("JUMP.INP","r",stdin);
    freopen("JUMP.OUT","w",stdout);
    scanf("%d%d%d", &n, &k, &m);
}

void snt()
{
    For(i,2,N)
        if (!dd[i])
        {
            long long j = 1LL*i*i;
            while (j <= N)
            {
                dd[j] = i;
                j+= i;
            }
        }
    For(i,2,N)
        if (!dd[i])
        {
            dd[i] = i;
            nt[++n_prime] = i;
            vt[i] = n_prime;
        }
}
void build(int k, int l, int r)
{
    if (l == r)
    {
        pos_it[l] = k; return;
    }
    int mid = (r+l) >> 1;
    build(k*2, l, mid);
    build(k*2+1, mid+1, r);
}
int lt(int a, int b)
{
    if (b == 0) return 1;
    int t = lt(a, b/2);
    t = 1LL*t*t % m;
    if (b % 2 == 1) t = 1LL*t*a % m;
    return t;
}
void update(int i)
{
    it[pos_it[i]] = lt(nt[i], sl[i]);
    i = pos_it[i];
    while (i > 1)
    {
        i/= 2;
        it[i] = 1LL*it[i*2]*it[i*2 + 1] % m;
    }
}
void ptich(int a, int v)
{
    while (a > 1)
    {
        int p = dd[a], dem = 0;
        while (a % p == 0)
        {
            dem++;
            a/= p;
        }
        if (kt[vt[p]] == 0)
        {
            d[++r] = vt[p]; kt[vt[p]] = 1;
        }
        sl[vt[p]]+= v*dem;
    }
}
void xuly()
{
    For(i,1,n_prime) update(i);
    For(a,0,k)
    {
        int b = k-a;
        ptich(a, -1);
        if (b < k) ptich(b+1, 1);
        if ((a-b) % n == 0)
        {
            For(i,1,r)
            {
                update(d[i]); kt[d[i]] = 0;
            }
            r = 0;
            kq = (kq + it[1]) % m;
        }
    }
}
void dp()
{
    s[0][0] = 1;
    For(i,1,k)
    For(j,0,n-1)
    {
        s[i][j] = (s[i-1][(j-1+n)%n] + s[i-1][(j+1)%n]) % m;
    }
    kq = s[k][0];
}

int main()
{
    nhap();
    if (n > 100)
    {
        snt();
        build(1,1,n_prime);
        xuly();
    } else dp();
    printf("%d", kq);
    return 0;
}
