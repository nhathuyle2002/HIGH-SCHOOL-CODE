#include <iostream>
#include <sstream>
#include <fstream>
#include <string>
#include <iomanip>
#include <vector>
#include <deque>
#include <queue>
#include <stack>
#include <set>
#include <map>
#include <unordered_map>
#include <algorithm>
#include <functional>
#include <utility>
#include <bitset>
#include <cmath>
#include <cassert>
#include <cstdlib>
#include <ctime>

using namespace std;

#define rep(i,n) for(int i=0;i<n;i++)
#define ll  long long int
#define f first
#define s second
#define pi pair<ll, ll>
#define pii pair<pi,ll>
#define f first
#define s second
#define pb push_back
#define mp make_pair
#define pb push_back
#define rep(i,n) for(int i=0;i<n;i++)
#define fr freopen("source.txt","r",stdin),freopen("output.txt","w",stdout)
int N,M,A,B;
vector< pair< pair<int,int>,double > >E;

double d[1011];
bool vis[511][511]={0};

bool ok(double val){
	vector<pair< pair<int,int>,double > > edges=E;
	rep(i,edges.size()){
		edges[i].s-=val;
	}
	rep(i,N+1){
		d[i]=1e12;
	}
	d[A]=0;
	int x,y;
	double z;
	rep(loop,N-1){
		rep(i,edges.size()){
			x = edges[i].f.f;
			y = edges[i].f.s;
			z = edges[i].s;
			if(d[y]>d[x]+z){
				d[y] = d[x]+z;
			}
		}
	}

	if(d[B] <= 0) return 1;

	rep(i,edges.size()){
		x = edges[i].f.f;
		y = edges[i].f.s;
		z = edges[i].s;
		if(d[y]>d[x]+z and vis[y][B] and vis[A][x]){
			return 1;
		}
	}
	return 0;
}
vector<int>g[1011];

void dfs(int v,int p){
	vis[p][v] = 1;
	rep(i,g[v].size()){
		if(!vis[p][g[v][i]]){
			dfs(g[v][i], p);
		}
	}
}
int main(){
//	fr;
	int T;
	cin >> T;
	while(T--){
		cin >> N >> M;


		double lo = 0;
		double hi = 0;
		int x,y;
		double z;

		rep(i,N+1) g[i].clear();
		rep(i,N+1){
			rep(j,N+1){
				vis[i][j]=0;
			}
		}

		E.clear();
		rep(j,M){
			cin >> x >> y >> z;
			E.pb(mp( mp(x,y),z ));
			hi=max(hi,z);
			g[x].pb(y);
		}
		for(int i=1;i<=N;i++){
			dfs(i,i);
		}
		cin >> A >> B;
		if( !vis[A][B] ){
			cout<<-1<<"\n";
			continue;
		}
		double mid;
		rep(i,100){
			mid=(hi+lo)/2;
			if(ok(mid)) hi=mid;
			else lo=mid;
		}
		cout<<setprecision(10)<<fixed<<hi<<"\n";
	}
}