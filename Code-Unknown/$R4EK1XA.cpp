// coded by Binh_CBL_D5
#include <bits/stdc++.h>

#define FOR(i,a,b) for( int i=(a), _b=(b); i<=_b; i++)
#define FORD(i,a,b) for( int i=(a), _b=(b); i>=_b; i--)

using namespace std;

const	int mn = 505;

int     now,m,n,a[mn][mn],t[mn*4][mn*4],x1,y1,x2,y2;

void	enter()
{
    cin>>m>>n;
    FOR(i,1,m)
    FOR(j,1,n) scanf("%d",&a[i][j]);
}

void    build2(int row, int i, int l, int r)
{
    if (l==r)
    {
        if (now==0) t[row][i]=min(t[row*2][i],t[row*2+1][i]); else
        t[row][i]= a[now][l];
        return;
    } else
    {
        int mid= (l+r)/2;
        build2(row,i*2,l,mid);
        build2(row,i*2+1,mid+1,r);
        t[row][i]= min(t[row][i*2],t[row][i*2+1]);
    }
}
void    build(int i, int l, int r)
{
    if (l==r)
    {
        now= l;
        build2(i,1,1,n);
        return;
    } else
    {
        int mid=(l+r)/2;
        build(i*2,l,mid);
        build(i*2+1,mid+1,r);
        now= 0;
        build2(i,1,1,n);
    }
}

int get2(int wk, int i, int l, int r)
{
    if (l>y2 || r<y1) return 2147483647;
    if (l>=y1 && r<=y2) return t[wk][i];
    int mid=(l+r)/2;
    return min(get2(wk,i*2,l,mid),get2(wk,i*2+1,mid+1,r));
}

int get(int i, int l, int r)
{
    if (l>x2 || r<x1) return 2147483647;
    if (l>=x1 && r<=x2) return get2(i,1,1,n);
    int mid =(l+r)/2;
    return min(get(i*2,l,mid),get(i*2+1,mid+1,r));
}

void	solve()
{
    build(1,1,m);
    int q;
    cin>>q;
    FOR(qq,1,q)
    {
        scanf("%d%d%d%d",&x1,&y1,&x2,&y2);
        cout << get(1,1,m) << '\n';
    }
}

int 	main()
{
	freopen("rmq2.inp","r",stdin);
	freopen("rmq2.out","w",stdout);

	enter();
	solve();

	return 0;
}
