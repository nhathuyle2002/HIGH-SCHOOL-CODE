#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=1e3+100;
int n;
bool f[maxn];
//////

void process()
{
    f[0]=false; f[1]=true; f[2]=true; f[3]=true;

    forn(len, 4, n)
    {
        f[len]=(!f[len-2]) || (!f[len-3]);
        forn(i, 3, (len+1)/2)
            f[len]=f[len] || (f[i-2]==f[len-i-1]);
    }
    //forn(i, 1, n) cout << i << ' ' << f[i] << '\n';
    if (f[n]) cout << "FIRST PLAYER WINS"; else cout << "FIRST PLAYER LOSES";
}
//////

int main()
{
    freopen("crosses.inp", "r", stdin);
    freopen("crosses.out", "w", stdout);
    cin >> n;
    process();
}
