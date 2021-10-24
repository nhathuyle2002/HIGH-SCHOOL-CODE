#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define F first
#define S second
using namespace std;
//////

const
    int maxn=1e5+100;
int T, n, m, k;
int a[maxn];
bool choose[maxn];
//////

void enter()
{
    scanf("%d%d%d\n", &n, &m, &k);
    forn(i, 1, n) scanf("%d", &a[i]);
    scanf("\n");
}
//////

bool check(int sl)
{
    forn(i, 1, sl) choose[i]=false;

    int cou=0;
    ford(i, n, 1)
    {
        if (a[i]>sl || choose[a[i]]) continue;
        if (a[i]>sl-cou-k)
        {
            choose[a[i]]=true;
            cou++;
        }
    }
    if (cou==sl) return true; else return false;
}

void process()
{
    int L=0, R=m+1, mid;
    while (L<R)
    {
        mid=(L+R)/2;
        if (check(mid)) L=mid+1; else R=mid;
    }
    cout << L-1 << '\n';
}
//////

int main()
{
    freopen("cards.inp", "r", stdin);
    freopen("cards.out", "w", stdout);
    scanf("%d\n", &T);
    while (T--)
    {
        enter();
        process();
    }
}
