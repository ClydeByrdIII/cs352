class Simple3{
    public static void main(String[] a){
        System.out.println(new S().main());
    }
}

class S{
        int a;
//    int a2;
       int [] b1;

    public int main(){
        this.testVarDecl(1,2);
        this.testIf();
        this.testIf2();
        this.testIf3();
        this.members();
        this.block();
        this.objects();
        return 1;
    }

    public S objects(){
        int a; 
        int b;


        return new S();
    }

    public int block(){
        int a;
        int b;
        int c;
        {
            System.out.println(10);
            a = 10;
            if(a == 10)
                a = 9;
            System.out.println(a);
        }
        return 0;
    }

    public int members(){
        a = 1;
        System.out.println(a);
        this.a = 5;
        System.out.println(a);
        b1 = new int[10];
        System.out.println(b1[5]);
        b1[5] = 10;
        System.out.println(b1[5]);
        return 1;
    }

    public int testIf(){
        int a;
        int c;

       if( (a=c=8)==0 ){
            System.out.println(0);
       }
       else{
            System.out.println(1);
       }
       return 1;
    }

    public int testIf2(){
        int a;
        int c;
        a = 10;
        c = 1;
        a = a*c/a+c-5;
       System.out.println(a);
       a = 5+9/9*65-9+36*7/9;
       System.out.println(a);
       return 1;
    }

    public int testIf3(){
        int a;
        int b;
        int c;

        a = 0;
        if(a == 0){
            b = 10;
            if(b >= 10){
                c = 8;
                if(c == 8){
                    c = 10;
                    a = 1;
                    b = 0;
                    if(b == 0){
                        a = 40;
                        b = 10;
                        c = 0-10;
                    }
                }
            }
            else if(b >= 5){
                c = 7;
                a = 9;
            }
            else{
                b = 100;
            }
        }
        else{
            if(c > 10){
                c = 1000;
            }
            else if(a > 0){
                c = 8;
            }
            else{
                a = 0-1;
            }
        }
        System.out.println(a);
        System.out.println(b);
        System.out.println(c);
        return 10;
    }

    public int testIf4(){
        int a;
        int c;
        a = 10;
        c = 1;
        a = a*c/a+c-5;
       System.out.println(a);
       a = 5+9/9*65-9+36*7/9;
       System.out.println(a);
       return 1;
    }

    public int ok(int num){
   /*     S s;
        int a;
        int b;
        int c;
        s = new S();
        a = 1;
        b = 1;
        if((a=a-1) == 0){
            System.out.println(a);
            a = 5;
        }
        else{
            b = 10;
        }

        System.out.println(b);
        System.out.println(a);

        a = 0;
        b =0;
        if(a == 0){
            a = 5;
        }
        else{
            b = 10;
        }
        s.a = 10;
        System.out.println(s.a);
         System.out.println(b);
        System.out.println(a);*/
    return num;
   
    }



    public int testVarDecl(int a, int b){
        int a;
        int b;
        a = 15;
        b = 10;
        System.out.println(a);
        System.out.println(b);
        return 1;
    }

}

// This class contains an array of integers and
// methods to initialize, print and search the array
// using Binary Search

