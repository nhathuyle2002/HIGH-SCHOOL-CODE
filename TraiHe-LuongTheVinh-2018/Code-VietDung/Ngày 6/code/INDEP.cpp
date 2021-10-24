#include <iostream>
#include <stdio.h>
#define For(i,a,b) for(int i=a; i<=b; i++)
#define Fod(i,a,b) for(int i=a; i>=b; i--)

using namespace std;
const int N = 1000100;
struct data
{
    int d[2][2];
    int *operator[](int i) {return d[i];}
};
data s[N];
string a;
int n, r, kq;

void nhap()
{
    freopen("INDEP.INP","r",stdin);
    freopen("INDEP.OUT","w",stdout);
    getline(cin, a);
}
data xulys()
{
    data ans;
    For(x,0,1)
    For(y,0,1)
    {
        ans[x][y] = -1;
        For(i,0,1)
            if (s[r-1][x][i] >= 0 && s[r][i][y] >= 0)
                ans[x][y] = max(ans[x][y], s[r-1][x][i] + s[r][i][y] - i);
    }
    return ans;
}
data xulyp()
{
    data ans;
    For(x,0,1)
    For(y,0,1)
    {
        ans[x][y] = -1;
        if (s[r-1][x][y] >= 0 && s[r][x][y] >= 0)
            ans[x][y] = max(ans[x][y], s[r-1][x][y] + s[r][x][y] - x - y);
    }
    return ans;
}
void xuly()
{
    int n = a.length();
    Fod(i,n-1,0)
        if (a[i] == 'g')
        {
            r++;
            s[r][0][0] = 0;
            s[r][1][0] = s[r][0][1] = 1;
            s[r][1][1] = -1;
        } else  if (a[i] == 'S')
        {
            s[r-1] = xulys();
            r--;
        } else
        {
            s[r-1] = xulyp();
            r--;
        }
    For(i,0,1)
    For(j,0,1) kq = max(kq, s[r][i][j]);
}

int main()
{
    nhap();
    xuly();
    printf("%d", kq);
    return 0;
}
