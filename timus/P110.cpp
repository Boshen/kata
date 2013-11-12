#include <iostream>

using namespace std;
int main(){
    int N, M, Y;
    cin >> N >> M >> Y;
    if(Y>=M){
        cout<<-1<<endl;
        return 0;
    }

    int tmp = 0;
    int ans;
    for(int i=0;i<M;i++){
        ans = i%M;
        for(int j=0;j<N-1;j++){
            ans*=i;
            ans%=M;
        }
        if(ans==Y){
            cout << i << " ";
            tmp = 1;
        }
    }
    if(tmp==0)
        cout << -1 << endl;
    return 0;
}
