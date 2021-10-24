#include "iostream"
#include "algorithm"
#include "vector"
#include <cstring>
#include <cstdio>

#define MaxN 10015

using namespace std;

char sHead[20] = "Test";

char inp[20] = "/radar.inp";
char out[20] = "/radar.out";


struct coordinate {
	int x1;
	int y1;
	int x2;
	int y2;
	int id;
};


int n;
int f[MaxN],p[MaxN];
int MaxL=0;
coordinate a[MaxN];
int Lab[MaxN],rLab[MaxN];
int Mark[MaxN];
int last;
int Mat[MaxN];
int stop,sstop;
int iCount;

vector<int> L[MaxN];
vector<int> Adj[MaxN];
//vector<int> Adj1[MaxN];

int see(int i, int j) {
	//chi xet goc phan tu tren phai
	if ((a[i].x2<a[j].x1)&&(a[i].y1<a[j].y2)) return 0;
	return 1;
/*
	if ((a1[i].x<a2[j].x)&&(a1[i].y>a2[j].y)) return 1;
	if ((a2[i].x>a1[j].x)&&(a2[i].y<a1[j].y)) return 1;
	return 0;
*/
}

int see1(int i, int j) {


    if ((a[i].x2<a[j].x1)&&(a[i].y1<a[j].y2)) return 0;
    if ((a[i].x1>a[j].x2)&&(a[i].y2>a[j].y1)) return 0;

//	if ((a[i].x1<=a[j].x2)&&(a[i].y1>=a[j].y2)) return 1;
//	if ((a[i].x2>=a[j].x1)&&(a[i].y2<=a[j].y1)) return 1;
	return 1;
}

void print(int i) {
	cout << a[i].x1 << " " << a[i].y1 << " " << a[i].x2 << " " << a[i].y2 << "\n";
}

bool tang(coordinate u, coordinate v) {
	return u.x1 < v.x1;
}

void put_into_level() {
	for (int i = 1; i <= n; ++i) {
		f[i]=1;
		p[i]=0;
	}
	for (int i = 2; i <=n; ++i) {
		for (int j = 1; j<i; ++j)
			if (f[j]+1>f[i])
				if (!see(j,i)) {
					f[i]=f[j]+1;
					p[i]=j;
				}
	}

	last=0;
	MaxL=0;
	for (int i = 1; i <=n; ++i)
		if (f[i]>MaxL) {
			MaxL = f[i];
			last=i;
		}
}

void MaxIndependent() {
//	cout << " vao day";
	sort(a+1,a+n+1,tang);

 //   for (int i = 1; i <=n; ++i) print(i);
	put_into_level();
//	for (int i = 1; i <=n; ++i) cout << f[i] << " ";
//	cout << "\n";

	cout << MaxL << "\n";
/*	while (last!=0) {
		cout << a[last].id << " ";
		last = p[last];
	}
	cout << "\n";
*/

}

void Init_Level() {
	put_into_level();
	int u=1;
	for (int i = 1; i <=MaxL; ++i) L[i].clear();
	for (int i = MaxL; i >=1; --i) {
		for (int j = 1; j<=n; ++j)
			if (f[j]==i) {
				L[u].push_back(j);
//				cout << u << " ";
			}
		u++;
//		cout << "\n";
	}
}

void Insert(int i) {
	int j=Adj[i].size()-1;
	int u=j-1;
	while ((u>=0)&&(Adj[i][u]<Adj[i][j]))
		u--;
	int tg=Adj[i][j];
	Adj[i][j]=Adj[i][u+1];
	Adj[i][u+1]=tg;
}

void MakeAdj(int i, int lev) {
	Adj[i].clear();
//	cout << lev << "   ";
	for (int le = lev; le >0; --le)

	for (int j = L[le].size()-1; j>=0; --j) {
		if (!see(i,L[le][j])) {
			Adj[i].push_back(Lab[L[le][j]]);
			Insert(i);
		}
	}
/*
	cout << " " << i << " " << Adj[i].size() << "     ";
	for (int j=0; j<Adj[i].size(); j++)
		cout << Adj[i][j] << " ";
	cout << "\n";
*/
}

int isgreater(vector<int>&a, vector<int>&b) {
	int length = min(a.size(), b.size());
	for (int i=0; i<length; i++)
		if (a[i] != b[i])
			return a[i] > b[i];
	return a.size() > b.size();
}

void labeling() {
	int Id=0;
	Lab[0]=rLab[0]=0;
	for (int i = 0; i < L[1].size(); ++i) {
		Id++;
		int ii=L[1][i];
		Lab[ii]=Id;
		rLab[Id]=ii;
//		cout << a[ii].id << " " << Id << "\n";
	}
	for (int i = 2; i <=MaxL; ++i) {
		int List[MaxN];
		int len=0;
		for (int j = 0; j<L[i].size(); ++j) {
			MakeAdj(L[i][j],i-1);

			len++;
			List[len]=L[i][j];
			int u=len-1;
			vector<int> a1,a2;
			while ((u>0)&&(isgreater(Adj[List[u]],Adj[List[len]])))
				u--;
			int tg = List[len];
			List[len] = List[u+1];
			List[u+1] = tg;
		}

		for (int j = 1; j <= len; ++j) {
			Id++;
			int jj=List[j];
			Lab[jj]=Id;
			rLab[Id]=jj;
//			cout << a[jj].id << " " << Id << "\n";
		}

	}
}

