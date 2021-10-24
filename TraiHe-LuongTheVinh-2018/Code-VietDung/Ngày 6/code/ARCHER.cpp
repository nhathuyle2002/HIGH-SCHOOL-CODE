#include <iostream>
#include <stdio.h>
#include <algorithm>
#include <stdlib.h>
#define For(i,a,b) for(int i=a; i<=b; i++)
#define mp make_pair
#define x first
#define y second.first
#define z second.second

using namespace std;
const int N = 2010;
typedef pair<int, pair<int, int> > data;
data a[N], s[N];
int n, kq;

void nhap()
{
    freopen("ARCHER.INP","r",stdin);
    freopen("ARCHER.OUT","w",stdout);
    scanf("%d", &n);
    For(i,1,n) scanf("%d%d%d\n", &a[i].x, &a[i].y, &a[i].z);
}
int gcd(int a, int b)
{
    a = abs(a); b = abs(b);
    if (b > a) swap(a, b);
    while (b)
    {
        int r = a%b; a = b; b = r;
    }
    return a;
}
int gcd(int a, int b, int c)
{
    if (a == 0) return gcd(b, c);
    if (b == 0) return gcd(a, c);
    return gcd(gcd(a, b), c);
}
void xuly()
{
    sort(a+1, a+1+n);
    For(i,1,n)
    {
        int r = 0, dem = 0, sl = 0;
        For(j,i,n)
            if (a[i] == a[j]) sl++;
            else if (a[i].z != a[j].z)
            {
                int tx = a[i].x - a[j].x;
                int ty = a[i].y - a[j].y;
                int tz = a[i].z - a[j].z;
                int t = gcd(tx, ty, tz);
                s[++r] = mp(tx/t, mp(ty/t, tz/t));
            }
        sort(s+1, s+1+r);
        kq = max(kq, sl);
        For(i,1,r)
        {
            if (s[i] == s[i-1]) dem++;  else dem = 1;
            kq = max(kq, dem+sl);
        }
    }
}

int main()
{
    nhap();
    xuly();
    printf("%d", kq);
    return 0;
}
