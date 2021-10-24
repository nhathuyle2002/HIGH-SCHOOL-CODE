#include <iostream>
#include <stdio.h>
#include <vector>

using namespace std;
//////

const
    int maxn=2e5+100;
int T, n, cou;
int a[maxn], res[maxn];
int bit[maxn];
//////

void update(int i, int x)
{
    if (i>n) return;
    bit[i]+=x;
    update(i+(i&(-i)), x);
}

int query(int i)
{
    if (i<1) return 0;
    return bit[i]+query(i-(i&(-i)));
}

int main()
{
    freopen("porder.inp", "r", stdin);
    freopen("porder.out", "w", stdout);
    scanf("%d\n", &T);
    while (T--)
    {
        scanf("%d\n", &n);
        for (int i=1; i<=n; i++) scanf("%d", &a[i]);

        for (int i=1; i<=n; i++) bit[i]=0;
        for (int i=1; i<=n; i++) update(i, 1);

        for (int i=n; i>=1; i--)
        {
            int l=1, r=n+1, mid;
            while (l<r)
            {
                mid=(l+r)>>1;
                if (i-query(mid)>a[i]) l=mid+1; else r=mid;
            }
            res[i]=l;
            update(res[i], -1);
        }

        for (int i=1; i<=n; i++) cout << res[i] << ' ';
        cout << '\n'; scanf("\n");
    }
}
