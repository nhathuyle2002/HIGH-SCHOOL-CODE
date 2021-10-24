#include<iostream>
#include<fstream>
#include<queue>

using namespace std;

const int tx[4] = {-1, 0, 1 ,0}, ty[4] = {0, 1, 0, -1};
struct ii{
    int x, y;
};

int n, m, k, xt[101], yt[101], da = 0, x[101], y[101];
char a[101][101];
bool kt[101][101];

void xuli(int s){
    deque<ii>q;
    if(s > k){
        da++;
        return;
    }
    for(int i = 1; i < s; i++){
        for(int j = 0; j < 4; j++){
            int xt = x[i] + tx[j], yt = y[i] + ty[j];
            if(!kt[xt][yt] && a[xt][yt] == '0'){
                ii tam;
                tam.x = xt; tam.y =yt;
                q.push_back(tam);
                kt[xt][yt] = true;
                x[s] = xt; y[s] = yt;
                xuli(s + 1);
            }
        }
    }
    while(!q.empty()){
        int xt = q.front().x, yt = q.front().y;
        kt[xt][yt] = false;
        q.pop_front();
    }
}

int main(){
    freopen("COLOR.INP","r",stdin);
    freopen("COLOR.OUT","w",stdout);
    cin >> n >> m >> k;
    for(int i = 1; i <= n; i++){
        for(int j = 1; j <= m; j++){
            cin >> a[i][j];
        }
    }
    for(int i = 1; i <= n; i++){
        for(int j = 1; j <= m; j++){
            if(a[i][j] == '0'){
                x[1] = i; y[1] = j;
                kt[i][j] = true;
                xuli(2);
            }
        }
    }
    cout << da;
}
