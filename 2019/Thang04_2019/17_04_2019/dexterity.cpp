#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=2e5+100;
int n;
int a[maxn], d[maxn];
//////

void enter()
{
    scanf("%d\n", &n);
    forn(i, 1, n)
    {
        scanf("%d", &a[i]);
        d[a[i]]=0;
    }
}
//////

void process()
{
    forn(i, 1, n)
        if (d[a[i]]==2) continue; else
        {
            int gm=max(a[i], max(a[i+1], a[i+2]));
            if (a[i]==gm) continue; else
            if (a[i+1]==gm)
            {
                d[a[i]]++;
                d[a[i+1]]++;
                swap(a[i], a[i+1]);
            } else
            {
                d[a[i]]++;
                d[a[i+1]]++;
                d[a[i+2]]++;
                swap(a[i+2], a[i+1]);
                swap(a[i+1], a[i]);
            }
        }
    forn(i, 1, n) cout << a[i] << ' ';
}
//////

int main()
{
    freopen("dexterity.inp", "r", stdin);
    freopen("dexterity.out", "w", stdout);
    enter();
    process();
}
