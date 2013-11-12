#include <iostream>
#include <set>
#include <string>

using namespace std;
int main(){
    int N;
    cin >> N;
    set<string> v;
    string s;
    cin.ignore();
    while(getline(cin,s)){
        //cout << s << endl;
            v.insert(s);
    }

    //for(set<string>::iterator it=v.begin();it!=v.end();it++){
    //    cout << *it << endl;
    //}
    cout << N-v.size();
    return 0;
}
