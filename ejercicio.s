.data
 /* Definicion de datos */

cartel: .asciz "\n _____________________\n|                     |\n|  Memotest - ORGA 1  |\n|_____________________|\n"
longitudcartel = . - cartel

array:  .asciz "   0 1 2 3 4 5 6 7 8 9 \n 0 ? ? ? ? ? ? ? ? ? ? \n 1 ? ? ? ? ? ? ? ? ? ? \n 2 ? ? ? ? ? ? ? ? ? ? \n 3 ? ? ? ? ? ? ? ? ? ? \n 4 ? ? ? ? ? ? ? ? ? ? \n 5 ? ? ? ? ? ? ? ? ? ? \n 6 ? ? ? ? ? ? ? ? ? ? \n 7 ? ? ? ? ? ? ? ? ? ? \n 8 ? ? ? ? ? ? ? ? ? ? \n 9 ? ? ? ? ? ? ? ? ? ? \n"
longitudarray = . - array

solucion:.asciz "   0 1 2 3 4 5 6 7 8 9 \n 0       !       #     \n 1     $       $       \n 2 %             >     \n 3     *   >       @   \n 4     @         -     \n 5 !         &     -   \n 6   *       +         \n 7           +         \n 8               #     \n 9       %       &     \n"
longitudsolucion = . - solucion

mensajeFila: .asciz "Ingrese el numero de la fila: "
longitudFila = . - mensajeFila

mensajeColumna: .asciz "Ingrese el numero de la columna: "
longitudColumna = . - mensajeColumna

mensajeVictoria: .asciz "GANASTE EL JUEGUITO"
longitudVictoria = . - mensajeVictoria

mensajeDerrota: .asciz "PERDISTE EL JUEGUITO"
longitudDerrota = . - mensajeDerrota

cantidaddeintentos: .asciz "\n Cantidad de intentos: "
longitudintentos = . - cantidaddeintentos

cantidaddeaciertos: .asciz "\n Cantidad de aciertos: "
longitudaciertos = . - cantidaddeaciertos

cantidaddevidas: .asciz "\n Cantidad de vidas: "
longitudvidas = . - cantidaddevidas

cantidaddeerrores: .asciz "\n Cantidad de errores: "
longituderrores = . - cantidaddeerrores

puntaje1:.asciz "0"

puntaje2:.asciz "0"

cls: .asciz "\x1b[H\x1b[2J"
lencls = . - cls

fila1:    .asciz " "
columna1: .asciz " "
fila2:.asciz " "
columna2: .asciz " "
aciertos:.asciz "0"
vidas: .asciz "15"
errores: .asciz "0"
Penter: .asciz " "
intentos: .asciz "0"
intentos10: .asciz "10"
intentos2:.asciz "0"
intentos102:.asciz "10"


array2:  .asciz "   0 1 2 3 4 5 6 7 8 9 \n 0 ? ? ? ? ? ? ? ? ? ? \n 1 ? ? ? ? ? ? ? ? ? ? \n 2 ? ? ? ? ? ? ? ? ? ? \n 3 ? ? ? ? ? ? ? ? ? ? \n 4 ? ? ? ? ? ? ? ? ? ? \n 5 ? ? ? ? ? ? ? ? ? ? \n 6 ? ? ? ? ? ? ? ? ? ? \n 7 ? ? ? ? ? ? ? ? ? ? \n 8 ? ? ? ? ? ? ? ? ? ? \n 9 ? ? ? ? ? ? ? ? ? ? \n"

solucion2:.asciz "   0 1 2 3 4 5 6 7 8 9 \n 0       %       &     \n 1     $       $       \n 2     @         -     \n 3 !         &     -   \n 4 %             >     \n 5     *   >       @   \n 6           +         \n 7   *       +         \n 8 #                   \n 9       !       #     \n"

solucion3:.asciz "   0 1 2 3 4 5 6 7 8 9 \n 0           $         \n 1     &         %     \n 2     @         -     \n 3 !     $   %     -   \n 4 @                   \n 5     !   >       @   \n 6           +         \n 7   *       +         \n 8         > #         \n 9       * &     #     \n"

