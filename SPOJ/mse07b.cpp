#include <iostream>
#include <stdio.h>
#include <set>

using namespace std;

int a[1000010];

struct cmp
{
    bool operator() (int p1, int p2)
    {
        return a[p1]<a[p2];
    }
};

set<int, cmp> p;

int main()
{
    freopen("mse07b.inp", "r", stdin);
    freopen("mse07b.out", "w", stdout);
    p.clear();
    do
    {
        int id, pos, w;
        scanf("%d", &id);
        if (id==0) break;
        if (id==1)
        {
            scanf("%d%d", &pos, &w);
            p.erase(pos);
            a[pos]=w;
            p.insert(pos);
        } else
        {
            if (p.empty())
            {
                cout << 0;
            } else
            if (id==2)
            {
                set<int> :: reverse_iterator it;
                it=p.rbegin();
                cout << *it;
                p.erase(*it);
            } else
            if (id==3)
            {
                set<int> :: iterator it;
                it=p.begin();
                cout << *it;
                p.erase(it);
            }
            cout << '\n';
        }
    }
    while (true);
    return 0;
}
