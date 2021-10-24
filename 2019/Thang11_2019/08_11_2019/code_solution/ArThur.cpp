#include <bits/stdc++.h>

using namespace std;
#define fname "ArThur"
struct ii{
    long double x, y;
};
const int N = 900;
int n;
ii a[N], b[N];
long double res, w1, w2, w3;
vector <ii> ds, ds1;
bool cmpp(ii a, ii b) {
    if (a.y - a.x == b.y - b.x)
        return a.x < b.x;
    return a.y - a.x > b.y - b.x;
}
bool cmp(ii a, ii b) {
    if(a.y == b.y)
        return a.x < b.x;
    return a.y > b.y;
}

int main() {
    ios_base::sync_with_stdio(0);
    cin.tie(0); cout.tie(0);
    if (fopen(fname".inp", "r")) {
        freopen(fname".inp", "r", stdin);
        freopen(fname".out", "w", stdout);
    }
    int ntest;
    cin >> ntest;
    while (ntest--) {
        cin >> n >> w1 >> w2 >> w3;
        for (int i = 1; i <= n; i++)
            cin >> a[i].x >> a[i].y;
        res = 0;
        if (w1 + w2 == 0)
            goto line;
        if (w2 + w3 == 0)
            goto line;
        if (w1 + w3 == 0)
            goto line;
        res = INT_MAX;
        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= n; j++)
                b[j] = a[j];
            swap(b[1], b[i]);
            ds.clear();
            ds1.clear();
            ds.push_back(b[1]);
            for (int j = 2; j <= n; j++) {
                if (b[j].x <= b[j].y)
                    ds.push_back(b[j]);
                else
                    ds1.push_back(b[j]);
            }
            sort(ds.begin() + 1, ds.end(), cmpp);
            sort(ds1.begin(), ds1.end(), cmp);
            for (int j = 0; j < ds1.size(); j++)
                ds.push_back(ds1[j]);
            long double first = ds[0].x + ds[0].y, last, sum;
            sum = ds[0].x;
            last = first;
            for (int j = 1; j < ds.size(); j++) {
                sum += ds[j].x;
                last = max(last, sum) + ds[j].y;
            }
            long double centre = (first * w1 + last * w2) / (w1 + w2);
            long double l = first, r = centre;
            long double ans = last * w2 / (w2 + w3);
            ans = min(ans, centre);
            res = min(res, max((ans - first) * w1,
                               max((last - ans) * w2,
                                   w3 * ans)));
        }
        line:;
        cout << setprecision(1) << fixed << res << '\n';
    }
}