mensajeVictoria2: .asciz "\n\nSi quieres volver a jugar ingrese un 1 en caso contrario ingrese un 0\n"
longitudVictoria2 = . - mensajeVictoria2

pregunta: .asciz "\n¿Cuando cayo el muro de Berlin?\n"
longitudpregunta = . - pregunta

vidas2: .asciz "15"

errores2: .asciz "0"

aciertos2: .asciz "0"

enter: .asciz "\n Presione Enter para continuar\n"
longitudenter = . - enter

volverajugar: .asciz "0"
respuestacorrecta: .asciz "1989"
respuestacercana: .asciz "1900"
respuesta: .asciz " "
juegos: .asciz "0"

felicitaciones: .asciz "\n\nFelicidades Mejoraste"
longitudfelicitaciones = . - felicitaciones

.text    // Defincion de codigo del programa

imprimirString:
 //Parametros inputs:
 //r1=puntero al string que queremos imprimir
 //r2=longitud de lo que queremos imprimir
	.fnstart
     		mov r7, #4		// Salida por pantalla
 		mov r0, #1    	 	// Indicamos a SWI que sera una cadena
  		push {lr}
		swi 0   		// SWI, Software interrup
     		pop {lr}
		bx lr			// salimos de la funcion mifuncion
        .fnend

pedirInput:
	.fnstart
		mov r7, #3	     	// Indicamos lectura por teclado
		mov r0, #0      	// Indicamos que el ingreso será una cadena
		mov r2, #6	     	// Leer #1 caracter
		mov r1, r3
		push {lr}		// Pusheo el registro lr ya que la interrupcion posterior puede cambiarme el r14
		swi 0			// Llamamos a la interrupción
		pop {lr}		// Vuelvo a traer el anterior registro lr
		bx lr
	.fnend

obtengoLetra:
	.fnstart
	   ldrb r1, [r0, r1]	// r0 es la direccion de memoria de la palabra y r1 es el puntero..
	bx lr
	.fnend

recorrer:
	.fnstart
		sub r1, r1, #0x30	// un numero ascii menos 0x30 te da el numero en hexadecimal
		sub r2, r2, #0x30
		mov r3, #0x18		// la cantidad de elementos en una fila en hexadecimal
		mul r0, r1, r3   	// siendo r1 el numero de fila
		push {r3}	 	// pusheo r3, por buenas practicas.
		mov r3, #0x2		// sumo de a 2 en el puntero porque hay un espacio entre simbolos
		mul r1, r2, r3  	// siendo r2 el numero de columna
		add r1, r1, #3  	// le sumo 4 al calculo de columna
		add r1, r1, r0  	// sumo el calculo de fila mas el de columna
		pop {r3}		// Vuelvo a traer r3
		add r1, r1, r3  	// para descontar la primera escalera de nros
		bx lr
	.fnend

controlar_aciertos:
	.fnstart
		ldr r3, =aciertos
		push {r1}
		push {r2}
		cmp r1, #0x20		// comparo el primer simbolo con un espacio
		mov r1, r4
		mov r2, r5
		beq controlar_errores	// salto a perder una vida
		pop {r2}
		pop {r1}
		ldrb r2, [r3]		// extraigo los datos almacenados en la direccion de memoria y guardo en r2
		cmp r2, #0x39		// si es 9 al sumarle 1 acierto vas a ganar
		beq ganaste		// salto a ganaste
		add r2, r2, #0x1	// sumo 1 a los datos en memoria
		strb r2, [r3]		// guardo los puntos actualizados
		push {r1}
		push {r2}
		mov r1, r4		// traigo primer puntero para utilizarlo
		mov r2, r5		// traigo segundo puntero para utilizarlo
		ldr r0, = solucion
                mov r3, #0x20		// almaceno el espacio en el array solucion para que no puedas elegir siempre los mismos simbolos y sumar aciertos
                strb r3, [r0,r1]
                strb r3, [r0,r2]
		pop {r2}
		pop {r1}
		b controldevidas
	.fnend

