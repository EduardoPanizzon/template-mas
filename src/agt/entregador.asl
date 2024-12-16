+!distancia(XO,YO,P) : local(X,Y) & livre(true)
  <-  D = math.sqrt((XO - X)*(XO - X) + (YO - Y)*(YO - Y)); 
      .send(coordenador, tell, dist(D,P)).

+!distancia(XO,YO,P) : livre(false)
  <-  D = 999999;
      .send(coordenador, tell, dist(D,P)).


+!entrega : pacote(P, origem(XO,YO), destino(XD,YD)) & local(XO,YO)
  <- -livre(true);
     +livre(false);
     .print("Entrega do ", P, " em ", XD, ", ", YD, " iniciada");
     !dirigi(XD,YD);
     .print("Entrega de ", P, " em ", XD, ", ", YD, " concluída.");
     -livre(false);
     +livre(true);
     -pacote(P, origem(XO,YO), destino(XD,YD))[source(coordenador)].

+!entrega : pacote(P, origem(XO,YO), destino(XD,YD))
  <- -livre(true);
     +livre(false);
     .print("Indo para ", XO, ", ", YO, " para pegar ", P);
     !dirigi(XO,YO);
     !entrega.


+!dirigi(XD,YD) : local(XD,YD)
  <- .print("Chegou").

+!dirigi(XD,YD) : local(X,Y)
  <- //.print("Saindo de ", X, ", ", Y, " para ", XD,", ",YD);
     !dirigiX(XD,X);
     !dirigiY(YD,Y);
     !dirigi(XD,YD).

+!dirigiX(X1,X2): X1 > X2
  <-  -local(X,Y);
      +local(X2 + 1,Y);
      .wait(1000).

+!dirigiX(X1,X2): X1 < X2
  <-  -local(X,Y);
      +local(X2 - 1,Y);
      .wait(1000).

+!dirigiX(X1,X2): true <- .wait(1).

+!dirigiY(Y1,Y2): Y1 > Y2
  <-  -local(X,Y);
      +local(X,Y2 + 1);
      .wait(1000).

+!dirigiY(Y1,Y2): Y1 < Y2
  <-  -local(X,Y);
      +local(X,Y2 - 1);
      .wait(1000).

+!dirigiY(X1,X2): true <- .wait(1).
