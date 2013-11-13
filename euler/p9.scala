println( (for(i<-1 until 1000;j<-1 until i;k<-1 to 1000-i-j;if(i*i+j*j==k*k&&i+j+k==1000))yield i*j*k).head )