controlar_intentos:
	.fnstart
		ldr r1, =intentos
		ldrb r2, [r1]
		cmp r2, #0x39					//comparo los intentos con 9 para saber si tengo que comenzar a imprimir los intentos mayores a 10
		beq controlar_intentos_mayores_a_10
		add r2, r2, #0x1				// sumo intento
		strb r2, [r1]					// lo cargo en la memoria
		ldr r1, = cantidaddeintentos
                ldr r2, = longitudintentos
                push {lr}
                bl imprimirString				// imprimo mensaje previo a intentos
		ldr r1, = intentos
		mov r2, #1
		bl imprimirString				// imprimo los intentos
		pop {lr}
		bx lr
	.fnend
controlar_intentos_mayores_a_10:
	.fnstart
		ldr r1, = cantidaddeintentos
		ldr r2, = longitudintentos
		push {lr}
		bl imprimirString				// imprimo mensaje previo a intentos
		ldr r1, = intentos10
		mov r2, #2
		bl imprimirString				// imprimo los intentos mayores a 10
		ldr r1, =intentos10
                add r1, r1, #0x1				// sumo 1 byte a la dirección de memoria para variar las unidades
                ldrb r2, [r1]
                add r2, r2, #0x1				// sumo intento mayor a 10
                strb r2, [r1]					// cargo a la memoria
		pop {lr}
		bx lr
	.fnend

controlar_vidas:
	.fnstart
		ldr r1, =vidas          			// almaceno direccion de memoria donde tengo la cadena de vida
		add r1, r1, #0x1				// sumo una posicion en la memoria
		ldrb r2, [r1]           			// extraigo el byte almacenado en la direccion de memoria y guardo en r2
		cmp r2, #0x31					// comparo vidas con distancia
		blt controlar_vidas_menores_a_10		// salto
		sub r2, r2, #0x1        			// resto 1 a los datos en memoria
                strb r2, [r1]
		bx lr
	.fnend


controlar_vidas_menores_a_10:
	.fnstart
                push {lr}                                       // pusheo registro de retorno porque pienso utilizar funciones
		ldr r1, =vidas         			    	// almaceno direccion de memoria donde tengo la cadena de puntos
                ldrb r2, [r1]					// almaceno los datos de r1 en r2
		cmp r2, #0x31					// comparo las vidas con 1 porque cuando paso a este bit que almacena las decenas este comienza en 1 y quiero convertirlo en 9 para seguir restando
		bleq vidas_9					// salto a la funcion vidas_9
		cmp r2, #0x32					// comparo las vidas con 2 para saltarme el 1 ya que en caso de darle este valor subiría a 9 por la comparación anterior
		bleq vidas_2					// salto a vidas_2
                pop {lr}                                        // popeo el registro de retorno para poder salir de la funcion correctamente
		cmp r2, #0x30					// comparo vidas con 0 para saber si el usuario perdió
		beq perdiste					// salto a imprimir perdida y fin de juego
		sub r2, r2, #0x1				// resto una vida
		cmp r2, #0x30					// comparo con 0 luego de haber restado 2 vidas para saltarme el ciclo de 1 que vuelve a 9
		beq vida_1					// esto quiere decir que nos queda 1 vida
		strh r2, [r1]					// guardar las vidas restantes
		bx lr
	.fnend

vidas_9:
	.fnstart
		add r2, r2, #0x9				// reemplazamos las vidas en nueve luego de terminar las decenas, ya que el valor de la decena está en 1
		bx lr
	.fnend

vidas_2:
	.fnstart
		sub r2, r2, #0x1				// cuando vidas es igual a 2 voy a restarle 1 para saltarme la condicion de vidas igual 1 que me reemplaza por 9
		bx lr
	.fnend

