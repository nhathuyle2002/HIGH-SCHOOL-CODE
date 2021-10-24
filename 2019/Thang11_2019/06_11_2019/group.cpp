#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

const
    int maxn=1e5+100;
int n, K, R, nTest;
int a[maxn];
long long res, sum;
priority_queue<int, vector<int>, greater<int> > Q;
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
    fastscan(n); fastscan(K); fastscan(R);
    forn(i, 1, n) fastscan(a[i]);
}
//////

void process()
{
    res=0; sum=0;
    while (!Q.empty()) Q.pop();
    forn(i, 1, n)
    {
        if (a[i]<=res) sum+=a[i]; else Q.push(a[i]);
        while (!Q.empty())
        {
            if (sum/Q.top()+Q.size()>=K)
            {
                sum+=Q.top();
                Q.pop();
            }
            else break;
        }
        res=sum/(K-Q.size());
        if (i>R) cout << res << ' ';
    }
    cout << '\n';
}
//////

int main()
{
    freopen("group.in", "r", stdin);
    freopen("group.out", "w", stdout);
    fastscan(nTest);
    while (nTest--)
    {
        enter();
        process();
    }
}
