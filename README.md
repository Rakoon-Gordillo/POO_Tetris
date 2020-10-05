# Datos importantes
El archivo de Java de Proccessing con el Tetris se encuentra dentro de la carpeta *Tetris*, bajo el nombre de *Tetris.pde*.
# Autoría
 Repositorio y código desarrolado por **Juan Sebastián Gordillo, grupo 4** en **POO**.
# Informe
## Pasos realizados para desarrollar este código
Para desarrollar este código, se empezó por diseñar el fondo y el diseño del tablero y la pantalla de instrucciones. Para poder escoger el tamaño del tablero y de la ventana, se calculo el espacio que ocuparía cada cuadro de cada ficha (```20x20```), el recuadro de *siguiente ficha* (```80x80```); así, se concluyó que un tamaño adecuado para la ventana era de (```340x440```).

Por parte del ancho:

+ 20 de espacio entre el borde de la ventana y el tablero, más
+ 200 de espacio del tablero para los 10 cuadros que podrían ir por fila, más
+ 20 en el espacio entre el tablero y el recuadro de  *siguiente ficha*, más
+ 80 de ancho que tiene el recuadro
+ 20 en el espacio entre el borde de la ventana y el recuadro de siguiente ficha.

Por parte del largo:

+ 20 de espacio entre el borde superior de la ventana y el tablero, más
+ 400 de espacio del tablero para los 20 cuadros que podrían ir por fila, más
+ 20 de espacio entre el borde inferior de la ventana y el tablero.

Luego de haber terminado, se tuvo en cuenta que cuando se empezara el juego tendría que verse desde que punto el tablero no podía recibir más fichas, por lo cual se optó por usar un recuadro con efecto de transición en la parte superior del tablero. Habiendo terminado, se empezó por escoger colores adecuados para las fichas de tal manera que no se confundiese con el fondo del tablero.
Luego de eso, se empezó a simular la aparición de los tetrominos en el tablero, para lo cual se asignó una variable ```start```, la cual determinaba si se estaba en la pantalla de instrucciones o se había pasado al juego. Así, para poder acomodar cada tetromino en el area de peligro (para que así no hubiese confusión), se optó por dar coordenadas al tetromino, de tal manera que, respecto a la posición de este se pudiera calcular su posición en el tablero respecto a la magnitud que adquiere cada cuadro en *x* y *y* y se pudieran dar los límites de movimiento de la ficha respecto al tablero, con lo que se llegó a la fórmula:

```
x = (coordenadas.get(i))*20
y = 21-coordenadas.get(i+1))*20, 20
```

Siendo ```coordenadas``` un arreglo dinámico con las coordenadas ```(x1,y1,x2,y2,x3,y3,x4,y4)``` (cada magnitud *x* y *y* de los 4 cuadros del tetromino) y ```i``` el número 0, 2, 4 o 6, según el cuadro
del tetromino que se esté manipulando.

Luego de eso se procedió con el movimiento de la pieza, con lo cual también se tuvo en cuenta que se debía tener en cuenta la posición de las otras fichas una vez que hubiesen caído. Así, se implemento un arreglo dinámico de 200 posiciones, para cada cuadro del tablero. Se pensó en cambiar el arreglo dinámico a uno estático, más sin embargo esto, consecuentemente, dificultaría más adelante la eliminación de filas.

Una vez implementado este arreglo, se  debía calcular la formula para detectar, a través de las coordenadas, en donde se ubicaba cada cuadro en el tablero, de tal manera que si se detectaba como ocupado se pudiese evitar mover la pieza a ese lugar. Empero, se debía tener en cuenta que:
1. El sistema de coordenadas venía dado con magnitudes de entre 1 y 10 para *x* y 1 y 20 para *y*
2. El arreglo del tablero implicaba posiciones de 0 a 199, según los índices para acceder a la información de cada cuadro: -1 representa un cuadro vacío, mientras que 0 a 6 representan el color para los tetrominos T, L, J, S, Z y columna.

Por ende, se formuló:

```
i = (y-1)*10+x-1
```
Siendo ```i``` la variable para el índice en el arreglo para el tablero y ```x``` y ```y``` las variables para las coordenadas *x* y *y* de cada cuadro del tetromino. A partir de eso se podía operar cada  coordenada respecto a los "cuadros ocupados" en el tablero.

De esta manera, también se implementó el giro para cada tetromino. Sin embargo, con fines de simplificación del código, se optó por no girar el tetromino, sino reubicar cada uno de sus cuadros, dando la impresión de girar. Por ejemplo: Para girar el tetromino J en coordenadas
1. (1,1)
2. (2,1)
3. (2,2)
4. (2,3)

a la posición ¬ se debían incrementar y reducir las magnitudes, de tal forma que quedase
1. (1,2)
2. (2,2)
3. (3,1)
4. (3,2)

Luego de eso, se implementó el concepto el concepto de filas eliminadas y su respectivo contador para la eliminación de estas: durante la impresión del tablero en la ventana se iba eliminando cada cuadro del tablero y agregando uno al final mientras que se recorría cada uno.

Aprovechando esto, se implementaron los niveles respecto a la eliminación de filas, quedando que:
1. Se toma nivel 1 cuando se han eliminado de 0 a 4 filas.
2. Se toma nivel 2 cuando se han eliminado de 5 a 14 filas.
3. Se toma nivel 3 cuando se han eliminado de 15 a 29 filas.
...
10. Se toma nivel 10 cuando se han eliminado de 225 filas al infinito.

Mientras más se aumentaba el nivel, más se reduce la cantidad de tiempo necesaria para que el tetromino baje.