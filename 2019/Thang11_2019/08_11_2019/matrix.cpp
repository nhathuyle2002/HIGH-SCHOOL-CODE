#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

typedef pair<int, int> pii;
const
    int maxn=1e3+100;
int n;
int a[maxn], b[maxn];
set<pii, greater<pii> > Q;
vector<int> d;
int ans[maxn][maxn];
//////

void fastscan(int &number)
{
    number=0;
    register char c=getchar();
    while (c!='-' && (c<48 || c>57)) c=getchar();
    bool negative=false;
    if (c=='-') negative=true, c=getchar();
    for(; c>47 && c<58; c=getchar())
        number=number*10+c-48;
    if (negative) number=-number;
}

void enter()
{
    fastscan(n);
    forn(i, 1, n) fastscan(a[i]);
    forn(j, 1, n) fastscan(b[j]);
}
//////

void process()
{
    Q.clear();
    forn(i, 1, n)
        if (a[i]>0) Q.insert({a[i], i});
    while (!Q.empty())
    {
        int i=Q.begin()->second; Q.erase(Q.begin());
        d.clear();
        while (a[i]--)
        {
            if (Q.empty())
            {
                cout << "NO";
                exit(0);
            }
            int i2=Q.begin()->second; Q.erase(Q.begin());
            a[i2]--;
            d.push_back(i2);
            if (i2<i) ans[i2][i]=1; else ans[i][i2]=1;
        }
        for(int i2 : d)
            if (a[i2]>0) Q.insert({a[i2], i2});
    }

    forn(i, 1, n)
        if (b[i]>0) Q.insert({b[i], i});
    while (!Q.empty())
    {
        int i=Q.begin()->second; Q.erase(Q.begin());
        d.clear();
        while (b[i]--)
        {
            if (Q.empty())
            {
                cout << "NO";
                exit(0);
            }
            int i2=Q.begin()->second; Q.erase(Q.begin());
            b[i2]--;
            d.push_back(i2);
            if (i2<i) ans[i][i2]=1; else ans[i2][i]=1;
        }
        for(int i2 : d)
            if (b[i2]>0) Q.insert({b[i2], i2});
    }

    cout << "YES" << '\n';
    forn(i, 1, n)
    {
        forn(j, 1, n) cout << ans[i][j] << ' ';
        cout << '\n';
    }
}
//////

int main()
{
    freopen("matrix.inp", "r", stdin);
    freopen("matrix.out", "w", stdout);
    enter();
    process();
}
