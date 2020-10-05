boolean pausa = false; //booleano que determina si el juego está en pausa
boolean rotado = false; //booleano que determina si una ficha se pudo rotar
int filaCompleta; //entero que cuando detecta 10 cuadros (una fila) elimina esa línea
int fichaActiva = -1; //determina la ficha en movimiento
int siguienteFicha = int(random(7)); //determina la siguiente ficha que entrará en juego
int prevfichaCode = -1; //variable para determinar el estado anterior de una ficha
int fichaCode; //código del estado de una ficha
int filasEliminadas; //marca la cantidad de líneas eliminadas
int nivel = 1; //nivel en el que se encuentra el jugador
int start = 0; //determina el estado del juego (0 = pantalla de inicio, 1 = jugando, 2 = pantalla de perdida)
int tiempo = 0; //variable del tiempo
int ultimo = 70-nivel*5; //variable que determina el tiempo para que la ficha baje
int [][][][]datos={{{{0, 255, 0}, {250, 100}, {270, 100}, {270, 120}, {290, 100}}, {{255, 120, 0}, {260, 90}, {260, 110}, {260, 130}, {280, 130}}, {{51, 51, 255}, {280, 90}, {280, 110}, {260, 130}, {280, 130}}, {{255, 255, 0}, {250, 120}, {270, 100}, {270, 120}, {290, 100}}, {{255, 0, 120}, {250, 100}, {270, 100}, {270, 120}, {290, 120}}, {{0, 255, 255}, {270, 140}, {270, 120}, {270, 100}, {270, 80}}, {{255, 255, 255}, {280, 120}, {260, 120}, {280, 100}, {260, 100}}}, {{{5, 18, 6, 17, 6, 18, 7, 18}, {5, 18, 6, 17, 6, 18, 6, 19}, {5, 17, 6, 17, 6, 18, 7, 17}, {5, 17, 5, 18, 5, 19, 6, 18}, {5, 17, 5, 18, 5, 19, 6, 17}, {5, 17, 5, 18, 6, 18, 7, 18}, {5, 19, 6, 17, 6, 18, 6, 19}, {5, 17, 6, 17, 7, 17, 7, 18}, {5, 17, 6, 17, 6, 18, 6, 19}, {5, 17, 5, 18, 6, 17, 7, 17}, {5, 17, 5, 18, 5, 19, 6, 19}, {5, 18, 6, 18, 7, 17, 7, 18}, {5, 17, 6, 17, 6, 18, 7, 18}, {5, 18, 5, 19, 6, 17, 6, 18}, {5, 18, 6, 17, 6, 18, 7, 17}, {5, 17, 5, 18, 6, 18, 6, 19}, {5, 17, 5, 18, 5, 19, 5, 20}, {4, 18, 5, 18, 6, 18, 7, 18}, {5, 17, 5, 18, 6, 17, 6, 18}}}};
IntList coordenadas; //Variable para arreglo dinámico para las coordenadas de la ficha
IntList cuadros; //Variable para arreglo dinámico para cada cuadro del tablero
void setup() {
  size(340, 440); //inicializa interfaz
  cuadros = new IntList(); //Genera un arreglo dinámico de enteros (tablero)
  coordenadas = new IntList(); //Genera un arreglo dinámico de enteros (ficha)
  for (int i = 0; i < 200; i++) { //Bucle de 200 veces
    cuadros.append(-1); //Agrega 200 veces -1 al arreglo del tablero (-1 es un cuadro vacío)
  }
}
void draw() {
  background(0, 0, 100);
  strokeWeight(3); //estilo tablero
  stroke(255, 0, 0); //color bordes tablero, s.f y fichas
  fill(0, 0, 150); //fondo tablero
  rect(20, 20, 200, 400); //tablero
  fill(0); //estilo recuadro
  square(240, 80, 80); //Siguiente ficha
  fill(255, 0, 0); //color letra
  textSize(20); //tamaño texto S.F.
  text("Siguiente", 240, 40);
  text("ficha", 240, 60);
  text("Filas", 240, 200);
  text("quitadas:", 240, 220);
  text(filasEliminadas, 240, 250);
  text("Nivel:", 240, 290);
  if (filasEliminadas<230) { //de ser falsa, el nivel es 10
    nivel = int(0.5+sqrt(0.4*float(filasEliminadas)+0.25)); //determina el nivel respecto a la cantidad de filas eliminadas
    ultimo = 70-nivel*5; //determina la velocidad a la que bajan las fichas respecto al nivel
  }
  text(nivel, 240, 320);
  strokeWeight(1); //borde tetrominos
  pushStyle();
  if (!pausa) { //muestra, si el juego no está pausado, la siguiente ficha
    fill(datos[0][siguienteFicha][0][0], datos[0][siguienteFicha][0][1], datos[0][siguienteFicha][0][2]);
    for (int i=1; i<5; i++) {
      square(datos[0][siguienteFicha][i][0], datos[0][siguienteFicha][i][1], 20);
    }
  }
  popStyle();
  if (start < 1) { //instrucciones
    fill(255); //relleno blanco - tetromino cuadrado
    square(120, 130, 20);
    square(120, 150, 20);
    square(100, 150, 20);
    square(100, 130, 20);
    stroke(255); //línea blanca - señalización
    noFill(); //retiro relleno para flechas de giro
    arc(120, 150, 70, 60, 0, QUARTER_PI);
    arc(120, 150, 70, 60, HALF_PI+QUARTER_PI, PI+QUARTER_PI);
    arc(120, 150, 70, 60, PI+HALF_PI+QUARTER_PI, 2*PI);
    fill(255); //relleno blanco
    pushStyle();
    triangle(90, 171, 95, 166, 95, 171); //flecha giro izquierda
    triangle(144, 171, 144, 166, 149, 171); //flecha giro derecha
    triangle(30, 150, 40, 140, 40, 160); //flecha izquierda
    triangle(210, 150, 200, 140, 200, 160); //flecha derecha
    triangle(110, 175, 120, 185, 130, 175); //flecha abajo
    triangle(110, 240, 120, 250, 130, 240); //flecha bien abajo 1
    triangle(110, 250, 120, 260, 130, 250); //flecha bien abajo 2
    rect(110, 260, 20, 5);//línea bien abajo
    text("Q", 65, 157);
    text("A", 45, 157);
    text("E", 160, 158);
    text("D", 180, 158);
    text("S", 115, 205);
    text("W", 112, 235);
    text("Pausa", 30, 235);
    textSize(30);  //tamaño texto Controles
    text("P", 50, 265);
    text("Controles", 50, 100);
    text("Jugar", 80, 400);
    fill(0, 255, 0); //estilo tecla Enter
    noStroke();
    rect(80, 310, 40, 20);
    rect(80, 330, 80, 40);
    popStyle();
    strokeWeight(5); //flecha enter
    line(100, 320, 100, 350);
    line(100, 350, 140, 350);
    triangle(140, 345, 145, 350, 140, 355);
  } else { //jugando
    stroke(120, 30); //estilo líneas guía
    for (int i = 40; i<220; i+=20) { //cantidad de líneas verticales
      line(i, 20, i, 420); //posición lineas verticales
    }
    for (int i = 120; i<420; i+=20) { //cantidad de líneas verticales
      line(20, i, 220, i); //posición líneas horizontales
    }
    fill(255, 0, 0); //estilo límite del tablero para colocar fichas
    rect(20, 20, 200, 80); //límite del tablero para colocar fichas
    for (int i = 255; i > 0; i-=5) { // líneas de peligro
      stroke(255, 0, 0, i); //estilo líneas
      line(20, (-i/5)+151, 220, (-i/5)+151); //posición líneas
    }
    if (fichaActiva == -1) { //cuando no hay ficha en el tablero o recién cayó...
      fichaActiva = siguienteFicha; //escoge la ficha
      siguienteFicha = int(random(7)); //escoge la siguiente ficha
      if (fichaActiva < 3) { //para fichas de 4 posiciones (T, L y J)...
        fichaCode = (fichaActiva*4)+int(random(4)); //escoje la posición
      } else if (fichaActiva < 6) { //para fichas de 2 posiciones (S, Z y la columna)...
        fichaCode = ((fichaActiva + 3)*2)+int(random(2)); //escoje la posición
      } else { //para fichas de 1 posición
        fichaCode = 18; //escoge el cuadrado
      }
      for (int i = 0; i<8; i++) { //para los 8 valores de las coordenadas...
        coordenadas.set(i, datos[1][0][fichaCode][i]); //dar un valor según la posición de la ficha
      }
    }
    stroke(255, 0, 0); //bordes de las fichas
    for (int i=0; i<200; i++) { //lee el color de cada cuadro del tablero
      if (i%10 == 0) { //si la lectura empieza una nueva fila...
        if (filaCompleta == 10) { //y si la fila tiene los 10 cuadros llenos...
          filasEliminadas+=1; //aumenta el contador de filas
          for (int k=1; k<11; k++) { //se devuelve en la fila llena...
            cuadros.remove(i-k); //para remover cada cuadro
            cuadros.append(-1); //y agregar nuevos cuadros al final
          }
        }
        filaCompleta = 0; //al empezar una nueva fila reinicia el contador
      }
      if (i>159 && cuadros.get(i)!=-1) { //detector de pérdida
        start = 2; //al haber perdido, se cambia el estado de la partida
        pushStyle();
        noStroke(); //estilo aviso
        fill(0, 200); //relleno aviso
        rect(30, 140, 180, 240, 20); //aviso
        fill(0, 255, 0); //tecla enter
        rect(80, 310, 40, 20);
        rect(80, 330, 80, 40);
        strokeWeight(5); //estilo flechas del enter
        stroke(255);
        line(100, 320, 100, 350); //flecha
        line(100, 350, 140, 350);
        triangle(140, 345, 145, 350, 140, 355);
        fill(255); //estilo Texto
        textSize(30);
        text("Perdiste", 60, 200);
        textSize(15);
        text("Reintentar", 80, 290);
        popStyle();
      } 
      if (cuadros.get(i) != -1 && !pausa) { //cuando un cuadro esté ocupado y el juego no este pausado
        filaCompleta+=1; //aumentar el contador de cuadros ocupados por fila
        fill(datos[0][cuadros.get(i)][0][0], datos[0][cuadros.get(i)][0][1], datos[0][cuadros.get(i)][0][2]); //seleccionar el color del cuadro del tablero (entre verde, naranja, azul, amarillo, fucsia, azul claro y blanco para el tetromino T, L, J, S, Z, | y Cuadrado respectivamente)
        square((1+(i%10))*20, (20-(i/10))*20, 20); //imprime  cada cuadro de cada color
      }
    }
    fill(datos[0][fichaActiva][0][0], datos[0][fichaActiva][0][1], datos[0][fichaActiva][0][2]); //seleccionar el color del tetromino en juego (entre verde, naranja, azul, amarillo, fucsia, azul claro y blanco para el tetromino T, L, J, S, Z, | y Cuadrado respectivamente)
    if (!pausa) { //verificar que el juego no esté pausado
      for (int i=0; i<7; i+=2) { //dibuja el tetromino
        square((coordenadas.get(i))*20, (21-coordenadas.get(i+1))*20, 20); //dibuja el tetromino
      } //se ha dibujado el tetromino
      if (start == 1) { //avanzar se está jugando
        delay(1); //pasar un poco de tiempo (más lo que demora el código en ejecutarse)
        tiempo++; //incrementa el contador del tiempo
        if (tiempo == ultimo) { //si el tiempo necesario para que baje la ficha se ha cumplido
          confirmarBajamiento(); //se baja un cuadro el tetromino o se coloca
          tiempo = 0; //reinicia el contador de tiempo
        }
      }
    } else { //mientras que el juego esté pausado
      pushStyle();
      noStroke(); //estilo recuadro menú
      fill(0, 200);
      rect(30, 100, 180, 280, 20); //recuadro menú
      fill(0, 255, 0); //enter
      rect(80, 310, 40, 20);
      rect(80, 330, 80, 40);
      strokeWeight(5); //flecha enter
      stroke(255);
      line(100, 320, 100, 350);
      line(100, 350, 140, 350);
      triangle(140, 345, 145, 350, 140, 355);
      fill(255); //texto
      textSize(30);
      text("Pausa", 80, 140);
      text("P", 110, 250);
      textSize(15);
      text("Despausar", 80, 220);
      text("Reintentar", 80, 290);
      popStyle();
    }
  }
}
void keyPressed() { //entrada del teclado para manipular pieza o juego
  if (keyCode == 10) { //presionando enter
    if (start == 2 || pausa) { //al haber perdido o pausado el juego (es decir, reiniciando el juego)
      filaCompleta = 0; //reiniciar el contador de cuadros por fila
      fichaActiva = -1; //desactivar el tetromino en juego
      siguienteFicha = int(random(7)); //re-sortear la siguiente ficha
      prevfichaCode = -1; //reiniciar posición anterior del tetromino en giros
      filasEliminadas = 0; //reiniciar el contador de filas eliminadas
      nivel = 1; //retornar al nivel 1
      pausa = false; //despausar
      for (int i = 0; i < 200; i++) { //pasar por los 200 cuadros del tablero
        cuadros.set(i, -1); //reiniciar cada cuadro
      }
    }
    start = 1; //reiniciar el juego
  } else if (start == 1&&(key == 'p' || key == 'P')) { //Presionando la tecla de pausa... 
    if (pausa) { //si el juego estaba en pausa...
      pausa = false; //despausar
    } else if (!pausa) { //si no estaba pausado...
      pausa = true; //pausar
    }
  } else if (fichaActiva != -1 && start == 1 && !pausa) { //si hay una ficha en juego, se está en juego y no está pausado
    if (key == 's' || key == 'S' || keyCode == DOWN) { //tecla para bajar
      confirmarBajamiento(); //bajar una línea o colocar la ficha
      tiempo = 0; //reiniciar el tiempo transcurrido
    } else if (key == 'W' || key == 'w' || keyCode == UP) {//W para bajar al fondo
      tiempo = 0; //reiniciar el tiempo transcurrido
      while (fichaActiva != -1) { //mientras que no haya una ficha activa (porque no se ha colocado la anterior)
        confirmarBajamiento(); //bajar un cuadro la ficha o colocarla
      } //ficha colocada
      tiempo = 0; //reiniciar el contador del tiempo
    } else if (keyCode == LEFT || key == 'a' || key == 'A') { //mover a la izquierda el tetromino
      if (coordenadas.get(0)-1>0&&cuadros.get(((coordenadas.get(1)-1)*10)+coordenadas.get(0)-2)==-1&&cuadros.get(((coordenadas.get(3)-1)*10)+coordenadas.get(2)-2)==-1&&cuadros.get(((coordenadas.get(5)-1)*10)+coordenadas.get(4)-2)==-1&&cuadros.get(((coordenadas.get(7)-1)*10)+coordenadas.get(6)-2)==-1) {
        for (int l=0; l<8; l+=2) { //confimar si el tetromino se puede mover, y de ser así, reubicarlo
          coordenadas.sub(l, 1);
        }
      }
    } else if (key == 'd' || key == 'D' || keyCode == RIGHT) { //mover a la derecha el tetromino
      if (coordenadas.get(6)+1<11&&cuadros.get(((coordenadas.get(1)-1)*10)+coordenadas.get(0))==-1&&cuadros.get(((coordenadas.get(3)-1)*10)+coordenadas.get(2))==-1&&cuadros.get(((coordenadas.get(5)-1)*10)+coordenadas.get(4))==-1&&cuadros.get(((coordenadas.get(7)-1)*10)+coordenadas.get(6))==-1) {
        for (int l=0; l<8; l+=2) { //confimar si el tetromino se puede mover, y de ser así, reubicarlo
          coordenadas.increment(l);
        }
      }
    } else if (key == 'E' || key == 'e') { //girar el tetromino en sentido horario
      if (fichaCode%4 == 3 && fichaCode<12) { //para forzar rotación de fichas de 4 posiciones
        prevfichaCode=fichaCode; //grabar el código de la posición anterior en que estaba la ficha
        fichaCode-=3; //cambiar el código de la posición actual 
        girar(); //girar la pieza (de poderse)
        if (!rotado) { //si no se pudo rotar...
          fichaCode+=3; //restaurar el código de la posición actual
        } else { //y si sí...
          rotado = false; //anticipar una nueva rotación
        }
      } else if (fichaCode == 13 || fichaCode == 15 || fichaCode == 17) { //para forzar rotación de fichas de 2 posiciones
        prevfichaCode=fichaCode; //grabar el código de la posición anterior en que estaba la ficha
        fichaCode-=1; //cambiar el código de la posición actual 
        girar(); //girar la pieza (de poderse)
        if (!rotado) { //si no se pudo rotar...
          fichaCode+=1; //restaurar el código de la posición actual
        } else { //y si sí...
          rotado = false; //anticipar una nueva rotación
        }
      } else if (fichaCode<18) { //Para rotar la ficha sin necesidad de forzar...
        prevfichaCode=fichaCode; //grabar el código de la posición anterior en que estaba la ficha
        fichaCode+=1; //cambiar el código de la posición actual 
        girar(); //girar la pieza (de poderse)
        if (!rotado) { //si no se pudo rotar...
          fichaCode-=1; //restaurar el código de la posición actual
        } else { //y si sí...
          rotado = false; //anticipar una nueva rotación
        }
      } //ficha rotada (dentro de lo posible)
    } else if (key == 'q' || key == 'Q') { //girar el tetromino en sentido antihorario
      if (fichaCode%4 == 0 && fichaCode<12) { //para forzar rotación de fichas de 4 posiciones
        prevfichaCode=fichaCode; //grabar el código de la posición anterior en que estaba la ficha
        fichaCode+=3; //cambiar el código de la posición actual
        girar(); //girar la pieza (de poderse)
        if (!rotado) { //si no se pudo rotar...
          fichaCode-=3; //restaurar el código de la posición actual
        } else { //y si sí...
          rotado = false; //anticipar una nueva rotación
        }
      } else if (fichaCode == 12 || fichaCode == 14 || fichaCode == 16) { //para forzar rotación de fichas de 2 posiciones
        prevfichaCode=fichaCode; //grabar el código de la posición anterior en que estaba la ficha
        fichaCode+=1; //cambiar el código de la posición actual
        girar(); //girar la pieza (de poderse)
        if (!rotado) { //si no se pudo rotar...
          fichaCode-=1; //restaurar el código de la posición actual
        } else { //y si sí...
          rotado = false; //anticipar una nueva rotación
        }
      } else if (fichaCode<18) { //Para rotar la ficha sin necesidad de forzar...
        prevfichaCode=fichaCode; //grabar el código de la posición anterior en que estaba la ficha
        fichaCode-=1; //cambiar el código de la posición actual
        girar(); //girar la pieza (de poderse)
        if (!rotado) { //si no se pudo rotar...
          fichaCode+=1; //restaurar el código de la posición actual
        } else { //y si sí...
          rotado = false; //anticipar una nueva rotación
        }
      }
    }
  }
}
void confirmarBajamiento() { //baja o coloca una ficha
  if (coordenadas.get(1)!=1&&coordenadas.get(3)!=1&&coordenadas.get(5)!=1&&cuadros.get(((coordenadas.get(1)-2)*10)+coordenadas.get(0)-1)==-1&&cuadros.get(((coordenadas.get(3)-2)*10)+coordenadas.get(2)-1)==-1&&cuadros.get(((coordenadas.get(5)-2)*10)+coordenadas.get(4)-1)==-1&&cuadros.get(((coordenadas.get(7)-2)*10)+coordenadas.get(6)-1)==-1) {
    for (int l=1; l<8; l+=2) { //si la pieza no tiene debajo los bordes del tablero ni cuadros del tablero, reubicarla un cuadro abajo
      coordenadas.sub(l, 1);
    } //ficha reubicada
  } else { //de lo contrario, coloca la ficha...
    for (int l=1; l<8; l+=2) { //y cada cuadro del tetromino...
      cuadros.set(((coordenadas.get(l)-1)*10)+coordenadas.get(l-1)-1, fichaActiva); //se coloca en el tablero
    } //pieza colocada
    fichaActiva = -1; //desactiva la pieza colocada en el tablero
  }
}
void girar() { //confirma si una ficha puede girar, y la rota de ser así
  if (fichaCode == 0) { //ficha T a su primera posición
    if (prevfichaCode == 3) { //a la derecha
      if (cuadros.get(((coordenadas.get(1)-1)*10)+coordenadas.get(0))==-1&&cuadros.get(((coordenadas.get(7)-1)*10)+coordenadas.get(6))==-1&&coordenadas.get(6)+1<11) {
        coordenadas.increment(1);
        coordenadas.increment(2);
        coordenadas.sub(3, 1);
        coordenadas.increment(4);
        coordenadas.sub(5, 1);
        coordenadas.increment(6);
        rotado = true;
      } // a la izquierda
    } else if (cuadros.get(((coordenadas.get(5)-1)*10)+coordenadas.get(4))==-1&&coordenadas.get(4)+1<11) {
      coordenadas.increment(6);
      coordenadas.sub(7, 1);
      rotado = true;
    }
  } else if (fichaCode == 1) { //ficha T a su segunda posición
    if (prevfichaCode == 2) { // a la izquierda
      if (cuadros.get(((coordenadas.get(5)-1)*10)+coordenadas.get(4)-2)==-1&&cuadros.get((coordenadas.get(5)*10)+coordenadas.get(4)-1)==-1) {
        coordenadas.increment(1);
        coordenadas.sub(6, 1);
        coordenadas.add(7, 2);
        rotado = true;
      } //a la derecha
    } else if (cuadros.get((coordenadas.get(1)*10)+coordenadas.get(0)-1)==-1) {
      coordenadas.sub(6, 1);
      coordenadas.increment(7);
      rotado = true;
    }
  } else if (fichaCode == 2) { //ficha T a su tercera posición
    if (prevfichaCode == 3) { //a la izquierda
      if (cuadros.get(((coordenadas.get(7)-2)*10)+coordenadas.get(6)-1)==-1&&cuadros.get(((coordenadas.get(7)-2)*10)+coordenadas.get(6))==-1&&coordenadas.get(6)+1<11) {
        coordenadas.increment(2);
        coordenadas.sub(3, 1);
        coordenadas.increment(4);
        coordenadas.sub(5, 1);
        coordenadas.increment(6);
        coordenadas.sub(7, 1);
        rotado = true;
      } //a la derecha
    } else if (cuadros.get(((coordenadas.get(1)-2)*10)+coordenadas.get(0)-1)==-1&&cuadros.get(((coordenadas.get(3)-1)*10)+coordenadas.get(2))==-1&&coordenadas.get(6)+1<11) {
      coordenadas.sub(1, 1);
      coordenadas.increment(6);
      coordenadas.sub(7, 2);
      rotado = true;
    }
  } else if (fichaCode == 3) { //ficha T a su cuarta posición
    if (prevfichaCode == 0) { //a la izquierda
      if (cuadros.get(((coordenadas.get(1)-2)*10)+coordenadas.get(0)-1)==-1&&cuadros.get(((coordenadas.get(1))*10)+coordenadas.get(0)-1)==-1) {
        coordenadas.sub(1, 1);
        coordenadas.sub(2, 1);
        coordenadas.increment(3);
        coordenadas.sub(4, 1);
        coordenadas.increment(5);
        coordenadas.sub(6, 1);
        rotado = true;
      } //a la derecha
    } else if (cuadros.get(((coordenadas.get(5)-1)*10)+coordenadas.get(4)-2)==-1&&cuadros.get(((coordenadas.get(5))*10)+coordenadas.get(4)-2)==-1) {
      coordenadas.sub(2, 1);
      coordenadas.increment(3);
      coordenadas.sub(4, 1);
      coordenadas.increment(5);
      coordenadas.sub(6, 1);
      coordenadas.increment(7);
      rotado = true;
    }
  } else if (fichaCode == 4) { //ficha L a su primera posición
    if (prevfichaCode == 7) { //a la derecha
      if (cuadros.get((coordenadas.get(1)*10)+coordenadas.get(0)-1)==-1&&cuadros.get(((coordenadas.get(1)+1)*10)+coordenadas.get(0)-1)==-1) {
        coordenadas.sub(2, 1);
        coordenadas.increment(3);
        coordenadas.sub(4, 2);
        coordenadas.add(5, 2);
        coordenadas.sub(6, 1);
        coordenadas.sub(7, 1);
        rotado = true;
      } //a la izquierda
    } else if (cuadros.get(((coordenadas.get(1)-1)*10)+coordenadas.get(0))==-1&&cuadros.get((coordenadas.get(3)*10)+coordenadas.get(2)-1)==-1) {
      coordenadas.sub(4, 1);
      coordenadas.increment(5);
      coordenadas.sub(6, 1);
      coordenadas.sub(7, 1);
      rotado = true;
    }
  } else if (fichaCode == 5) { //ficha L a su segunda posición
    if (prevfichaCode == 6) { //a la izquierda
      if (cuadros.get(((coordenadas.get(1)-2)*10)+coordenadas.get(0)-1)==-1&&cuadros.get(((coordenadas.get(1)-3)*10)+coordenadas.get(0)-1)==-1&&cuadros.get(((coordenadas.get(5)-1)*10)+coordenadas.get(4))==-1&&coordenadas.get(6)+1<11) {
        coordenadas.sub(1, 2);
        coordenadas.sub(2, 1);
        coordenadas.increment(3);
        coordenadas.increment(6);
        coordenadas.sub(7, 1);
        rotado = true;
      } //a la derecha
    } else if (cuadros.get(((coordenadas.get(3)-1)*10)+coordenadas.get(2))==-1&&cuadros.get(((coordenadas.get(3)-1)*10)+coordenadas.get(2)+1)==-1&&coordenadas.get(6)+1<11) {
      coordenadas.increment(4);
      coordenadas.sub(5, 1);
      coordenadas.increment(6);
      coordenadas.increment(7);
      rotado = true;
    }
  } else if (fichaCode == 6) { //ficha L a su tercera posición
    if (prevfichaCode == 5) { //a la derecha
      if (cuadros.get((coordenadas.get(3)*10)+coordenadas.get(2)-1)==-1&&cuadros.get((coordenadas.get(5)*10)+coordenadas.get(4)-1)==-1&&cuadros.get(((coordenadas.get(5)-2)*10)+coordenadas.get(4)-1)==-1) {
        coordenadas.add(1, 2);
        coordenadas.increment(2);
        coordenadas.sub(3, 1);
        coordenadas.sub(6, 1);
        coordenadas.increment(7);
        rotado = true;
      } //a la izquierda
    } else if (cuadros.get(((coordenadas.get(1)+1)*10)+coordenadas.get(0)-1)==-1&&cuadros.get(((coordenadas.get(3)+1)*10)+coordenadas.get(2)-1)==-1&&cuadros.get((coordenadas.get(3)*10)+coordenadas.get(2)-1)==-1) {
      coordenadas.add(1, 2);
      coordenadas.sub(4, 1);
      coordenadas.increment(5);
      coordenadas.sub(6, 1);
      coordenadas.increment(7);
      rotado = true;
    }
  } else if (fichaCode == 7) { //ficha L a su cuarta posición
    if (prevfichaCode == 4) { //a la izquierda
      if (cuadros.get(((coordenadas.get(7)-1)*10)+coordenadas.get(6))==-1&&cuadros.get(((coordenadas.get(7)-1)*10)+coordenadas.get(6)+1)==-1&&coordenadas.get(6)+1<11) {
        coordenadas.increment(2);
        coordenadas.sub(3, 1);
        coordenadas.add(4, 2);
        coordenadas.sub(5, 2);
        coordenadas.increment(6);
        coordenadas.increment(7);
        rotado = true;
      } //a la derecha
    } else if (cuadros.get(((coordenadas.get(3)-1)*10)+coordenadas.get(2)-2)==-1&&cuadros.get(((coordenadas.get(3)-1)*10)+coordenadas.get(2))==-1&&cuadros.get(((coordenadas.get(5)-1)*10)+coordenadas.get(4))==-1&&coordenadas.get(6)+1<11) {
      coordenadas.sub(1, 2);
      coordenadas.increment(4);
      coordenadas.sub(5, 1);
      coordenadas.increment(6);
      coordenadas.sub(7, 1);
      rotado = true;
    }
  } else if (fichaCode == 8) { //ficha J a su primera posición
    if (prevfichaCode == 11) { //a la derecha
      if (cuadros.get(((coordenadas.get(1)-2)*10)+coordenadas.get(0)-1)==-1&&cuadros.get(((coordenadas.get(3)-2)*10)+coordenadas.get(2)-1)==-1&&cuadros.get((coordenadas.get(3)*10)+coordenadas.get(2)-1)==-1) {
        coordenadas.sub(1, 1);
        coordenadas.sub(3, 1);
        coordenadas.sub(4, 1);
        coordenadas.increment(5);
        coordenadas.sub(6, 1);
        coordenadas.add(7, 1);
        rotado = true;
      } //a la izquierda
    } else if (cuadros.get(((coordenadas.get(5)+1)*10)+coordenadas.get(4)-1)==-1&&cuadros.get((coordenadas.get(5)*10)+coordenadas.get(4)-1)==-1) {
      coordenadas.increment(2);
      coordenadas.sub(3, 1);
      coordenadas.increment(5);
      coordenadas.sub(6, 1);
      coordenadas.add(7, 2);
      rotado = true;
    }
  } else if (fichaCode == 9) { //ficha J a su segunda posición
    if (prevfichaCode == 8) { //a la derecha
      if (cuadros.get(((coordenadas.get(5)-1)*10)+coordenadas.get(4)-2)==-1&&cuadros.get(((coordenadas.get(3)-1)*10)+coordenadas.get(2))==-1&&coordenadas.get(6)+1<11) {
        coordenadas.sub(2, 1);
        coordenadas.increment(3);
        coordenadas.sub(5, 1);
        coordenadas.increment(6);
        coordenadas.sub(7, 2);
        rotado = true;
      } //a la izquierda
    } else if (cuadros.get(((coordenadas.get(1)-1)*10)+coordenadas.get(0))==-1&&cuadros.get(((coordenadas.get(1)-1)*10)+coordenadas.get(0)+1)==-1&&coordenadas.get(6)+1<11) {
      coordenadas.increment(4);
      coordenadas.sub(5, 2);
      coordenadas.increment(6);
      coordenadas.sub(7, 2);
      rotado = true;
    }
  } else if (fichaCode == 10) { //ficha J a su tercera posición
    if (prevfichaCode == 11) { //a la izquierda
      if (cuadros.get(((coordenadas.get(1)-2)*10)+coordenadas.get(0)-1)==-1&&cuadros.get((coordenadas.get(3)*10)+coordenadas.get(2)-1)==-1&&cuadros.get((coordenadas.get(1)*10)+coordenadas.get(0)-1)==-1) {
        coordenadas.sub(1, 1);
        coordenadas.sub(2, 1);
        coordenadas.sub(4, 2);
        coordenadas.add(5, 2);
        coordenadas.sub(6, 1);
        coordenadas.increment(7);
        rotado = true;
      } //a la derecha
    } else if (cuadros.get((coordenadas.get(3)*10)+coordenadas.get(2))==-1&&cuadros.get((coordenadas.get(3)*10)+coordenadas.get(2)-1)==-1) {
      coordenadas.sub(4, 1);
      coordenadas.add(5, 2);
      coordenadas.sub(6, 1);
      coordenadas.add(7, 2);
      rotado = true;
    }
  } else if (fichaCode == 11) { //ficha J a su cuarta posición
    if (prevfichaCode == 8) { //a la izquierda
      if (cuadros.get(((coordenadas.get(5)-1)*10)+coordenadas.get(4)-2)==-1&&cuadros.get(((coordenadas.get(5)-1)*10)+coordenadas.get(4))==-1&&cuadros.get(((coordenadas.get(3)-1)*10)+coordenadas.get(2))==-1&&coordenadas.get(6)+1<11) {
        coordenadas.increment(1);
        coordenadas.increment(3);
        coordenadas.increment(4);
        coordenadas.sub(5, 1);
        coordenadas.increment(6);
        coordenadas.sub(7, 1);
        rotado = true;
      } //a la derecha
    } else if (cuadros.get((coordenadas.get(1)*10)+coordenadas.get(0))==-1&&cuadros.get((coordenadas.get(1)*10)+coordenadas.get(0)+1)==-1&&cuadros.get(((coordenadas.get(1)-1)*10)+coordenadas.get(0)+1)==-1&&coordenadas.get(6)+1<11) {
      coordenadas.increment(1);
      coordenadas.increment(2);
      coordenadas.add(4, 2);
      coordenadas.sub(5, 2);
      coordenadas.increment(6);
      coordenadas.sub(7, 1);
      rotado = true;
    }
  } else if (fichaCode==12&&cuadros.get(((coordenadas.get(7)-1)*10)+coordenadas.get(6)-2)==-1&&cuadros.get((coordenadas.get(7)*10)+coordenadas.get(6))==-1&&coordenadas.get(6)+1<11) {
    coordenadas.sub(1, 1); //Silla a S
    coordenadas.increment(2);
    coordenadas.sub(3, 2);
    coordenadas.increment(5);
    coordenadas.increment(6);
    rotado = true;
  } else if (fichaCode==13&&cuadros.get((coordenadas.get(1)*10)+coordenadas.get(0)-1)==-1&&cuadros.get((coordenadas.get(5)*10)+coordenadas.get(4)-2)==-1) {
    coordenadas.increment(1); //S a Silla
    coordenadas.sub(2, 1);
    coordenadas.add(3, 2);
    coordenadas.sub(5, 1);
    coordenadas.sub(6, 1);
    rotado = true;
  } else if (fichaCode==14&&cuadros.get((coordenadas.get(1)*10)+coordenadas.get(0)-2)==-1&&cuadros.get(((coordenadas.get(1)-1)*10)+coordenadas.get(0))==-1&&coordenadas.get(6)+1<11) {
    coordenadas.increment(1); //Zilla a Z
    coordenadas.increment(2);
    coordenadas.sub(3, 1);
    coordenadas.increment(6);
    coordenadas.sub(7, 2);
    rotado = true;
  } else if (fichaCode==15&&cuadros.get((coordenadas.get(1)*10)+coordenadas.get(0)-2)==-1&&cuadros.get(((coordenadas.get(1)-1)*10)+coordenadas.get(0))==-1) {
    coordenadas.sub(1, 1); //Z a Zilla
    coordenadas.sub(2, 1);
    coordenadas.increment(3);
    coordenadas.sub(6, 1);
    coordenadas.add(7, 2);
    rotado = true;
  } else if (fichaCode==16&&cuadros.get(((coordenadas.get(1)-2)*10)+coordenadas.get(0))==-1&&cuadros.get((coordenadas.get(1)*10)+coordenadas.get(0))==-1&&cuadros.get(((coordenadas.get(1)+1)*10)+coordenadas.get(0))==-1&&coordenadas.get(1)!=1) {
    coordenadas.increment(0); //Fila a Columna
    coordenadas.sub(1, 1);
    coordenadas.sub(4, 1);
    coordenadas.increment(5);
    coordenadas.sub(6, 2);
    coordenadas.add(7, 2);
    rotado = true;
  } else if (fichaCode==17&&cuadros.get((coordenadas.get(1)*10)+coordenadas.get(0)-2)==-1&&cuadros.get((coordenadas.get(1)*10)+coordenadas.get(0))==-1&&cuadros.get((coordenadas.get(1)*10)+coordenadas.get(0)+1)==-1&&coordenadas.get(0)-1>0&&coordenadas.get(6)+2<11) {
    coordenadas.sub(0, 1); //Columna a Fila
    coordenadas.increment(1);
    coordenadas.increment(4);
    coordenadas.sub(5, 1);
    coordenadas.add(6, 2);
    coordenadas.sub(7, 2);
    rotado = true;
  }
}
