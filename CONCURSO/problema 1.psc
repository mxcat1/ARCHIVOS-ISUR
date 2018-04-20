Algoritmo sin_titulo
	a=6
	b=0
	x=16
	conta=1
	ope=a
	cer=""
	res=""
	l=0
	c=1
	leer n1
	n=1
	g=1
	Repetir
		g=g+1
		n=n+g
		
	Hasta Que g=n1
	Repetir
		
		res=convertiratexto(ope)
		l=longitud(res)
		b=6-l
		c=1
		cer=""
//		Repetir
//			cer=cer+"0"
//			c=c+1
//		Hasta Que c>b
		Mientras c<b Hacer
			cer=cer+"0"
			c=c+1
		Fin Mientras
		 escribir cer+res
		a=a+16
		ope=ope+a
		conta=conta+1
	Hasta Que conta>n
	
FinAlgoritmo
