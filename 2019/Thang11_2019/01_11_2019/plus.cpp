#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

pair<long long, int> x, y;
int top;
pair<int, int> ans[1000000];
//////

void enter()
{
    cin >> x.first; x.second=1;
    cin >> y.first; y.second=2;
}
//////

void write(int &p1, int &p2)
{
    if (p1==1) cout << 'A'; else cout << 'B';
    cout << "+=";
    if (p2==1) cout << 'A'; else cout << 'B';
    cout << '\n';
}

void process()
{
    top=0;
    int cou=0;
    while (x.first%2==0)
    {
        x.first/=2;
        ++cou;
    }
    while (y.first%2==0)
    {
        y.first/=2;
        --cou;
    }
    if (cou>0)
    {
        while (cou--) ans[++top]={2, 2};
    } else
    if (cou<0)
    {
        while (cou++) ans[++top]={1, 1};
    }

    while (x.first!=y.first)
    {
        if (x.first<y.first) swap(x, y);
        x.first+=y.first; ans[++top]={x.second, y.second};
        while (x.first%2==0)
        {
            x.first/=2;
            ans[++top]={y.second, y.second};
        }
    }
    cout << top << '\n';
    forn(i, 1, top)
        write(ans[i].first, ans[i].second);
}
//////

int main()
{
    freopen("plus.inp", "r", stdin);
    freopen("plus.out", "w", stdout);
    enter();
    process();
}
