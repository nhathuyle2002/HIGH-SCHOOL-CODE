#include <iostream>
#include <stdio.h>
#include <vector>

using namespace std;
////////

typedef pair<int, int> pii;

int n;
int pos[30];
vector<pii> ot;
////////

void enter()
{
    char x;
    scanf("%d\n", &n);
    for (int i=1; i<=n; i++)
    {
        scanf("%c", &x);
        pos[i]=x-'A'+1;
    }
}
////////

void dequy(int i, int a, int b)
{
    if (i==0) return;
    dequy(i-1, a, 6-a-b);
    ot.push_back(pii(a, b));
    dequy(i-1, 6-a-b, b);
}

void process()
{
    ot.clear();
    pos[n+1]=3;
    for (int i=1; i<=n; i++)
        if (pos[i]!=pos[i+1]) dequy(i, pos[i], pos[i+1]);
    cout << ot.size() << '\n';
    for (int i=0; i<ot.size(); i++) cout << char(ot[i].first+'A'-1) << char(ot[i].second+'A'-1) << '\n';
}
////////

int main()
{
    freopen("hanoi.inp", "r", stdin);
    freopen("hanoi.out", "w", stdout);
    enter();
    process();
}
