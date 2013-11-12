#include <iostream>
using namespace std;

int main(){
    int a,ans;
    cin >> a;
    if(a==0)
        ans = 1;
    else if(a<0)
    ans = (-1)*(int) (a-1)*(a/2.0 )+ 1;
    else
    ans = (int) (a+1)*(a/2.0);
    
    cout << ans << endl;

    return 0;
}
