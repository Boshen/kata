#include <iostream>
#include <algorithm>
#include <vector>
#include <functional>

using namespace std;
int main(){

    int N;
    while( cin >> N){
        if(N==0)break;
        vector<int> v(N*2+1,0);
        v[0]=0;
        v[1]=1;
        for(int i=1;i<=N;i++){
            v[2*i]=v[i];
            v[2*i+1]=v[i]+v[i+1];
        }
        sort(v.begin(),v.begin()+N+1,greater<int>());
        cout << v[0] << endl;
        
    }

    return 0;

}
