import java.math.BigInteger;
import java.io.*;
import java.util.*;

public class P12{
    public static void main(String[] argv){
        Scanner in = new Scanner(System.in);
        int n = in.nextInt();
        int k = in.nextInt();
        BigInteger x = new BigInteger("" + (k-1));
        ArrayList<BigInteger> al = new ArrayList<BigInteger>(n+1);
        al.add(new BigInteger("1"));
        al.add(x);
        for(int i=2;i<=n;i++){
            al.add(i, x.multiply(al.get(i-1).add(al.get(i-2))));
        }
    System.out.println(al.get(n));
    }
}
