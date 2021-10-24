#include <bits/stdc++.h>
#define forn(i,a,b) for (int i=(a); i<=(b); i++)
#define repn(i,a,b) for (int i=(a); i<(b); i++)
using namespace std;
//////

const
    int maxn=1e5+100;
int n, k, a[maxn], v1, v2;
double x_first, x[maxn], sum;
double res;
priority_queue <int, vector<int>> heap;
//////

void enter()
{
    scanf("%d%d\n", &n, &k);
    scanf("%d%d\n", &v1, &v2);
    scanf("%lf\n", &x_first);
    forn(i, 1, n) scanf("%lf%d\n", &x[i], &a[i]);
}
//////

void process()
{
    while (!heap.empty()) heap.pop();
    sum=0;

    forn(i, 1, n)
    {
        while (x[i]/v2+sum<=(x[i]-x_first)/v1)
        {
            if (heap.empty() || k==0) return;
            sum+=heap.top(); heap.pop();
            --k;
        }
        heap.push(a[i]);
    }
    while (k>0)
    {
        sum+=heap.top(); heap.pop();
        --k;
    }
}

int main()
{
    freopen("chase.inp", "r", stdin);
    freopen("chase.out", "w", stdout);
    enter();
    process();
    cout << setprecision(10) << fixed << (sum*v2+x_first)/(v2-v1);
}