vida_1:
	.fnstart
		add r2, r2, #0x1				// sumo 1 ya que al entrar en vidas_1 mis vidas realmente estan seteadas en 0 y quiero imprimir 1 vida restante
		strh r2, [r1]					// cargo la vida en vidas
		ldr r1, =cantidaddeaciertos
		ldr r2, =longitudaciertos
		bl imprimirString				// imprimo mensaje previo a aciertos
		ldr r1, =aciertos
		mov r2, #1
		bl imprimirString				// imprimo aciertos
		ldr r1, =cantidaddevidas
		ldr r2, =longitudvidas
		bl imprimirString				// imprimo mensaje previo a vidas
		ldr r1, =vidas
		mov r2, #1
		bl imprimirString				// imprimo vidas
		ldrb r3, [r1]					// cargo los datos de las vidas en registro
		sub r3, r3, #0x1				// resto una vida
		strh r3, [r1]					// cargo los datos en las vidas
		b error						// vuelvo a comenzar el ciclo de la ultima vida
	.fnend

controlar_errores:
	.fnstart
		push {r0}
		push {r3}
		ldr r0, =errores
		ldrb r3, [r0]
		add r3, r3, #0x1				// si son diferentes los 2 simbolos suma un error
		strb r3, [r0]					// storeo para imprimirlo
		cmp r3, #0x36					// comparo con 6 porque aceptamos hasta 5 errores
		beq perdiste
		ldr r0, = array
		mov r3, #0x3f					// almaceno el signo de pregunta
		strb r3, [r0,r1]				// volteo nuevamente los simbolos ya que dio error
		strb r3, [r0,r2]				// idem

		pop {r3}
		pop {r0}

		b controldevidas
	.fnend

clearScreen:
	.fnstart
		mov r0, #1
		ldr r1, =cls
		ldr r2, =lencls
		mov r7, #4
		swi #0						// interrupcion para limpiar pantalla

		bx lr
	.fnend

guardarpuntaje1:
	.fnstart
		push {r1}
		ldr r0, =puntaje1
		ldr r1, =errores
		ldrb r2, [r1]
		str r2, [r0]					// guardo los errores como puntaje
		pop {r1}
		bx lr
	.fnend

felicitar:
	.fnstart
		ldr r0, =puntaje1
		ldrb r1, [r0]
		ldr r2, =errores
		ldrb r3, [r2]
		cmp r1, r3					// comparo errores de la primera jugada con la segunda para saber si mejoramos
		bgt felicitamos
		bx lr
	.fnend



.global main
main:
	bl clearScreen
       	b sinsolucion

juegonuevo:

	ldr r1, =solucion		// guardo en r1 la direccion de memoria de solucion
        ldr r2, =solucion2		// para poder sustituir 1 a 1 los datos de la memoria

ciclocargasolucion:

	add r1, r1, #1			// sumo 1 a la direccion de memoria para recorrerla con el puntero
	add r2, r2, #1			// recorro el segundo array con el cual voy a sustituir el array principal
        ldrb r3, [r2]			// cargo los datos del segundo array
        strb r3, [r1]			// reescribo el array principal con los datos del segundo array
	cmp r3, #0			// comparo el dato del array con 0 para saber cuando terminamos de recorrer
	bgt ciclocargasolucion		// mientras no termine de recorrer vuelvo a ejecutar el ciclo
cargoarraynuevo:
	ldr r1, = array			// ahora cargo la direccion de memoria del array sobre el que jugamos
	ldr r2, = array2		// cargo la direccion de memoria del array para que no tenga simbolos volteados
ciclocargaarray:
	add r1, r1, #1
	add r2, r2, #1
	ldrb r3, [r2]
        strb r3, [r1]
        cmp r3, #0
        bgt ciclocargaarray		// idem solucion

	ldr r1, =aciertos
        ldr r2, =aciertos2
        ldr r3, [r2]
        str r3, [r1]			// recargamos memoria en 0 para resetear el juego

	ldr r1, =vidas
        ldr r2, =vidas2
        ldr r3, [r2]
        str r3, [r1]			// recargamos memoria en 15 para resetear el juego

	ldr r1, =errores
        ldr r2, =errores2
        ldr r3, [r2]
        str r3, [r1]			// recargamos memoria en 0 para resetear el juego

	ldr r1, =intentos
        ldr r2, =intentos2
        ldr r3, [r2]
        str r3, [r1]			// recargamos memoria en 0 para resetear el juego

        ldr r1, =intentos10
        ldr r2, =intentos102
        ldr r3, [r2]
        str r3, [r1]			// recargamos memoria en 10 para resetear el juego

	b sinsolucion			// comenzamos el juego

