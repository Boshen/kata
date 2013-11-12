#include <iostream>
#include <queue>
using namespace std;

queue<int> a[101];
int main(){
    int n, t;
    cin >> n;
     
    for(int i=0;i<n;i++){
        for(int j=0;j<n;j++){
            cin >> t;
            a[i].push(t);
        }
    }
    for(int i=0;i<n;i++){
        for(int j=i;j>=0;j--){
            cout << a[j].front() << " ";
            a[j].pop();
        }
    }

    for(int i=n-1;i>0;i--){
        for(int j=n-1;j>=n-i;j--){
            //cout << j << endl;
            cout << a[j].front() << " ";
            a[j].pop();
        }
    }
    return 0;
}
