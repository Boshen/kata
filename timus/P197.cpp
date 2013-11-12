#include <iostream>
#include <string>

using namespace std;
int main(){
    int v[9][9] = { { 2, 3, 4, 4, 4, 4, 3, 2 } ,{ 3, 4, 6, 6, 6, 6 ,4, 3 } ,{ 4, 6, 8, 8, 8, 8, 6, 4 } ,{ 4, 6, 8, 8, 8, 8, 6, 4 } ,{ 4, 6, 8, 8, 8, 8, 6, 4 } ,{ 4, 6, 8, 8, 8, 8, 6, 4 } ,{ 3, 4, 6, 6, 6, 6, 4, 3 } ,{ 2, 3, 4, 4, 4, 4, 3, 2 }  };
    int N;
    cin >> N;
    string s;
    for(int i=0;i<N;i++){
       cin >> s;
       cout << v[s[0]-'a'][s[1]-'1'] << endl;
    }
    return 0;
}
