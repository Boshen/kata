#include <iostream>
#include <string>
#include <algorithm>
using namespace std;
bool myfunc(string x, string y){
    return x[0] < y[0];
}
string s[1001];
int main(){
    int n;
    cin >> n;
    for(int i=0;i<n;i++){
        cin >> s[i];
    }
    sort(s,s+n);
    string c;
    cin >> c;
    pair<string*, string*> bounds;
    bounds = equal_range(s,s+n, c, myfunc);
    for(string* i=bounds.first;i!=bounds.second;i++)
        cout << (*i) << endl;
    
    return 0;
}