int Match(int i) {
	int ii=rLab[i];
	int j=i-1;
	int jj=rLab[j];
	while (j>0) {
		if ((Mark[j]==0)&&(see1(ii,jj)))
			return j;
		j--;
		jj=rLab[j];
	}
	return 0;
}

void greedy_match() {
	for (int i = 1; i <=n; ++i) Mark[i]=0;
//	cout << "Match: \n";
	iCount = 0;
	for (int i = n; i>0; --i) {
		if (Mark[i]==0) {
			int j=Match(i);
			int ii=rLab[i];
			int jj=rLab[j];
			if (j!=0) {
				iCount++;
				Mark[i]=j;
				Mark[j]=i;
				cout << a[ii].id << " " << a[jj].id << endl;
			}
			//Mark[i]=Mark[j]=1;
		}
	}
	cout << iCount << endl;
}

void print_vec(vector<int> &v){
	for (int i=0; i<v.size(); i++)
		cout<<a[v[i]].id<<" ";
	cout<<endl;
}

void Create_Adj() {
	for (int i = 1; i <=n; ++i)
		Adj[i].clear();

	for (int i = 1; i <n; ++i)
	{
		for (int j=i+1; j<=n; j++)
			if (see1(i,j)) {
				Adj[i].push_back(j);
				Adj[j].push_back(i);
			}
	}
/*
	for (int i = 1; i <=n; ++i) {
		cout << a[i].id << "     ";
		print_vec(Adj[i]);
	}
*/
}

void Augmentation(int i) {
//	cout << endl << i << " ";
	int j=p[i];
	if (j<=0) return;
	Mat[i]=j;
	Mat[j]=i;
	int jj=p[j];
	if (jj>0) Augmentation(jj);

}

void Duyet(int i,int step) {
	if (step%2==1) {
		for(int j=0; j<Adj[i].size(); j++)
			if (!stop) {
			int jj=Adj[i][j];
			if (p[jj]==0) {
				p[jj]=i;
				if (Mat[jj]==0) {
//					cout << "Bingo " << jj << endl;
					iCount++;
					Augmentation(jj);
					stop=1;
					sstop=1;
					p[jj]=0;
					return;
				}
				Duyet(jj,step+1);
				p[jj]=0;
			}
		}
	} else {
		int jj=Mat[i];
		p[jj]=i;
		Duyet(jj,step+1);
		p[jj]=0;
	}

}



void Try_more() {
	Create_Adj();
/*	for (int i = 1; i <=n; ++i) {
		if (Mark[i]!=0) {
			int ii=rLab[i];
			int jj=rLab[Mark[i]];
			Mat[ii]=jj;
			Mat[jj]=ii;
		}
	}
*/

	for (int j = 1; j <=n; ++j) p[j]=0;
	do {
		sstop=0;
	for (int i = 1; i <=n; ++i)
		if (Mat[i]==0) {
//			cout << a[i].id << " "<< endl;
			p[i]=-1;
			stop=0;
			Duyet(i,1);
			p[i]=0;
		}
	} while(sstop);
	cout << iCount << endl;
/*	for (int i = 1; i <=n; ++i)
		if (Mat[i]!=0)
			cout << a[i].id << " " << a[Mat[i]].id << endl;
*/
}

void MaxMatching() {
	sort(a+1,a+n+1,tang);
/*	Init_Level();
	labeling();
	greedy_match();
*/	for (int i = 1; i <=n; ++i) {
		Mark[i]=0;
		Mat[i]=0;
	}
	iCount=0;
	Try_more();

}

int main(int argc, char const *argv[])
{
/*
for (int t=1;t<=20;t++) {

	char inp1[20];
	char out1[20];
	//char tmp = t+"0"
	strcpy(inp1,sHead);
	char ct[20]="00";
	ct[0]=t/10+'0';
	ct[1]=t%10+'0';
	strcat(inp1,ct);

	strcpy(out1,inp1);
	strcat(inp1,inp);
	strcat(out1,out);
	cerr << inp1<< " "<< out1 << endl;
*/

	char inp1[20]="radar.inp";
	char out1[20]="radar.out";
	freopen(inp1,"r",stdin);
	freopen(out1,"w",stdout);
	int r,K;
	cin >> r;
	cin >> K;
//	cout << 2 << endl << 1 << endl << 11 << endl;
	for (int i = 1; i <= K; ++i)
	{
		cin >> n;
		for (int j = 1; j <= n; ++j) {
			cin >> a[j].x1 >> a[j].y1 >> a[j].x2 >> a[j].y2;
			a[j].id=j;
//			if (i==82)	print(j);
		}
			if (r==1) MaxIndependent();
			else MaxMatching();
	}

//}
	return 0;
}
