#include <bits/stdc++.h>
#define forn(i, a, b) for (int i=(a); i<=(b); ++i)
#define ford(i, a, b) for (int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=5e3+100, oo=1e7;
int n, L, R;
int f[maxn], trace[maxn];
char s[maxn];
vector<int> OP;
//////

void enter()
{
    scanf("%d%d%d\n", &n, &L, &R);
    forn(i, 1, n) scanf("%c", &s[i]);
}
//////

void process()
{
    f[0]=0;
    forn(i, 1, n)
    {
        f[i]=-oo;
        char g1='z', g2='a';
        ford(j, i, max(1, i-L+2))
        {
            g1=min(g1, s[j]);
            g2=max(g2, s[j]);
        }
        ford(j, i-L+1, max(1, i-R+1))
        {
            g1=min(g1, s[j]);
            g2=max(g2, s[j]);
            if (f[i]<f[j-1]+g2-g1)
            {
                f[i]=f[j-1]+g2-g1;
                trace[i]=j-1;
            }
        }
    }
    if (f[n]<0) cout << "NO"; else
    {
        cout << f[n] << '\n';
        int i=n;
        while (i>0)
        {
            OP.push_back(i);
            i=trace[i];
        }
        cout << OP.size() << '\n';
        OP.push_back(0);
        ford(i, OP.size()-2, 0)
        {
            forn(j, OP[i+1]+1, OP[i]) cout << s[j];
            cout << '\n';
        }
    }
}
//////

int main()
{
    freopen("language.inp", "r", stdin);
    freopen("language.out", "w", stdout);
    enter();
    process();
}
