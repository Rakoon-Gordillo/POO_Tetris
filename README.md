# Datos importantes
El archivo de Java de Proccessing con el Tetris se encuentra dentro de la carpeta *Tetris*, bajo el nombre de *Tetris.pde*.
# Autoría
 Repositorio y código desarrolado por **Juan Sebastián Gordillo, grupo 4** en **POO**
# Informe
## Pasos realizados para desarrollar este código
Para desarrollar este código, se empezó por diseñar el fondo y el diseño del tablero y la pantalla de instrucciones. Para poder escoger el tamaño del tablero y de la ventana, se calculo el espacio que ocuparía cada cuadro de cada ficha (```20x20```), el recuadro de *siguiente ficha* (```80x80```); así, se concluyó que un tamaño adecuado para la ventana era de (```340x440```):

+20 de espacio entre el borde de la ventana y el tablero, más
+200 de espacio del tablero para los 10 cuadros que podrían ir por fila, más
+20 en el espacio entre el tablero y el recuadro de  *siguiente ficha*, más
+80 de ancho que tiene el recuadro + 20 en el espacio entre el borde de la venta y el recuadro de siguiente ficha)

Luego de haber terminado, se tuvo en cuenta que cuando se empezara el juego tendría que verse desde que punto el tablero no podía recibir más fichas, por lo cual se optó por usar un recuadro con efecto de transición en la parte superior del tablero. Habiendo terminado, se empezó por escoger colores adecuados para las fichas