#include <iostream>
using namespace std;

int main(){

    int n, k;
    int tmp;
    int a[100];
    a[0]=0;
    cin >> n >> k;
    for(int i=0;i<k;i++){
        cin >> tmp;
        a[i] = (tmp+a[i]-n)<0 ? 0 : tmp-n+a[i];
        a[i+1] = a[i];
    }
        cout << a[k] << endl;
    return 0;
}
