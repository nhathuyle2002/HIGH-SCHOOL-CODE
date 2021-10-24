#include <vector>
#include <iostream>
#include <cstdio>
#include <algorithm>
#include <cassert>

using namespace std;

const int MAXN = 1000000 + 10;
const int SHIFT = MAXN;
const int SMALL_PART_SIZE = 100;

int Tn, n, w, a[MAXN], kol[MAXN * 5], mkn, mk[MAXN * 5], sum_n, b[MAXN];
long long answer;
vector<pair<int, int> > query[MAXN];

inline void add_query (int L, int R, int balance) {
    if (L > R)
        return ;
    query[L].push_back(make_pair(balance, 1));
    query[R+1].push_back(make_pair(balance, -1));
}

inline void clear_queries (int L, int R) {
    for(int i = 1; i <= mkn; i++)
        kol[mk[i]] = 0;
    mkn = 0;
    for(int i = L - 1; i <= R+1; i++) {
        query[i].clear();
    }
}

inline void answer_queries (int pos) {
    for(int i = 0; i < query[pos].size(); i++) {
        int rev = -query[pos][i].first + SHIFT;
        answer += query[pos][i].second * kol[rev];
    }
}

/*
 This is the main function of the solution. It calculates the answer on a subsegment A[L..R].
 For doing this, we split the problem into two parts:
    - finding the number of "suitable" subsegments in the part A[L..(L + R) / 2]
    - finding the number of "suitable" subsegments in the part [(L + R) / 2 + 1 .. R]
    - finding the number of "suitable" subsegments that cross the both above mentioned parts
 */
void solve (int L, int R) {
    /*
     If the length of the array is less than w, it is obviously not interesting for us, so we can just exit.
     */
    if (R - L + 1 < w)
        return ;
    if (L + SMALL_PART_SIZE > R) {
        for(int i = L; i <= R - w + 1; i++) {
            int cur_max = a[i];
            int cur_min = a[i];
            for(int j = i; j <= R; j++) {
                cur_min = min(cur_min, a[j]);
                cur_max = max(cur_max, a[j]);
                if (cur_max - cur_min == j - i && j - i + 1 >= w)
                    ++answer;
            }
        }
        return ;
    }
    int middle = (L + R) / 2;
    /*
     Solving the problem in the left and right halves.
     */
    solve(L, middle);
    solve(middle + 1, R);
    /*
     Case 1: Suppose that the maximal element is in the part A[middle + 1; R], and the minimal element is in the same part.
     */
    int cur_max = a[middle + 1];
    int cur_min = a[middle + 1];
    int pfh = middle + 1;
    for(int i = middle + 1; i <= R; i++) {
        cur_max = max(cur_max, a[i]);
        cur_min = min(cur_min, a[i]);
        while (pfh > L && a[pfh - 1] > cur_min && a[pfh - 1] < cur_max)
            --pfh;
        if (i - pfh == cur_max - cur_min && i - pfh + 1 >= w && pfh <= middle)
            ++answer;
    }
    /*
     Case 2: Suppose that the maximal element is in the part A[middle + 1; R], and the minimal element is in the part A[L; middle]
     */
    cur_max = a[middle + 1];
    cur_min = a[middle + 1];
    int cur_min2 = a[middle + 1];
    pfh = middle+1;
    int pfh2 = middle+1;
    for(int i = middle + 1; i <= R; i++) {
        cur_max = max(cur_max, a[i]);
        cur_min = min(cur_min, a[i]);
        while (pfh > L && a[pfh - 1] < cur_max) {
            --pfh;
        }
        while (pfh2 > L && cur_min2 >= cur_min) {
            --pfh2;
            cur_min2 = min(cur_min2, a[pfh2]);
        }
        int have = cur_max - i;
        if (cur_min2 < cur_min) add_query(pfh, min(i - w + 1, pfh2), have);
    }
    cur_min = a[middle];
    for(int i = middle; i >= L; i--) {
        cur_min = min(cur_min, a[i]);
        ++kol[mk[++mkn] = i - cur_min + SHIFT];
        answer_queries(i);
    }
    clear_queries(L, R);
    /*
     Case 3: Suppose that the minimal element is in the part A[middle + 1; R], and the maximal element is in the part A[L; middle]
     */
    cur_max = a[middle+1];
    cur_min = a[middle+1];
    pfh = middle+1;
    int cur_max2 = a[middle + 1];
    pfh2 = middle + 1;
    for(int i = middle+1; i <= R; i++) {
        cur_max = max(cur_max, a[i]);
        cur_min = min(cur_min, a[i]);
        while (pfh > L && a[pfh - 1] > cur_min)
            --pfh;
        while (pfh2 > L && cur_max2 <= cur_max) {
            --pfh2;
            cur_max2 = max(cur_max2, a[pfh2]);
        }
        int have = - i - cur_min;
        if (cur_max2 > cur_max) add_query(pfh, min(i - w + 1, pfh2), have);
    }
    cur_max = a[middle];
    for(int i = middle; i >= L; i--) {
        cur_max = max(cur_max, a[i]);
        ++kol[mk[++mkn] = cur_max + i + SHIFT];
        answer_queries(i);
    }
    clear_queries(L, R);
    /*
     Case 4: Suppose that the maximal element is in the part A[L; middle], and the minimal element is in the same part.
     */
    cur_max = a[middle];
    cur_min = a[middle];
    pfh = middle;
    for(int i = middle; i >= L; i--) {
        cur_max = max(cur_max, a[i]);
        cur_min = min(cur_min, a[i]);
        while (pfh < R && a[pfh + 1] > cur_min && a[pfh + 1] < cur_max)
            ++pfh;
        if (pfh - i == cur_max - cur_min && pfh - i + 1 >= w && pfh > middle)
            ++answer;
    }
}

int main(int argc, const char * argv[]) {
    ios_base::sync_with_stdio(false);
    cin >> Tn;
    assert(1 <= Tn && Tn <= 100000);
    while (Tn--) {
        answer = 0;
        cin >> n >> w;
        assert(1 <= n && n <= 1000000);
        assert(1 <= w && w <= n);
        sum_n += n;
        for(int i = 1; i <= n; i++) {
            cin >> a[i];
            b[i] = i;
        }
        sort(b + 1, b + n + 1);
        for(int i = 1; i <= n; i++)
            assert(b[i] == i);
        solve(1, n);
        cout << answer << endl;
    }
    assert(sum_n <= 1000000);
    return 0;
}
