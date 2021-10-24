#include <iostream>
#include <stdio.h>
#include <set>

using namespace std;

struct cmp
{
    bool operator() (int a, int b)
    {
        return a>b;
    }
};

set<int> s1;
set<int, cmp> s2;

int main()
{
    freopen("cppset.inp", "r", stdin);
    freopen("cppset.out", "w", stdout);
    s1.clear(); s2.clear();
    int id;
    do
    {
        scanf("%d", &id);
        if (id==0) break;
        int x;
        if (id!=3 && id!=4) scanf("%d", &x);
        if (id==1)
        {
            s1.insert(x);
            s2.insert(x);
        } else
        if (id==2)
        {
            s1.erase(x);
            s2.erase(x);
        } else
        {
        if (s1.empty())
        {
            cout << "empty" << '\n';
            continue;
        }
        set<int> :: iterator it;
        if (id==3) it=s1.begin();
        else
        if (id==4) it=s2.begin();
        else
        if (id==5) it=s1.upper_bound(x);
        else
        if (id==6) it=s1.lower_bound(x);
        else
        if (id==7) it=s2.upper_bound(x);
        else
        if (id==8) it=s2.lower_bound(x);
        if ((id<=6 && it==s1.end()) || (id>=7 && it==s2.end())) cout << "no" << '\n';
        else cout << *it << '\n';
        }
    }
    while (true);
    return 0;
}
