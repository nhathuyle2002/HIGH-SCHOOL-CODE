#include <iostream>
#include <stdio.h>
#include <algorithm>
#include <vector>
#include <string.h>
#define forn(i, a, b) for(int i=a; i<=b; i++)

struct data
{
    long long h, w;
};

struct data3
{
    long long f, c;
    data3 ();
    data3 (long long v, long long s):f(v), c(s){}
};

struct data2
{
    long long h, f, c;
};

struct big
{
    int d[100];
    int l;
};

const int maxn=1005;
const long long maxf=2e18, mo=1e8;

using namespace std;

data a[maxn];
data2 b[maxn];
int n, m;
vector <data3> l;

big kq;

void them(big &a, int b)
{
    a.l++;
    a.d[a.l] = b;
}

void enter()
{
    scanf("%d%d", &n, &m);
    forn (i, 1, n) scanf("%I64d%I64d", &a[i].h, &a[i].w);
    forn (i, 1, m) scanf("%I64d%I64d%I64d", &b[i].h, &b[i].f, &b[i].c);
}

bool ss(data a, data b)
{
    return a.h > b.h;
}

bool ss2(data2 a, data2 b)
{
    return a.h > b.h;
}

void stb(char *a, big &b)
{
    b.l = 0;
    long long s= 0, m=1, c=0, le=strlen(a);
    for (int i=le-1; i>=0; i--)
    {
        s = s+(int)((a[i])-48)*m;
        m = m*10;
        c++;
        if (c == 9)
        {
            them (b, s % mo);
            s = s / mo;
            m = 10; c=1;
        }
    }
    if (s>0) them(b, s);
}

void sosx(long long t, char *a)
{
    int le =20;
    while (t>0)
    {
        a[le] = (char) (t % 10 + 48);
        t= t/10;
        le--;
    }

    forn (i, 0, 20)
    {
        a[i] = a[i+le+1];
        if (a[i] < '0' || a[i] > '9')
        {
            a[i] = '\0';
            break;
        }
    }
}

big cong(big &a, big &b)
{
    while (a.l < b.l) them(a, 0);
    while (b.l < a.l) them(b, 0);

    big c;
    long long nho = 0, sum;
    c.l=0;

    forn (i, 1, a.l)
    {
        sum = a.d[i] + b.d[i] + nho;
        them(c, sum % mo);
        nho = sum / mo;
    }
    if (nho > 1) them(c, 1);
    return c;
}

void xuat(big &a)
{
    char oo[maxn];
    int le;
    cout <<  a.d[a.l];
    for (int i=a.l-1; i>0; i--)
    {
        sosx(a.d[i], oo);
        le = strlen(oo); while (le < 8)
        {
            cout << '0'; le++;
        }
        cout << oo;
    }
}

void solve()
{
    sort(a+1, a+1+n, ss);
    sort(b+1, b+1+m, ss2);

    int j=1, le, vt;
    long long t, t1, t2;
    big ll;
    char oo[maxn];

    forn (i, 1, n)
    {
        while (j<=n && b[j].h>=a[i].h)
        {
            l.emplace_back(b[j].f, b[j].c);
            j++;
        }

        t = maxf;
        le= l.size();
        forn (j, 0, le-1)
        {
            t1 = l[j].f + l[j].c*a[i].w;
            if (t1 < t)
            {
                t= t1;
                vt = j;
            }
        }

        if (l[vt].f != 0)
        {
            t2 = l[vt].c;
            swap(l[vt], l.back()); l.pop_back();
            l.emplace_back(0, t2);
        }

        sosx(t, oo);
        stb(oo, ll);
        kq = cong(kq, ll);
    }

    xuat (kq);
}

int main()
{
    freopen("bsf.inp", "r", stdin);
    freopen("bsf.out", "w", stdout);

    enter();
    solve();
}
