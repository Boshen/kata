import java.io.*;
import java.util.*;

public class P785{
    private static String foo(int x){
        if(x<5)return "few";
        if(x<10)return "several";
        if(x<20)return "pack";
        if(x<50)return "lots";
        if(x<100)return "horde";
        if(x<250)return "throng";
        if(x<500)return "swarm";
        if(x<1000)return "zounds";
        return "legion";
    }
    public static void main(String[] args){
        Scanner in = new Scanner(System.in);
        while(in.hasNext()){
            System.out.println( foo(in.nextInt()));
        }
    }
}
