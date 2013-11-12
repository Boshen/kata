#include <iostream>

using namespace std;
void rot(int grid[4][4]){
    int grid2[4][4];
    for(int i=0;i<4;i++)
        for(int j=0;j<4;j++)
            grid2[i][j]=grid[i][j];

    int m=0,n=0;
    for(int i=0;i<4;i++){
        n=0;
        for(int j=3;j>=0;j--){
            grid[m][n]=grid2[j][i];
            n++;
        }
        m++;
    }
}

int main(){
    int grid[4][4];
    char c;
    for(int i=0;i<4;i++){
        for(int j=0;j<4;j++){
            cin >> c;
            grid[i][j] = (c=='X'?1:0);
        }
    }
    char pw[4][4];
    for(int i=0;i<4;i++){
        for(int j=0;j<4;j++){
            cin >> c;
            pw[i][j] = c;
        }
    }

    for(int k=0;k<4;k++){
        for(int i=0;i<4;i++){
            for(int j=0;j<4;j++){
                if(grid[i][j]==1){
                    cout << pw[i][j];
                }
            }
        }
        rot(grid);
    }
    cout << endl;

    return 0;
}
