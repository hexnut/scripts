#include<stdio.h>

int Fibonacci(int n) {
   if (n == 0 || n == 1)
      return n;
   else
      return ( Fibonacci(n-1) + Fibonacci(n-2) );
} 

int main (int argc, char *argv[]) {
   int n, i = 0, c;

   if (argc > 1) {
     n = atoi(argv[1]);
   } else {
     printf("%s\n", "Usage: fib [int]");
      return(1);
   }
 
   printf("Fibonacci series\n");
 
   for ( c = 1 ; c <= n ; c++ ) {
      printf("%d\n", Fibonacci(i));
      i++; 
   }
 
   return 0;
}
