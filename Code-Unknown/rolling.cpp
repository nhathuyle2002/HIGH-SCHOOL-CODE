#include <bits/stdc++.h>
#define forn(i, a, b) for (int i=(a); i<=(b); ++i)
#define ford(i, a, b) for (int i=(a); i>=(b); --i)
using namespace std;
//////

int m, n;
int a[7]={0, 1, 2, 3, 4, 5, 6};
long long res;
//////

void enter()
{
    scanf("%d%d\n", &m, &n);
}
//////

void swapngang1()
{
    int rr=a[1];
    a[1]=a[3]; a[3]=a[6]; a[6]=a[4]; a[4]=rr;
}

void swapngang2()
{
    int rr=a[1];
    a[1]=a[4]; a[4]=a[6]; a[6]=a[3]; a[3]=rr;
}

void swapdoc()
{
    int rr=a[1];
    a[1]=a[2]; a[2]=a[6]; a[6]=a[5]; a[5]=rr;
}

void process()
{
    res=0;
    int du=(n-1) % 4, thg=(n-1)/4;
    forn(dir, 1, m)
    {
        res+=a[6]+thg*14;
        forn(i, 1, du)
        {
            if (dir % 2==1) swapngang1(); else swapngang2();
            res+=a[6];
        }
        swapdoc();
    }
    cout << res;
}
//////

int main()
{
    freopen("rolling.inp", "r", stdin);
    freopen("rolling.out", "w", stdout);
    enter();
    process();
}
