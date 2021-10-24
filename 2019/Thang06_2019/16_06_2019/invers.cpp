#include <bits/stdc++.h>
using namespace std;

const
    int maxn=5e5+100;
int f[maxn];

int main()
{
    freopen("invers.inp", "r", stdin);
    freopen("invers.out", "w", stdout);
	int n,x;
	long long ans=0;
	cin >> n;
	for (int t=1; t<=n; t++)
	{
		scanf("%d",&x);
		for (int i=x+1;i<=n;i+=i&-i) ans+=f[i];
		for (int i=x;i;i-=i&-i) f[i]++;
	}
	cout << ans << endl;
}
