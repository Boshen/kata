#include <iostream>
#include <algorithm>
#include <vector>
using namespace std;
class city{
    public:
        long long c;
        int i;
        bool operator<(const city& x) const{
            return c < x.c;
        }
};
bool bin_search(int l, int r);
city x[70010];
int ans[70010];
city cc;
int a,b;
long c;
int n2;
int main(){
    int n;
    cin >> n;
    for(int i=1;i<=n;i++){
        cin >> x[i].c;
        x[i].i = i;
    }
    stable_sort(x+1,x+n+1);
    pair<city*,city*> bounds;
    cin >> n2;
    for(int i=0;i<n2;i++){
        cin >> a >> b >> c;
        cc.c = c;
        bounds = equal_range(x+1, x+n+1, cc);
        if(bounds.first==bounds.second){
                ans[i]=0;
                continue;
        }
        ans[i] = bin_search((int)(bounds.first-x), (int)(bounds.second-bounds.first)+(int)(bounds.first-x)-1);
    }
    for(int i=0;i<n2;i++){
        cout << ans[i];
    }
    cout << endl;
    return 0;
}
bool bin_search(int l, int r){
    int start = l, end = r;
    while(start<=end){ 
        int mid = (start+end)/2;
        if(x[mid].i<a){
            start = mid + 1;
        }else if(x[mid].i > b){
            end = mid - 1;
        }else{
            return 1;
        }
    }
    return 0;
}
