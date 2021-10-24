#include <iostream>
#include <stdio.h>
#define For(i,a,b) for(int i=a; i<=b; i++)

using namespace std;
const int N = 1010;
int a[N], vt[N], zero[N], n, tests;
struct data{int x,y;}chan[N], le[N];

void open()
{
    freopen("TEST.INP","r",stdin);
    freopen("TEST.OUT","w",stdout);
    scanf("%d", &tests);
}
void nhap()
{
    scanf("%d", &n);
    For(i,1,n)
    {
        scanf("%d", &a[i]); vt[i] = i;
    }
}
void tach(int l, int r)
{
    int s0 = 0, s1 = 0, s2 = 0;
    bool truoc = false, sau = false;
    For(i,l,r)
        if (a[i] == 0) zero[++s0] = vt[i];
        else if (a[i] % 2 == 0) chan[++s1] = {a[i]/2, vt[i]};
        else le[++s2] = {a[i]/2, vt[i]};
    For(i,1,s0) vt[l+i-1] = zero[i];
    For(i,1,s1)
    {
        a[l+s0+i-1] = chan[i].x;
        vt[l+s0+i-1] = chan[i].y;
        if (chan[i].x > 0) truoc = true;
    }
    For(i,1,s2)
    {
        a[l+s0+s1+i-1] = le[i].x;
        vt[l+s0+s1+i-1] = le[i].y;
        if (le[i].x > 0) sau = true;
    }
    if (truoc && s1 > 0) tach(l+s0, l+s0+s1-1);
    if (sau && s2 > 0) tach(l+s0+s1, r);
}

int main()
{
    open();
    while (tests--)
    {
        nhap();
        tach(1, n);
        For(i,1,n) printf("%d ", vt[i]);
        printf("\n");
    }
    return 0;
}
