#include <iostream>
#include <vector>
#include <queue>

using namespace std;
int main(){
    int N;
    cin >> N;
    vector<queue<int> > v(N*2-1, queue<int>());
    //for(int i=0;i<N*2-1;i++){
    //    for(int j=0;j<N;j++){
    //        v[i][j] = 0;
    //    }
    //}

    int t=1;
    for(int i=0;i<N;i++){
        for(int j=0;j<=i;j++){
            v[i].push(t);
            t++;
        }
    }
    for(int i=N;i<N*2-1;i++){
        for(int j=0;j<N*2-i-1;j++){
            v[i].push(t);
            t++;
        }
    }
    int row=N-1;
    for(int i=0;i<N;i++){
        for(;row>=i;row--){
            cout << v[row].front();
            v[row].pop();
            if(row!=i)cout<<" ";
        }
        row+=N+1;
        cout << endl;
    }

    return 0;
}
