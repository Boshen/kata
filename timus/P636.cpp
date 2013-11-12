#include <iostream>
using namespace std;

int main(){
    int t1, t2, n;
    int c = 0;
    cin >> t1 >> t2;
    for(int i=0;i<10;i++){
        cin >> n;
        c+=(n*20);
    }
    t2-=c;
    cout << (t2<t1 ? "Dirty debug :(" : "No chance.") << endl;
    return 0;
}
