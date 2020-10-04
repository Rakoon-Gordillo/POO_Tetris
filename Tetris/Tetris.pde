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
  strokeWeight(1);
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
  pushStyle();
  if (!pausa) { //muestra, si el juego no está pausado, la siguiente ficha
    if (siguienteFicha == 0) { //T
      fill(0, 255, 0);
      square(250, 100, 20);
      square(270, 100, 20);
      square(270, 120, 20);
      square(290, 100, 20);
    } else if (siguienteFicha == 1) { //L
      fill(255, 120, 0);
      square(260, 90, 20);
      square(260, 110, 20);
      square(260, 130, 20);
      square(280, 130, 20);
    } else if (siguienteFicha == 2) { //J
      fill(51, 51, 255);
      square(280, 90, 20);
      square(280, 110, 20);
      square(260, 130, 20);
      square(280, 130, 20);
    } else if (siguienteFicha == 3) { //S
      fill(255, 255, 0);
      square(250, 120, 20);
      square(270, 100, 20);
      square(270, 120, 20);
      square(290, 100, 20);
    } else if (siguienteFicha == 4) { //Z
      fill(255, 0, 120);
      square(250, 100, 20);
      square(270, 100, 20);
      square(270, 120, 20);
      square(290, 120, 20);
    } else if (siguienteFicha == 5) { //Palo
      fill(0, 255, 255);
      square(270, 140, 20);
      square(270, 120, 20);
      square(270, 100, 20);
      square(270, 80, 20);
    } else if (siguienteFicha == 6) { //Cuadrado
      fill(255);
      square(280, 120, 20);
      square(260, 120, 20);
      square(280, 100, 20);
      square(260, 100, 20);
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
    noFill(); //retiro relleno
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
    noStroke();
    text("Q", 65, 157);
    text("A", 45, 157);
    text("E", 160, 158);
    text("D", 180, 158);
    text("S", 115, 205);
    text("W", 112, 235);
    text("Pausa", 30, 235);
    textSize(30);  //tamaño texto C.
    text("P", 50, 265);
    text("Controles", 50, 100);
    text("Jugar", 80, 400);
    fill(0, 255, 0);
    rect(80, 310, 40, 20);
    rect(80, 330, 80, 40);
    popStyle();
    strokeWeight(5); //enter
    line(100, 320, 100, 350);
    line(100, 350, 140, 350);
    triangle(140, 345, 145, 350, 140, 355);
  } else { //jugando
    stroke(120, 30);
    for(int i = 40; i<220; i+=20){
      line(i, 20, i, 420);
    }
    for(int i = 120; i<420; i+=20){
      line(20, i, 220, i);
    }
    fill(255, 0, 0); //límite superior rojo del tablero
    rect(20, 20, 200, 80);
    for (int i = 255; i > 0; i-=5) { //líneas de peligro
      stroke(255, 0, 0, i);
      line(20, (-i/5)+151, 220, (-i/5)+151);
    }
    if (fichaActiva == -1) {
      fichaActiva = siguienteFicha; //escoge la ficha
      siguienteFicha = int(random(7));
      if (fichaActiva < 3) {
        fichaCode = (fichaActiva*4)+int(random(4)); //escoje la posición entre la T, L y J
      } else if (fichaActiva < 6) {
        fichaCode = ((fichaActiva + 3)*2)+int(random(2)); //escoje la posición entre S, Z y el palo
      } else {
        fichaCode = 18; //escoge el cuadrado
      }
      if (fichaCode == 0) { //T
        fichaActiva = 0;
        coordenadas.set(0, 5);
        coordenadas.set(1, 18);
        coordenadas.set(2, 6);
        coordenadas.set(3, 17);
        coordenadas.set(4, 6);
        coordenadas.set(5, 18);
        coordenadas.set(6, 7);
        coordenadas.set(7, 18);
      } else if (fichaCode == 1) {//-|
        fichaActiva = 0;
        coordenadas.set(0, 5);
        coordenadas.set(1, 18);
        coordenadas.set(2, 6);
        coordenadas.set(3, 17);
        coordenadas.set(4, 6);
        coordenadas.set(5, 18);
        coordenadas.set(6, 6);
        coordenadas.set(7, 19);
      } else if (fichaCode == 2) { // T inversa
        fichaActiva = 0;
        coordenadas.set(0, 5);
        coordenadas.set(1, 17);
        coordenadas.set(2, 6);
        coordenadas.set(3, 17);
        coordenadas.set(4, 6);
        coordenadas.set(5, 18);
        coordenadas.set(6, 7);
        coordenadas.set(7, 17);
      } else if (fichaCode == 3) { //|-
        fichaActiva = 0;
        coordenadas.set(0, 5);
        coordenadas.set(1, 17);
        coordenadas.set(2, 5);
        coordenadas.set(3, 18);
        coordenadas.set(4, 5);
        coordenadas.set(5, 19);
        coordenadas.set(6, 6);
        coordenadas.set(7, 18);
      } else if (fichaCode == 4) { //L
        fichaActiva = 1;
        coordenadas.set(0, 5);
        coordenadas.set(1, 17);
        coordenadas.set(2, 5);
        coordenadas.set(3, 18);
        coordenadas.set(4, 5);
        coordenadas.set(5, 19);
        coordenadas.set(6, 6);
        coordenadas.set(7, 17);
      } else if (fichaCode == 5) { //L boca abajo
        fichaActiva = 1;
        coordenadas.set(0, 5);
        coordenadas.set(1, 17);
        coordenadas.set(2, 5);
        coordenadas.set(3, 18);
        coordenadas.set(4, 6);
        coordenadas.set(5, 18);
        coordenadas.set(6, 7);
        coordenadas.set(7, 18);
      } else if (fichaCode == 6) {//1
        fichaActiva = 1;
        coordenadas.set(0, 5);
        coordenadas.set(1, 19);
        coordenadas.set(2, 6);
        coordenadas.set(3, 17);
        coordenadas.set(4, 6);
        coordenadas.set(5, 18);
        coordenadas.set(6, 6);
        coordenadas.set(7, 19);
      } else if (fichaCode == 7) {//L acostada
        fichaActiva = 1;
        coordenadas.set(0, 5);
        coordenadas.set(1, 17);
        coordenadas.set(2, 6);
        coordenadas.set(3, 17);
        coordenadas.set(4, 7);
        coordenadas.set(5, 17);
        coordenadas.set(6, 7);
        coordenadas.set(7, 18);
      } else if (fichaCode == 8) { //J
        fichaActiva = 2;
        coordenadas.set(0, 5);
        coordenadas.set(1, 17);
        coordenadas.set(2, 6);
        coordenadas.set(3, 17);
        coordenadas.set(4, 6);
        coordenadas.set(5, 18);
        coordenadas.set(6, 6);
        coordenadas.set(7, 19);
      } else if (fichaCode == 9) { //J acostada
        fichaActiva = 2;
        coordenadas.set(0, 5);
        coordenadas.set(1, 17);
        coordenadas.set(2, 5);
        coordenadas.set(3, 18);
        coordenadas.set(4, 6);
        coordenadas.set(5, 17);
        coordenadas.set(6, 7);
        coordenadas.set(7, 17);
      } else if (fichaCode == 10) { // J inversa
        fichaActiva = 2;
        coordenadas.set(0, 5);
        coordenadas.set(1, 17);
        coordenadas.set(2, 5);
        coordenadas.set(3, 18);
        coordenadas.set(4, 5);
        coordenadas.set(5, 19);
        coordenadas.set(6, 6);
        coordenadas.set(7, 19);
      } else if (fichaCode == 11) { //Negador
        fichaActiva = 2;
        coordenadas.set(0, 5);
        coordenadas.set(1, 18);
        coordenadas.set(2, 6);
        coordenadas.set(3, 18);
        coordenadas.set(4, 7);
        coordenadas.set(5, 17);
        coordenadas.set(6, 7);
        coordenadas.set(7, 18);
      } else if (fichaCode == 12) { //S
        fichaActiva = 3;
        coordenadas.set(0, 5);
        coordenadas.set(1, 17);
        coordenadas.set(2, 6);
        coordenadas.set(3, 17);
        coordenadas.set(4, 6);
        coordenadas.set(5, 18);
        coordenadas.set(6, 7);
        coordenadas.set(7, 18);
      } else if (fichaCode == 13) { //Silla
        fichaActiva = 3;
        coordenadas.set(0, 5);
        coordenadas.set(1, 18);
        coordenadas.set(2, 5);
        coordenadas.set(3, 19);
        coordenadas.set(4, 6);
        coordenadas.set(5, 17);
        coordenadas.set(6, 6);
        coordenadas.set(7, 18);
      } else if (fichaCode == 14) { //Z
        fichaActiva = 4;
        coordenadas.set(0, 5);
        coordenadas.set(1, 18);
        coordenadas.set(2, 6);
        coordenadas.set(3, 17);
        coordenadas.set(4, 6);
        coordenadas.set(5, 18);
        coordenadas.set(6, 7);
        coordenadas.set(7, 17);
      } else if (fichaCode == 15) { //Zilla
        fichaActiva = 4;
        coordenadas.set(0, 5);
        coordenadas.set(1, 17);
        coordenadas.set(2, 5);
        coordenadas.set(3, 18);
        coordenadas.set(4, 6);
        coordenadas.set(5, 18);
        coordenadas.set(6, 6);
        coordenadas.set(7, 19);
      } else if (fichaCode == 16) { //Columna
        fichaActiva = 5;
        coordenadas.set(0, 5);
        coordenadas.set(1, 17);
        coordenadas.set(2, 5);
        coordenadas.set(3, 18);
        coordenadas.set(4, 5);
        coordenadas.set(5, 19);
        coordenadas.set(6, 5);
        coordenadas.set(7, 20);
      } else if (fichaCode == 17) { //Fila
        fichaActiva = 5;
        coordenadas.set(0, 4);
        coordenadas.set(1, 18);
        coordenadas.set(2, 5);
        coordenadas.set(3, 18);
        coordenadas.set(4, 6);
        coordenadas.set(5, 18);
        coordenadas.set(6, 7);
        coordenadas.set(7, 18);
      } else if (fichaCode == 18) { //Cuadrado
        fichaActiva = 6;
        coordenadas.set(0, 5);
        coordenadas.set(1, 17);
        coordenadas.set(2, 5);
        coordenadas.set(3, 18);
        coordenadas.set(4, 6);
        coordenadas.set(5, 17);
        coordenadas.set(6, 6);
        coordenadas.set(7, 18);
      }
    }
    stroke(255, 0, 0); //bordes de las fichas
    for (int i=0; i<200; i++) { //lee el color de cada cuadro del tablero
      if (i%10 == 0) {
        if (filaCompleta == 10) {
          filasEliminadas+=1;
          for (int k=1; k<11; k++) {
            cuadros.remove(i-k);
            cuadros.append(-1);
          }
        }
        filaCompleta = 0;
      }
      if (i>159 && cuadros.get(i)!=-1) { //detector de pérdida
        start = 2;
        pushStyle();
        noStroke();
        fill(0, 200); //base
        rect(30, 140, 180, 240, 20);
        fill(0, 255, 0); //enter
        rect(80, 310, 40, 20);
        rect(80, 330, 80, 40);
        strokeWeight(5);
        stroke(255);
        line(100, 320, 100, 350);
        line(100, 350, 140, 350);
        triangle(140, 345, 145, 350, 140, 355);
        fill(255); //Texto
        textSize(30);
        text("Perdiste", 60, 200);
        textSize(15);
        text("Reintentar", 80, 290);
        popStyle();
      }
      if (cuadros.get(i) == 0) {
        fill(0, 255, 0); //Verde - T
      } else if (cuadros.get(i) == 1) {
        fill(255, 120, 0); //Naranja - L
      } else if (cuadros.get(i) == 2) {
        fill(51, 51, 255); //Azul - J
      } else if (cuadros.get(i) == 3) {
        fill(255, 255, 0); //Amarillo - S
      } else if (cuadros.get(i) == 4) {
        fill(255, 0, 120); //Fucsia - Z
      } else if (cuadros.get(i) == 5) {
        fill(0, 255, 255); //Azul claro - |
      } else if (cuadros.get(i) == 6) {
        fill(255); //Blanco - Cuadrado
      }
      if (cuadros.get(i) != -1 && !pausa) {
        filaCompleta+=1;
        square((1+(i%10))*20, (20-(i/10))*20, 20); //imprime  cada cuadro de cada color
      }
    }
    if (fichaActiva == 0) {
      fill(0, 255, 0); //Verde - T
    } else if (fichaActiva == 1) {
      fill(255, 120, 0); //Naranja - L
    } else if (fichaActiva == 2) {
      fill(51, 51, 255); //Azul - J
    } else if (fichaActiva == 3) {
      fill(255, 255, 0); //Amarillo - S
    } else if (fichaActiva == 4) {
      fill(255, 0, 120); //Fucsia - Z
    } else if (fichaActiva == 5) {
      fill(0, 255, 255); //Azul claro - |
    } else if (fichaActiva == 6) {
      fill(255); //Blanco - Cuadrado
    }//print(fichaActiva);print(" en posición ");println(fichaCode);
    if (!pausa) {
      for (int i=0; i<7; i+=2) { //dibuja el tetromino
        square((coordenadas.get(i))*20, (21-coordenadas.get(i+1))*20, 20);
      }
      if (start == 1) { //avanzar tiempo para bajar figura
        delay(1); //pasa un ms de tiempo (más lo que se demora el código en ejecutarse)
        tiempo++; //incrementa el contador
        if (tiempo == ultimo) { //confima si el tiempo necesario para que baje la ficha se cumplió
          confirmarBajamiento(); //función que baja la ficha un cuadro
          tiempo = 0; //reinicia el contador
        }
      }
    } else { //mientras que el juego esté pausado
      pushStyle();
      noStroke();
      fill(0, 200); //recuadro de menú
      rect(30, 100, 180, 280, 20);
      fill(0, 255, 0); //enter
      rect(80, 310, 40, 20);
      rect(80, 330, 80, 40);
      strokeWeight(5);
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
void keyPressed() { //println(keyCode);
  if (keyCode == 10) { //ENTER para empezar
    if (start == 2 || pausa) {
      filaCompleta=0;
      fichaActiva=-1;
      siguienteFicha = int(random(7));
      prevfichaCode = -1;
      filasEliminadas = 0;
      nivel = 1;
      pausa = false;
      for (int i = 0; i < 200; i++) {
        cuadros.set(i, -1);
      }
    }
    start = 1;
  } else if (start == 1&&(key == 'p' || key == 'P')) { //Pausar
    if (pausa) {
      pausa = false;
    } else if (!pausa) {
      pausa = true;
    }
    println(pausa);
  } else if (fichaActiva != -1 && start == 1 && !pausa) {
    if (key == 's' || key == 'S' || keyCode == DOWN) { //S para bajar 1 línea
      confirmarBajamiento();
      tiempo = 0;
    } else if (key == 'W' || key == 'w' || keyCode == UP) {//W para bajar al fondo
      tiempo = 0;
      while (fichaActiva != -1) {
        confirmarBajamiento();
      }
      tiempo = 0;
    } else if (keyCode == LEFT || key == 'a' || key == 'A') { //A para mover a la izquierda
      if (coordenadas.get(0)-1>0&&cuadros.get(((coordenadas.get(1)-1)*10)+coordenadas.get(0)-2)==-1&&cuadros.get(((coordenadas.get(3)-1)*10)+coordenadas.get(2)-2)==-1&&cuadros.get(((coordenadas.get(5)-1)*10)+coordenadas.get(4)-2)==-1&&cuadros.get(((coordenadas.get(7)-1)*10)+coordenadas.get(6)-2)==-1) {
        coordenadas.sub(0, 1);
        coordenadas.sub(2, 1);
        coordenadas.sub(4, 1);
        coordenadas.sub(6, 1);
      }
    } else if (key == 'd' || key == 'D' || keyCode == RIGHT) { //D para mover a la derecha
      if (coordenadas.get(6)+1<11&&cuadros.get(((coordenadas.get(1)-1)*10)+coordenadas.get(0))==-1&&cuadros.get(((coordenadas.get(3)-1)*10)+coordenadas.get(2))==-1&&cuadros.get(((coordenadas.get(5)-1)*10)+coordenadas.get(4))==-1&&cuadros.get(((coordenadas.get(7)-1)*10)+coordenadas.get(6))==-1) {
        coordenadas.increment(0);
        coordenadas.increment(2);
        coordenadas.increment(4);
        coordenadas.increment(6);
      }
    } else if (key == 'E' || key == 'e') { //E para girar en sentido horario
      if (fichaCode%4 == 3 && fichaCode<12) {  //fichas de 4 posiciones
        prevfichaCode=fichaCode;
        fichaCode-=3;
        girar();
        if (!rotado) {
          fichaCode+=3;
        } else {
          rotado = false;
        }
      } else if (fichaCode == 13 || fichaCode == 15 || fichaCode == 17) { //fichas de 2 posiciones
        prevfichaCode=fichaCode;
        fichaCode-=1;
        girar();
        if (!rotado) {
          fichaCode+=1;
        } else {
          rotado = false;
        }
      } else if (fichaCode<18) { //Cuadrado
        prevfichaCode=fichaCode;
        fichaCode+=1;
        girar();
        if (!rotado) {
          fichaCode-=1;
        } else {
          rotado = false;
        }
      }
    } else if (key == 'q' || key == 'Q') { //Q para girar en sentido horario
      if (fichaCode%4 == 0 && fichaCode<12) { //código contrario en fichas de 4 posiciones
        prevfichaCode=fichaCode;
        fichaCode+=3;
        girar();
        if (!rotado) {
          fichaCode-=3;
        } else {
          rotado = false;
        }
      } else if (fichaCode == 12 || fichaCode == 14 || fichaCode == 16) { //código contrario en fichas de 2 posiciones
        prevfichaCode=fichaCode;
        fichaCode+=1;
        girar();
        if (!rotado) {
          fichaCode-=1;
        } else {
          rotado = false;
        }
      } else if (fichaCode<18) { //demás
        prevfichaCode=fichaCode;
        fichaCode-=1;
        girar();
        if (!rotado) {
          fichaCode+=1;
        } else {
          rotado = false;
        }
      }
    }
  }
}
void confirmarBajamiento() { //confirma si puede bajar
  if (coordenadas.get(1)!=1&&coordenadas.get(3)!=1&&coordenadas.get(5)!=1&&cuadros.get(((coordenadas.get(1)-2)*10)+coordenadas.get(0)-1)==-1&&cuadros.get(((coordenadas.get(3)-2)*10)+coordenadas.get(2)-1)==-1&&cuadros.get(((coordenadas.get(5)-2)*10)+coordenadas.get(4)-1)==-1&&cuadros.get(((coordenadas.get(7)-2)*10)+coordenadas.get(6)-1)==-1) {
    coordenadas.sub(1, 1);
    coordenadas.sub(3, 1);
    coordenadas.sub(5, 1);
    coordenadas.sub(7, 1);
  } else { //de lo contrario, coloca la ficha
    cuadros.set(((coordenadas.get(1)-1)*10)+coordenadas.get(0)-1, fichaActiva);
    cuadros.set(((coordenadas.get(3)-1)*10)+coordenadas.get(2)-1, fichaActiva);
    cuadros.set(((coordenadas.get(5)-1)*10)+coordenadas.get(4)-1, fichaActiva);
    cuadros.set(((coordenadas.get(7)-1)*10)+coordenadas.get(6)-1, fichaActiva);
    fichaActiva = -1;
  }
}
void girar() { //confirma si una ficha puede girar
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
