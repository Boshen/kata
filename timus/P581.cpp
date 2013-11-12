#include <iostream>
using namespace std;
int a[1001];
int main(){
    int n;
    cin >> n;
    for(int i = 0;i<n;i++){
        cin >> a[i];
    }
    int count = 1;
    for(int i = 0;i<n;i++){
        if(a[i]==a[i+1])
            count++;
        if(a[i]!=a[i+1]){
            cout << count << " " << (a[i]) << " ";
            count = 1;
        }
    }
    cout << endl;
    return 0;
}
