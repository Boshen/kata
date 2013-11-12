#include <iostream>
#include <cmath>
#include <vector>

using namespace std;
double dist(double x1,double x2,double y1,double y2){
    double d1=abs(x1-x2);
    double d2=abs(y1-y2);
    if(d1==0)
        return (d2);
    else if(d2==0)
        return (d1);
    else
        return sqrt(d1*d1 + d2*d2);
}
int main(){
    int N;
    double R;
    cin >> N;
    cin >> R;
    vector<vector<double> > v(N,vector<double>(2));

    double len=0;
    for(int i=0;i<N;i++){
        cin >> v[i][0];
        cin >> v[i][1];
    }
    for(int i=1;i<N;i++){
        len += dist(v[i][0],v[i-1][0],v[i][1],v[i-1][1]);
    }
        len += dist(v[0][0],v[N-1][0],v[0][1],v[N-1][1]);
    cout.setf(ios::fixed);  
    cout.precision(2);
    cout << (N==1?0:len)+2*3.14159*R << endl;

    return 0;
}
