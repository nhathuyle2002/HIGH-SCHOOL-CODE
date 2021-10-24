#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

typedef pair<int, int> pii;
const
    int maxn=510;
int n, m, H;
int a[maxn], b[maxn], last_pos[maxn];
int d[maxn][maxn];
set<pii, greater<pii> > Q;
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
    fastscan(n); fastscan(m); fastscan(H);
    forn(i, 1, n) fastscan(a[i]);
    forn(j, 1, m) fastscan(b[j]);

    forn(j, 1, m)
    {
        if (b[j]*H>n)
        {
            cout << "NO";
            exit(0);
        }
        forn(i, 1, b[j]*H)
            d[i][j]=1;
        last_pos[j]=b[j]*H;
    }
}
//////

void process()
{
    ford(i, n, 1)
    {
        int cou=0;
        Q.clear();
        forn(j, 1, m)
            if (d[i][j]==0 && last_pos[j]>0) Q.insert({last_pos[j], j}); else
            if (d[i][j]<0) ++cou; else
            if (d[i][j]==1)
            {
                ++cou;
                ford(i2, last_pos[j], last_pos[j]-H+1) d[i2][j]=-1;
                d[i][j]=-2; d[i-H+1][j]=-2;
                last_pos[j]=last_pos[j]-H;
            }
        a[i]=m-a[i];
        if (cou>a[i] || a[i]-cou>Q.size())
        {
            cout << "NO";
            exit(0);
        }
        a[i]-=cou;
        while (a[i]--)
        {
            int j=Q.begin()->second; Q.erase(Q.begin());
            ford(i2, last_pos[j], last_pos[j]-H+1) d[i2][j]=0;
            last_pos[j]=last_pos[j]-H;
            ford(i2, i, i-H+1) d[i2][j]=-1;
            d[i][j]=-2; d[i-H+1][j]=-2;
        }
    }
    cout << "YES" << '\n';
    forn(i, 1, n)
    {
        forn(j, 1, m)
            if (d[i][j]==0) cout << '*'; else
            if (d[i][j]==-1) cout << '|'; else
            cout << '+';
        cout << '\n';
    }
}
//////

int main()
{
    freopen("chip.inp", "r", stdin);
    freopen("chip.out", "w", stdout);
    enter();
    process();
}
