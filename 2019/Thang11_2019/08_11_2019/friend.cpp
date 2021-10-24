#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

const
    int maxn=1e5+100;
int n, W;
long long res;
map<int, int> MP;
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
    fastscan(n); fastscan(W);
    res=0;
    forn(i, 1, n)
    {
        int x; fastscan(x);
        auto it=MP.find(W-x);
        if (it!=MP.end()) res+=it->second;
        ++MP[x];
    }
    cout << res;
}
//////

void process()
{

}
//////

int main()
{
    freopen("friend.inp", "r", stdin);
    freopen("friend.out", "w", stdout);
    enter();
    process();
}
