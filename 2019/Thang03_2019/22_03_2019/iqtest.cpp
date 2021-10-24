#include <bits/stdc++.h>
#define forn(i,a,b) for (int i=(a); i<=(b); i++)
#define repn(i,a,b) for (int i=(a); i<(b); i++)
using namespace std;
//////

const
    int maxn=310;
int n, m;
int a0[maxn], b0[maxn], c0[maxn];
//////

int gcd(int a, int b)
{
    if (b==0) return a;
    return gcd(b, a % b);
}

void enter()
{
    scanf("%d%d\n", &n, &m);
    int q[7];
    forn(i, 1, n)
    {
        forn(j, 0, 6) scanf("%d", &q[j]);
        scanf("\n");
        int a=q[1]-q[4], b=q[2]-q[5], c=q[3]-q[6];

        int d=gcd(gcd(abs(a), abs(b)),abs(c));
        if (d!=0)
        {
            a/=d; b/=d; c/=d;
        }

        if (q[0]==1)
        {
            a0[i]=-a; b0[i]=-b; c0[i]=-c;
        } else
        {
            a0[i]=a; b0[i]=b; c0[i]=c;
        }
    }
}
//////

void process()
{
    int a, b, c, d, e, f;
    forn(t, 1, m)
    {
        scanf("%d%d%d%d%d%d\n", &a, &b, &c, &d, &e, &f);
        a-=d; b-=e; c-=f;

        bool ok1=false;
        forn(i, 0, n)
        {
            d=a0[i]; e=b0[i]; f=c0[i];
            if (a>=d && b>=e && c>=f && (a>d || b>e || c>f)) ok1=true;
        }

        bool ok2=false;
        a=-a; b=-b; c=-c;
        forn(i, 0, n)
        {
            d=-a0[i]; e=-b0[i]; f=-c0[i];
            if (a>=d && b>=e && c>=f && (a>d || b>e || c>f)) ok2=true;
        }

        if (ok1 && ok2) cout << 2; else
        if (ok1) cout << 0; else
        if (ok2) cout << 1; else
        cout << 2;
        cout << ' ';
    }
}
//////

int main()
{
    freopen("iqtest.inp", "r", stdin);
    freopen("iqtest.out", "w", stdout);
    enter();
    process();
}
