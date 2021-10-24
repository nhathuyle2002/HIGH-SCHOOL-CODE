#include <iostream>
#include <assert.h>
#include <algorithm>
#include <string.h>
using namespace std;


int readPosIntLn(){
	int x=0;
	int cnt=0;
	int fi=-1;
	while(true){
		char g=getchar();
		if('0'<=g && g<='9'){
			x*=10;
			x+=g-'0';
			if(cnt==0){
				fi=g-'0';
			}
			cnt++;
			assert(!(cnt>10 || ( cnt==10 && fi>1) ));
		} else if(g=='\n'){
			return x;
		} else {
			assert(false);
		}
	}
}

long long readPosLongLn(){
	long long x=0;
	int cnt=0;
	int fi=-1;
	while(true){
		char g=getchar();
		if('0'<=g && g<='9'){
			x*=10;
			x+=g-'0';
			if(cnt==0){
				fi=g-'0';
			}
			cnt++;
			assert(!(cnt>19 || ( cnt==18 && fi>1) ));
		} else if(g=='\n'){
			return x;
		} else {
			assert(false);
		}
	}
}

int readPosIntSpace(){
	int x=0;
	int cnt=0;
	int fi=-1;
	while(true){
		char g=getchar();
		if('0'<=g && g<='9'){
			x*=10;
			x+=g-'0';
			if(cnt==0){
				fi=g-'0';
			}
			cnt++;
			assert(!(cnt>10 || ( cnt==10 && fi>1) ));
		} else if(g==' '){
			return x;
		} else {
			assert(false);
		}
	}
}


long long readPosLongSpace(){
	int x=0;
	int cnt=0;
	int fi=-1;
	while(true){
		char g=getchar();
		if('0'<=g && g<='9'){
			x*=10;
			x+=g-'0';
			if(cnt==0){
				fi=g-'0';
			}
			cnt++;
			assert(!(cnt>19 || ( cnt==18 && fi>1) ));
		} else if(g==' '){
			return x;
		} else {
			assert(false);
		}
	}
}

long long fld[350][100100];
int T;
int n,m;
long long row[100100];
long long col[100100];
int main(){
	cin.sync_with_stdio(false);
	//cin>>T;
	T=readPosIntLn();
	assert(1<=T && T<=100);
	int sm=0;
	while(T--){
		n=readPosIntSpace();
		m=readPosIntLn();
		assert(1<=n);
		assert(n<=m);
		assert(n*m<=100000);
		sm+=n*m;
		assert(sm<=500000);
		//cin>>n>>m;
		for(int i=1;i<=n;i++){
			for(int j=1;j<=m;j++){
				//cin>>fld[i][j];
				if(j==m){
					fld[i][j]=readPosIntLn();
				} else {
					fld[i][j]=readPosIntSpace();
				}
				assert(1<= fld[i][j] && fld[i][j]<=1000000000);
			}
		}
		for(int i=1;i<=n;i++){
			for(int j=1;j<=m;j++){
				int h;
				//cin>>h;
				if(j==m){
					h=readPosIntLn();
				} else {
					h=readPosIntSpace();
				}
				assert(1<= h && h<=1000000000);
				fld[i][j]-=h;
			}
		}
		long long mn=0;
		col[1]=0;
		for(int i=2;i<=m;i++){
			col[i] = col[i-1] + fld[1][i]-fld[1][i-1];
			mn=min(col[i],mn);
		}
		long long sol=0;
		for(int i=1;i<=m;i++){
			col[i]-=mn;
			sol+=col[i];
		}
		bool ok=true;
		for(int i=1;i<=n;i++){
			for(int j=2;j<=m;j++){
				if(fld[i][j]-col[j] != fld[i][j-1]-col[j-1]){
					ok=false;
				}
			}
		}
		if(!ok){
			cout<<-1<<endl;
			continue;
		}
		long long diff=m;
		for(int i=1;i<=n;i++){
			row[i]= fld[i][1]-col[1];
			sol+= abs(row[i]);
			if(row[i]>=0){
				diff--;
			} else {
				diff++;
			}
		}
		sort(row+1,row+1+n);
		sort(col+1,col+1+m);
		int st=n;
		long long moves=0;
		int cur=1;
		long long bst=sol;
		while(row[st]>=0){
			st--;
		}
		for(;st>=1;st--){
			int add_moves=-row[st] -moves;
			while(cur<=m && col[cur]-moves <=add_moves){
				sol -= diff * (col[cur]-moves);
				bst=min(sol,bst);
				add_moves -= col[cur]-moves;
				moves += col[cur]-moves;
				cur++;
				diff-=2;
			}
			sol -= diff * add_moves;
			bst=min(sol,bst);
			moves += add_moves;
			diff-=2;

		}
		while(cur<=m){
			sol -= diff * (col[cur]-moves);
			bst=min(sol,bst);
			moves += col[cur]-moves;
			cur++;
			diff-=2;
		}
		cout<<bst<<endl;
	}
	assert(getchar()==-1);
}
