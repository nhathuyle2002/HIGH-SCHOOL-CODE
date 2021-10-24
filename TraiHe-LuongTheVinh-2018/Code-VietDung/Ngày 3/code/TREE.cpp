#include <iostream>
#include <stdio.h>
#include <algorithm>
#define For(i,a,b) for(int i=a; i<=b; i++)
#define gt first
#define vt second

using namespace std;
const int N = 100100;
typedef pair<int, int> data;
int m[N], n, sl;
data a[N];

void nhap()
{
    freopen("TREE.INP","r",stdin);
    freopen("TREE.OUT","w",stdout);
    scanf("%d", &n);
    For(i,1,n)
    {
        scanf("%d", &a[i].gt);
        a[i].vt = i;
    }
}
void xuly()
{
    For(i,1,n)
        if (a[i].gt == 1)
        {
            m[++sl] = a[i].vt;
            a[i] = a[n]; n--; i--;
        }
    sort(a+1, a+1+n);
    For(u,1,n)
    {
        For(i,1,a[u].gt-1)
        {
            printf("%d %d\n", a[u].vt, m[sl]);
            sl--;
        }
        m[++sl] = a[u].vt;
    }
    if (sl > 1) printf("%d %d\n", m[1], m[2]);
}

int main()
{
    nhap();
    xuly();
    return 0;
}
