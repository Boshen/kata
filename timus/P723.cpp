#include <iostream>
#include <vector>
#include <string>

using namespace std;
int main(){
    vector<int> v(26,0);
    string s;
    cin >> s;
    for(size_t i=0;i<s.length();i++){
        v[s[i]-'a']++;
    }
    int max=0;
    int k;
    for(int i=0;i<26;i++){
        if(v[i]>max){
            k=i; 
            max=v[i];
        }
    }
    cout << ((char)(k+'a')) << endl;
}
