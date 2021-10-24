#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define ford(i,a,b) for(int i=(a); i>=(b); i--)
using namespace std;
//////

const
    int maxn=1e5+100;
const
    int c[10]={6, 2, 5, 5, 4, 5, 6, 3, 7, 6};
int n;
int a[maxn], s[maxn];
vector<int> q1, q2;
//////

void enter()
{
    char ss[maxn];
    scanf("%s", ss+1); n=strlen(ss+1);
    forn(i, 1, n)
    {
        a[i]=ss[i]-48;
        s[i]=s[i-1]+c[a[i]];
    }
}
//////

int cnp1(int y, int i, int sum)
{
    int L=i, R=n+1;
    while (L<R)
    {
        int mid=(L+R)>>1;
        if (sum-(mid-i+1)*c[y]>=2*(n-mid)) L=mid+1; else R=mid;
    }
    return L-1;
}

int cnp2(int y, int i, int sum)
{
    int L=i, R=n+1;
    while (L<R)
    {
        int mid=(L+R)>>1;
        if (sum-(mid-i+1)*c[y]<=7*(n-mid)) L=mid+1; else R=mid;
    }
    return L-1;
}

void process()
{
    ford(i, n, 1)
        forn(x, a[i]+1, 9)
        {
            int sum=s[n]-s[i-1]-c[x];
            int j=i+1;
            q1.clear(); q2.clear();
            q1.push_back(j); q2.push_back(x);
            forn(y, 0, 9)
            {
                if (j>n) break;
                int pos1=cnp1(y, j, sum), pos2=cnp2(y, j, sum);
                int pos=min(pos1, pos2);
                if (pos>=j)
                {
                    sum-=(pos-j+1)*c[y]; j=pos+1;
                    q1.push_back(j); q2.push_back(y);
                }
            }
            if (sum==0 && j>n)
            {
                forn(t, 1, i-1) cout << a[t];
                cout << x;
                forn(t, 1, q1.size()-1)
                    forn(t2, q1[t-1], q1[t]-1) cout << q2[t];
                return;
            }
        }
    cout << "NO SOLUTION";
}
//////

int main()
{
    freopen("event.inp", "r", stdin);
    freopen("event.out", "w", stdout);
    enter();
    process();
}
