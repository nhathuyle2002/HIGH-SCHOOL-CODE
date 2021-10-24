#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define ford(i,a,b) for(int i=(a); i>=(b); i--)
using namespace std;
//////

const
    int maxn=60;
const
    int di[4]={1, 1, 1, 2}, dj[4]={-1, 0, 1, 0};
int n;
char a[maxn][maxn];
//////

void enter()
{
    scanf("%d\n", &n);
    forn(i, 1, n)
        scanf("%s\n", a[i]+1);
}
//////

bool check(int i, int j)
{
    if (i<1 || j<1 || i>n || j>n) return false;
    if (a[i][j]=='#') return false;
    a[i][j]='#';
    return true;
}


void process()
{
    forn(i, 1, n)
    {
        forn(j, 1, n)
            if (a[i][j]=='.')
            {
                a[i][j]='#';
                forn(dir, 0, 3)
                    if (!check(i+di[dir], j+dj[dir]))
                    {
                        cout << "NO";
                        return;
                    }
            }
    }
    cout << "YES";
}
//////

int main()
{
    freopen("main.inp", "r", stdin);
    freopen("main.out", "w", stdout);
    enter();
    process();
}
