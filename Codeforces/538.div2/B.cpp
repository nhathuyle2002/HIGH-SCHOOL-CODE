#include <iostream>
#include <algorithm>

using namespace std;
/////////

typedef pair<int, int> pii;

const
    int maxn=2e5+100;

int n, m, k;
pii a[maxn];
int pos[maxn];
long long sum;
////////

bool cmp(pii x, pii y)
{
    return x.first>y.first;
}
////////

void enter()
{
    scanf("%d%d%d", &n, &m, &k);
    for (int i=1; i<=n; i++)
    {
        scanf("%d", &a[i].first);
        a[i].second=i;
    }
    sort(a+1, a+1+n, cmp);
}
////////

void process()
{
    sum=0;
    for (int i=1; i<=m*k; i++)
    {
        sum+=a[i].first;
        pos[i]=a[i].second;
    }
    sort(pos+1, pos+(m*k)+1);
    cout << sum << '\n';
    for (int i=1; i<=k-1; i++)
        cout << pos[i*m] << ' ';
}

int main()
{
    enter();
    process();
}
