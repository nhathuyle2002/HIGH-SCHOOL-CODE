#include <iostream>
#include <stdio.h>
#define For(i,a,b) for(int i=a; i<=b; i++)

using namespace std;
struct matrix
{
    long long d[2][2];
    long long *operator[](int i) {return d[i];}
};
matrix t, ans, f1;
int r, p, q;
long long k, m;

int gcd(int a, int b)
{
    while (b)
    {
        int r = a%b; a = b; b = r;
    }
    return a;
}
void open()
{
    freopen("FUNC.INP","r",stdin);
    freopen("FUNC.OUT","w",stdout);
}
long long tich(long long a, long long b)
{
    long long ans = 0;
    while (a)
    {
        ans = (ans + b*(a%10)) % m;
        a/= 10;
        b = b*10 % m;
    }
    return ans;
}
matrix operator *(matrix a, matrix b)
{
    matrix c;
    For(i,0,1)
    For(j,0,1)
    {
        c[i][j] = 0;
        For(k,0,1)
            c[i][j] = (c[i][j] + tich(a[i][k],b[k][j])) % m;
    }
    return c;
}
matrix calc(long long k)
{
    if (k == 1) return t;
    matrix tinh = calc(k/2);
    tinh = tinh*tinh;
    if (k % 2 == 1) tinh = tinh*t;
    return tinh;
}
void xuly()
{
    t[0][0] = 0; t[0][1] = 1;
    t[1][0] = 1; t[1][1] = r;
    ans[0][0] = p; ans[1][0] = q;
    if (k > 1) ans = calc(k-1)*ans;
    printf("%lld %lld\n", ans[0][0], ans[1][0]);
}
void run()
{
    for(;;)
    {
        r = 0;
        scanf("%lld%d%d%d%lld\n", &k, &r, &p, &q, &m);
        int t = gcd(p, q);
        p/= t; q/= t;
        //ptich(sr, r);
        //ptich(sp, p);
        //ptich(sq, q);
        if (r == 0) return;
        xuly();
    }
}

int main()
{
    open();
    run();
    return 0;
}
