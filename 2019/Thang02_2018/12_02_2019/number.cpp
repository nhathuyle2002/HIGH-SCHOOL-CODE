#include <iostream>
#include <stdio.h>
#include <string.h>
#include <vector>
#include <algorithm>

using namespace std;

struct data
{
    int p1, p2, val;
    data(int _p1, int _p2, int _val)
    {
        p1=_p1; p2=_p2; val=_val;
    }
};

const
    int maxn=1010;

int m, n;
char a[maxn], b[maxn];
int l[maxn][maxn];
vector<data> q;
int bit1[maxn], bit2[maxn];
int cou=0;
int res[maxn];

bool cmp(data x, data y)
{
    if (x.val!=y.val) return x.val>y.val;
    return a[x.p1]>a[y.p1];
}

int quece(int i)
{
    if (i==0) return n;
    return min(bit2[i], quece(i-(i&(-i))));
}

void update(int i, int gg)
{
    if (i>m) return;
    bit1[i]=min(bit1[i], gg);
    update(i+(i&(-i)), gg);
}

void enter()
{
    scanf("%s\n%s", a, b);
    m=strlen(a); n=strlen(b);
}

void init()
{
    q.empty();
    for (int i=m-1; i>=0; i--)
        for (int j=n-1; j>=0; j--)
            if (a[i]==b[j])
            {
                l[i][j]=l[i+1][j+1]+1;
                q.push_back(data(i, j, l[i][j]));
            }
            else l[i][j]=max(l[i+1][j], l[i][j+1]);
}

void process()
{
    sort(q.begin(), q.end(), cmp);
    int j=0, maxg;
    for (int jj=0; jj<=m; jj++)
        bit1[jj]=-1;
    for (int i=0; i<q.size(); i++)
    {
        data u=q[i];
        if (i==j)
        {
            for (j=i+1; j<q.size(); j++)
                if (q[j].val!=u.val) break;
            maxg=-1;
            for (int jj=0; jj<=m; jj++)
            {
                bit2[jj]=bit1[jj];
                bit1[jj]=n;
            }
        }
        if (maxg==-1 || int(a[u.p1])-48==maxg)
        {
            int pos=quece(u.p1);
            if (cou==0 || pos<u.p2)
            {
                update(u.p1+1, u.p2);
                if (maxg==-1)
                {
                    maxg=int(a[u.p1])-48;
                    cou++; res[cou]=maxg;
                }
            }
        }
    }
}

void print()
{
    int j;
    for (j=1; j<=cou; j++)
        if (res[j]!=0) break;
    for (int i=j; i<=cou; i++) cout << res[i];
}

int main()
{
    freopen("number.inp", "r", stdin);
    freopen("number.out", "w", stdout);
    enter();
    init();
    process();
    print();
}