juegonuevo2:
        ldr r1, =solucion
        ldr r2, =solucion3		// idem anterior pero cargamos nuevo array solucion distinto al anterior

ciclocargasolucion2:


        add r1, r1, #1
        add r2, r2, #1
        ldrb r3, [r2]
        strb r3, [r1]
        cmp r3, #0
        bgt ciclocargasolucion2
cargoarraynuevo2:
        ldr r1, = array
        ldr r2, = array2
ciclocargaarray2:
        add r1, r1, #1
        add r2, r2, #1
        ldrb r3, [r2]
        strb r3, [r1]
        cmp r3, #0
        bgt ciclocargaarray2

	ldr r1, =aciertos
        ldr r2, =aciertos2
        ldr r3, [r2]
        str r3, [r1]                    // recargamos memoria en 0 para resetear el juego

        ldr r1, =vidas
        ldr r2, =vidas2
        ldr r3, [r2]
        str r3, [r1]                    // recargamos memoria en 15 para resetear el juego

        ldr r1, =errores
        ldr r2, =errores2
        ldr r3, [r2]
        str r3, [r1]                    // recargamos memoria en 0 para resetear el juego

        ldr r1, =intentos
        ldr r2, =intentos2
        ldr r3, [r2]
        str r3, [r1]                    // recargamos memoria en 0 para resetear el juego

        ldr r1, =intentos10
        ldr r2, =intentos102
        ldr r3, [r2]
        str r3, [r1]                    // recargamos memoria en 10 para resetear el juego


sinsolucion:


 //llamamos a la subrutina para imprimir el cartel

        ldr r1, =cartel 			// Cargamos en r1 la direccion del mensaje
        ldr r2, =longitudcartel		//Tamaño de la cadena
        bl  imprimirString

 //llamamos a la subrutina para imprimir los simbolos
matriz:
        ldr r1, =array 			// Cargamos en r1 la direccion del mensaje
        ldr r2, =longitudarray		//Tamaño de la cadena
        bl  imprimirString

//llamamos a la subrutina para pedir la primer fila

	ldr r1, =mensajeFila          		// Cargamos en r1 la direccion del mensaje
        ldr r2, =longitudFila         		//Tamaño de la cadena
        bl  imprimirString

	ldr r3, =fila1
	bl pedirInput
	ldrb r1, [r1]
	push {r1}		 		//pusheo para poder utilizarlo posteriormente

//llamamos a la subrutina para pedir la primer columna

        ldr r1, =mensajeColumna         	// Cargamos en r1 la direccion del mensaje
        ldr r2, =longitudColumna        	// Tamaño de la cadena
        bl  imprimirString

	ldr r3, =columna1
        bl pedirInput				// obtenemos direccion de la cadena ingresada en r1
        ldrb r2, [r1]				// obtenemos el dato de la cadena almacenada

// Recorremos las cadenas

	pop {r1}				// me vuelvo a traer el numero de fila
	bl recorrer				// llamo a la subrutina para realizar el algoritmo para recorrer nuestra cadena
	mov r4, r1				// guardamos puntero
	push {r4}
	ldr r0,=solucion


	bl obtengoLetra				// obtenemos el primer simbolo en r1
	push {r1}				// guardamos simbolo en la pila para su uso futuro
        ldr r2, = array
        strb r1, [r2, r4]               	// almacenar el simbolo en el array de signos de pregunta
        ldr r1, = array
        ldr r2, = longitudarray
        bl imprimirString			// imprimimos array con simbolo volteados


