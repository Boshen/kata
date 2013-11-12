#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;
int main(){
    int N, tmp, min;
    int sumA=0, sumB=0;
    vector<int> A;
    vector<int> B;
    cin >> N;
    for(int i=0;i<N;i++){
        cin >> tmp;
        A.push_back(tmp);
        sumA+=tmp;
    }
    sort(A.begin(),A.end());

     
}
