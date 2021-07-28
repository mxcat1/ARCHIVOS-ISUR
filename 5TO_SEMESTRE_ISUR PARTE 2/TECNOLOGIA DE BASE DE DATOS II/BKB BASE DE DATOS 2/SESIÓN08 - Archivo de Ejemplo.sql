/*
FUNCIONES:
Devuelven una respuesta
    - ESCALAR
    - Tabla (TVF)
	   - Inline
	   - MultiStatement

- Buit-In
- User Defined Functions (UDF)

- RECURSIVIDAD / RECURSIÓN
    - Factorial
	   1! = 1			     = 1
	   2! = 1*2		     = 1! * 2
	   3! = 1*2*3		     = 2! * 3
	   4! = 1*2*3*4	     = 3! * 4
	   5! = 1*2*3*4*5	     = 4! * 5
	   6! = 1*2*3*4*5*6	     = 5! * 6
	   7! = 1*2*3*4*5*6*7    = 6! * 7
	   8! = 1*2*3*4*5*6*7*8  = 7! * 8
    - Fibonacci
	   0, 1, 1, 2, 3, 5, 8, 13, 21, 34.......
	   1  2  3  4  5  6  7.....
*/
Alter Function Factorial
    (@N as int)
Returns BigInt
As
Begin
    Declare @RF BigInt
    If @N=1
    Begin
	   Set @RF = 1
    End
    Else
    Begin
        Set @RF = dbo.Factorial(@N-1) * @N
    End
    Return @RF
End

Select dbo.Factorial(8)

Alter Function Fibonacci
    (@N As Int)
Returns Varchar(MAX)
As
Begin
    Declare @Rpta As Varchar(MAX) = '',
		  @A As VarChar(Max),
		  @B As VarChar(Max),
		  @NumA As Int,
		  @NumB As Int
    If @N<1
	   Set @Rpta = ''
    Else
	   If @N = 1
		  Set @Rpta = '0'
	   Else
		  If @N = 2
			 Set @Rpta = dbo.Fibonacci(@N-1) + ', 1'
		  Else
		  Begin
			 Set @A = dbo.Fibonacci(@N-2)
			 Set @B = dbo.Fibonacci(@N-1)
			 Set @NumA = Right(@A, CharIndex(',', Reverse(' ,' + @A))-1)
			 Set @NumB = Right(@B, CharIndex(',', Reverse(' ,' + @B))-1)
			 Set @Rpta = dbo.Fibonacci(@N-1) + ', ' + Convert(Varchar(5), (@NumA + @NumB))
		  End
    Return @Rpta
End
Go
Select dbo.Fibonacci(14)