//llamamos a la subrutina para pedir la segunda fila
	ldr r1, = enter
        ldr r2, = longitudenter
        bl imprimirString			// imprimimos mensaje de presionar enter para detener la ejecucion antes de refrescar la pantalla
        ldr r3, = Penter
        bl pedirInput				// pedimos input para continuar ejecución
        bl clearScreen				// limpiamos pantalla

        ldr r1, =mensajeFila          		// Cargamos en r1 la direccion del mensaje
        ldr r2, =longitudFila        		// Tamaño de la cadena
        bl  imprimirString			// imprimimos mensaje previo al input de fila


        ldr r3, =fila2				// guardamos direccion de memoria en la cual vamos a guardar el input
        bl pedirInput				// guardamos direccion de memoria de la cadena ingresada en r1
        ldrb r1, [r1]				// almaceno el dato ingresado en r1
        push {r1}       			// pusheo para poder utilizarlo posteriormente

//llamamos a la subrutina para pedir la segunda columna

	ldr r1, =mensajeColumna         	// Cargamos en r1 la direccion del mensaje
        ldr r2, =longitudColumna        	// Tamaño de la cadena
        bl  imprimirString			// imprimo mensaje previo al input de columna

        ldr r3, =columna2			// guardamos direccion de memoria en la cual vamos a guardar el input
        bl pedirInput				// guardamos direccion de memoria de la cadena ingresada en r1
        ldrb r2, [r1]				// almaceno el dato ingresado en r2

// Recorremos las cadenas

        pop {r1}        			// me vuelvo a traer el numero de fila
        bl recorrer     			// llamo a la subrutina para realizar el algoritmo para recorrer nuestra cadena
	mov r5, r1				// guardo el puntero para su uso posterior
	cmp r4, r5				// comparo
	beq controlar_errores			// vuelve a pedir inputs porque inserto 2 veces la misma posicion
        ldr r0,=solucion

        bl obtengoLetra				// obtengo segundo simbolo en r1
	push {r1}				// guardamos el simbolo en la pila para su uso futuro
	ldr r2, = array
	strb r1, [r2, r5]			// almacenar el simbolo en el array de signos de pregunta
	ldr r1, = array
	ldr r2, = longitudarray
	bl imprimirString			// imprimimos array con simbolos seleccionados volteados
	ldr r1, = enter
	ldr r2, = longitudenter
	bl imprimirString			// imprimimos mensaje de enter para detener la limpieza de pantalla
	ldr r3, = Penter
	bl pedirInput				// al presionar enter continuamos
	bl clearScreen				// limpiamos pantalla
	pop {r1}
        pop {r2}         			// traigo el primer simbolo guardado
	cmp r2, r1       			// comparo si el primer simbolo es igual que el segundo
	beq controlar_aciertos			// si son iguales y no son 2 espacios me va a sumar un acierto, si son 2 espacios me saltara a control de errores
	mov r1, r4				// traigo primer puntero
	mov r2, r5				// traigo segundo puntero para utilizar la función
	b controlar_errores			// si no son iguales voy a sumar un error
controldevidas:
	bl controlar_intentos
	bl controlar_vidas

//imprimir puntaje
	mov r7, #4
	mov r0, #1
	ldr r2, =longitudaciertos
	ldr r1, =cantidaddeaciertos
	swi 0					// imprimimos mensaje previo a los aciertos

        mov r7, #4	       			// Indicamos salida por pantalla
        mov r0, #1       			// Indicamos que la salida es una cadena
        mov r2, #1      			// Tamaño de la cadena
        ldr r1, =aciertos 			// Ubicación de la cadena
        swi 0            			// Llamamos a la interrupción

//imprimir vidas
	mov r7, #4
        mov r0, #1
        ldr r2, =longitudvidas
        ldr r1, =cantidaddevidas
        swi 0					// imprimimos mensaje previo a las vidas

        mov r7, #4       			// Indicamos salida por pantalla
        mov r0, #1       			// Indicamos que la salida es una cadena
        mov r2, #2      			// Tamaño de la cadena
        ldr r1, =vidas  			// Ubicación de la cadena
        swi 0            			// Llamamos a la interrupción

//imprimir errores
error:
	mov r7, #4
        mov r0, #1
        ldr r2, =longituderrores
        ldr r1, =cantidaddeerrores
        swi 0					// imprimimos mensaje previo a los errores

        mov r7, #4                      	// Indicamos salida por pantalla
        mov r0, #1                      	// Indicamos que la salida es una cadena
        mov r2, #2                      	// Tamaño de la cadena
        ldr r1, =errores                	// Ubicación de la cadena
        swi 0                           	// Llamamos a la interrupción

	b sinsolucion				// proximo intento

