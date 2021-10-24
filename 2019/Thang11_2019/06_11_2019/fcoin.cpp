#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

const
    int maxn=2e5+100;
int n, m;
int a[maxn], dcou[3];
set<int> Q, Q2;
map<int, int> MP;
//////

void fastscan(int &number)
{
    number=0;
    register char c=getchar();
    for(; c>47 && c<58; c=getchar())
        number=number*10+c-48;
}

void enter()
{
    fastscan(n); fastscan(m);
    Q2.clear();
    int type, n2;
    forn(t, 1, m)
    {
        fastscan(n2);
        forn(i, 1, n2*2) fastscan(a[i]);
        fastscan(type); ++dcou[type];
        if (type==0)
            forn(i, 1, n2*2) Q2.insert(a[i]);
        else
        if (type==1)
        {
            forn(i, n2+1, n2*2) ++MP[a[i]];
            forn(i, 1, n2) Q2.insert(a[i]);
        }
        else
        if (type==2)
        {
            forn(i, 1, n2) ++MP[a[i]];
            forn(i, n2+1, n2*2) Q2.insert(a[i]);
        }
    }
}
//////

void process()
{
    if (dcou[0]==m)
    {
        int cou=0, answer=0;
        forn(i, 1, n)
        {
            if (Q2.find(i)==Q2.end()) ++cou, answer=i;
            if (cou>=2) break;
        }
        if (cou==1) cout << answer; else cout << 0;
        return;
    }

    Q.clear();
    for(auto it=MP.begin(); it!=MP.end(); ++it)
        if (it->second==dcou[1]+dcou[2]) Q.insert(it->first);
    for(auto it=Q2.begin(); it!=Q2.end(); ++it)
        Q.erase(*it);

    if (Q.size()==1) cout << *Q.begin(); else cout << 0;
}
//////

int main()
{
    freopen("fcoin.inp", "r", stdin);
    freopen("fcoin.out", "w", stdout);
    enter();
    process();
}
