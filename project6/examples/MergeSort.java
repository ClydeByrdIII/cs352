class MergeSort{
    public static void main(String[] a){
  System.out.println(new MS().Sort(10));
    }
}

class MS {
  int[] numbers;
  int[] helper;
  int size ;
  public int Sort(int values) {

    int aux01 ;
    aux01 = this.Init(values);
    aux01 = this.Print();
    System.out.println(99999);
    aux01 = this.mergesort(0, size - 1);
    aux01 = this.Print();
    return 0 ;
  }

  public int mergesort(int low, int high) {
    // check if low is smaller then high, if not then the array is sorted
    int middle ;
    if (low < high) {
      // Get the index of the element which is in the middle
      
      middle = low + (high - low) / 2 ;
      // Sort the left side of the array
      this.mergesort(low, middle) ;
      // Sort the right side of the array
      this.mergesort(middle + 1, high) ;
      // Combine them both
      this.merge(low, middle, high) ;
    }
    return 0;
  }

  public int merge(int low, int middle, int high) {

    // Copy both parts into the helper array
    int x ;
    int i ;
    int j ;
    int k ;
    
    x = low ;
    
    while(x <= high) {
      helper[x] = numbers[x] ;
      x = x + 1 ;
    }

    i = low ;
    j = middle + 1 ;
    k = low ;
    // Copy the smallest values from either the left or the right side back
    // to the original array
    while (i <= middle && j <= high) {
      if (helper[i] <= helper[j]) {
        numbers[k] = helper[i] ;
        i = i + 1 ;
      } else {
        numbers[k] = helper[j] ;
        j = j + 1 ;
      }
      k = k + 1 ;
    }
    // Copy the rest of the left side of the array into the target array
    while (i <= middle) {
      numbers[k] = helper[i] ;
      k = k + 1 ;
      i = i + 1 ;
    }
    return 0;
  } 
  // Printing method
  public int Print(){
    int j ;
    j = 0 ;
    while (j < (size)) {
        System.out.println(numbers[j]);
        j = j + 1 ;
    }
    return 0 ;
  }

  public int Init(int sz){
    size = sz ;
    numbers = new int[sz] ;
    helper = new int[sz] ;

    numbers[0] = 20 ;
    numbers[1] = 7  ; 
    numbers[2] = 12 ;
    numbers[3] = 18 ;
    numbers[4] = 2  ; 
    numbers[5] = 11 ;
    numbers[6] = 6  ; 
    numbers[7] = 9  ; 
    numbers[8] = 19 ; 
    numbers[9] = 5  ;
    
    return 0 ;  
  }
}