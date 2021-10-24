#include <bits/stdc++.h>

using namespace std;
#define fname "Sp"
const int N = 211;
int a, b, c, s, res;
int f[N][N][N], g[N][N][N];
int main() {
    ios_base::sync_with_stdio(0);
    cin.tie(0); cout.tie(0);
    if (fopen(fname".inp", "r")) {
        freopen(fname".inp", "r", stdin);
        freopen(fname".out", "w", stdout);
    }
    cin >> a >> b >> c >> s;
    if (s == 1) {
        cout << a + b + c;
        return 0;
    }
    for (int i = 0; i <= a; i++)
        for (int j = 0; j <= b; j++)
            for (int k = 0; k <= c; k++) {
                if (i > 0) {
                    int sum = g[i - 1][j][k] + 1;
                    if (f[i][j][k] == f[i - 1][j][k] + (sum >= s))
                        g[i][j][k] = max(g[i][j][k], (sum >= s) ? 0 : sum);
                    if (f[i][j][k] < f[i - 1][j][k] + (sum >= s)) {
                        f[i][j][k] = f[i - 1][j][k] + (sum >= s);
                        g[i][j][k] = (sum >= s) ? 0 : sum;
                    }
                }
                if (j > 0) {
                    int sum = g[i][j - 1][k] + 2;
                    if (f[i][j][k] == f[i][j - 1][k] + (sum >= s))
                        g[i][j][k] = max(g[i][j][k], (sum >= s) ? 0 : sum);
                    if (f[i][j][k] < f[i][j - 1][k] + (sum >= s)) {
                        f[i][j][k] = f[i][j - 1][k] + (sum >= s);
                        g[i][j][k] = (sum >= s) ? 0 : sum;
                    }
                }
                if (k > 0) {
                    int sum = g[i][j][k - 1] + 3;
                    if (f[i][j][k] == f[i][j][k - 1] + (sum >= s))
                        g[i][j][k] = max(g[i][j][k], (sum >= s) ? 0 : sum);
                    if (f[i][j][k] < f[i][j][k - 1] + (sum >= s)) {
                        f[i][j][k] = f[i][j][k - 1] + (sum >= s);
                        g[i][j][k] = (sum >= s) ? 0 : sum;
                    }
                }
            }
    cout << f[a][b][c];
}
