#include <bits/stdc++.h>
#define forn(i,a,b) for (int i=(a); i<=(b); i++)
#define repn(i,a,b) for (int i=(a); i<(b); i++)

using namespace std;
//////

const
    long long max_x=1e18;
const
    int mu2=60, mu3=38, mu5=26;
long long a2[mu2], a3[mu3], a5[mu5];

int cou;
long long a[mu2*mu3*mu5];
//////

void init()
{
    a2[0]=1;
    repn(i, 1, mu2) a2[i]=a2[i-1]*2;
    a3[0]=1;
    repn(i, 1, mu3) a3[i]=a3[i-1]*3;
    a5[0]=1;
    repn(i, 1, mu5) a5[i]=a5[i-1]*5;

    cou=0;
    repn(i2, 0, mu2)
        repn(i3, 0, mu3)
        if (max_x/a3[i3]>=a2[i2])
            repn(i5, 0, mu5)
                if (max_x/a3[i3]/a2[i2]>=a5[i5]) a[cou++]=a2[i2]*a3[i3]*a5[i5];
    sort(a, a+cou);
}
//////

void process()
{
    int T;
    scanf("%d\n", &T);
    while (T--)
    {
        long long x;
        scanf("%lld\n", &x);
        int pos=upper_bound(a, a+cou, x)-a;
        if (a[pos-1]!=x) cout << "Not in sequence";
        else cout << pos;
        cout << '\n';
    }
}
//////

int main()
{
    freopen("hamming.inp", "r", stdin);
    freopen("hamming.out", "w", stdout);
    init();
    process();
}
