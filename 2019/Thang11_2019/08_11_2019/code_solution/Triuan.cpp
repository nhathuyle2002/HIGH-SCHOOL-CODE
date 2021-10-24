#include <bits/stdc++.h>

using namespace std;
#define fname "Triuan"
const int N = 2022;
const int mod = 1e9 + 7;
int n, m, s, l, w[N], h[N], f[N];
int main() {
    if (fopen(fname".inp", "r")) {
        freopen(fname".inp", "r", stdin);
        freopen(fname".out", "w", stdout);
    }
    cin >> n >> m >> s >> l;
    if (n != l && m != l) {
        cout << 0;
        return 0;
    }
    for (int i = 1; i <= s; i++) {
        cin >> w[i] >> h[i];
        if (n == l)
            swap(w[i], h[i]);
    }
    if (n == l)
        swap(n, m);
    f[0] = 1;
    for (int i = 1; i <= n; i++) {
        f[i] = f[i - 1];
        if (i >= l)
            f[i] =(f[i] + f[i - l]) % mod;
    }
    cout << f[n];
}
