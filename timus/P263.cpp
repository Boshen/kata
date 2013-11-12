#include <iostream>
#include <vector>
using namespace std;
int main(){
    int N, M;
    int tmp;

    cin >> N;
    cin >> M;

    vector<int> v(N+1);
    for(int i=0; i<M;i++){
        cin >> tmp;
        v[tmp]++;
    }
    cout.setf(ios::fixed);  
    cout.precision(2);
    for(int i=1; i<=N;i++){
        cout << 100*v[i]/double(M) << "%" << endl;
    }
    return 0;
}
