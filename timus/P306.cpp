#include <iostream>
#include <algorithm>
#include <queue>
using namespace std;
priority_queue<unsigned int> A;
int main(){
    int n;
    cin >> n;
    unsigned int t;
    int i;
    for(i=0;i<=n/2;i++){
        cin >> t;
        A.push(t);
    }
    i=n/2+2;
    while(i<=n){
        cin >> t;
        A.push(t);
        i++;
        A.pop();
    }
    cout.setf(ios::fixed);
    cout.precision(1);
    if(n%2==0){
        t = A.top();
        A.pop();
        t += A.top();
        cout << t/2.0 << endl;
    }else{
    cout << A.top() <<endl;
    }
    return 0;
}