ganaste:
	ldr r1, = mensajeVictoria              // Cargamos en r1 la direccion del mensaje
        ldr r2, = longitudVictoria             // Tamaño de la cadena
        bl  imprimirString                      // imprimimos felicitaciones por ganar
	ldr r0, = juegos
	ldrb r1, [r0]
	add r1, r1, #1				// aumentamos valor de la bandera
	str r1, [r0]				// almacenamos
	cmp r1, #0x31				// comparamos la bandera con 1 para saber si nos encontramos en la primera jugada
	bleq guardarpuntaje1
	cmp r1, #0x32				// comparamos la bandera con 2 para saber si nos encontramos en la segunda jugada
	bleq felicitar
	ldr r1, = mensajeVictoria2		// Cargamos en r1 la direccion del mensaje
        ldr r2, = longitudVictoria2		// Tamaño de la cadena
        bl  imprimirString			// imprimimos pregunta para volver a jugar
	ldr r3, = volverajugar
        bl pedirInput				// guardamos direccion de la cadena en r1
	ldrb r1, [r1]				// obtenemos dato ingresado
        cmp r1, #0x31				// comparamos con 1 para volver a jugar
        beq juegonuevo
	b fin					// en caso de ser diferente de 1 acaba el juego

perdiste:
	ldr r0, = array
        mov r3, #0x3f                                   // almaceno el signo de pregunta
        strb r3, [r0,r1]                                // volteo nuevamente los simbolos ya que dio err$
        strb r3, [r0,r2]                                // idem
	ldr r1, = mensajeDerrota
	ldr r2, = longitudDerrota
	bl imprimirString
	bl guardarpuntaje1			// guardamos errores en direccion de puntaje1
	ldr r0, = juegos
	ldrb r1, [r0]
	add r1, r1, #1				// aumentamos valor de la bandera
	str r1, [r0]				// almacenamos
	cmp r1, #0x32				// si la bandera es 2 sabemos q nos encontramos en el final de la segunda jugada
	beq preguntareintentar			// en este caso hay que hacerle una pregunta comodin al jugador
	cmp r1, #0x32
	bgt fin					// si la bandera es mayor a 2 acabo el juego ya que no hay mas de 3 jugadas
	ldr r1, = mensajeVictoria2
	ldr r2, = longitudVictoria2
	bl imprimirString			// imprimimos mensaje de opcion de volver a jugar
	ldr r3, = volverajugar
	bl pedirInput
	ldrb r1, [r1]
	cmp r1, #0x31				// en caso del jugador ingresar 1 volvera a jugar
	beq juegonuevo
	b fin					// en caso contrario acabo el juego

preguntareintentar:
	ldr r1, = pregunta
	ldr r2, = longitudpregunta
	bl imprimirString			// imprimimos pregunta comodin
	ldr r3, = respuesta
	bl pedirInput				// guardamos direccion de la cadena en r1
	ldr r2, [r1]				// obtenemos la respuesta ingresada por el jugador en r1
	ldr r0, =respuestacorrecta
	ldr r3, [r0]				// obtenemos respuesta correcta para comparar con lo que ingreso el jugador
	cmp r2, r3
	beq ganaste				// vemos si contesto correctamente
	ldr r0, = respuestacercana
	ldrh r1, [r1]
	ldrh r2, [r0]
	cmp r1, r2
	beq sumamosvida
	b fin					// en caso de contestar mal acabo el juego

sumamosvida:
	ldr r0, =errores
	ldrb r1, [r0]
	sub r1, r1, #0x1
	strb r1, [r0]
	b sinsolucion
felicitamos:
	ldr r1, =felicitaciones
	ldr r2, =longitudfelicitaciones
	bl imprimirString
	bl pedirInput				// felicitamos haber mejorado la puntuacion

fin:
	mov r7, #1 				// Salida al sistema
	swi 0

