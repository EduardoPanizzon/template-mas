!inicializar_coordenador.

+!inicializar_coordenador
  <- 	makeArtifact("art_coordenador","artifacts.Entregas",[],D);
  	   	focus(D).

+sinal 
  <-  !entrega(P).


+!entrega(P) : pacote(P, XO, YO, XD, YD)
    <-  +pacote(P, origem(XO,YO), destino(XD,YD));
        -pacote(P, XO, YO, XD, YD)[source(A)];
        .broadcast(achieve,distancia(XO,YO,P));
        .wait(1000);
        !mais_proximo(P).        


+dist(D,P)[source(AGT)]
    <-  .print("distância de ", AGT, " é ", D, " de ", P).


+!mais_proximo(P) : dist(D1,P)[source(entregador1)] & dist(D2,P)[source(entregador2)] & dist(D3,P)[source(entregador3)] & D1 < D2 & D1 < D3 & pacote(P,origem(XO,YO),destino(XD,YD))
    <-  .print("Pedindo para entregador1 levar ", P);
        !limpa_dist(P);
        .send(entregador1,tell,pacote(P,origem(XO,YO),destino(XD,YD)));
        .send(entregador1,achieve,entrega).

+!mais_proximo(P) : dist(D2,P)[source(entregador2)] & dist(D3,P)[source(entregador3)] & D2 < D3 & pacote(P,origem(XO,YO),destino(XD,YD))
    <- .print("Pedindo para entregador2 levar ", P);
        !limpa_dist(P);
        .send(entregador2,tell,pacote(P,origem(XO,YO),destino(XD,YD)));
        .send(entregador2,achieve,entrega).

+!mais_proximo(P) : dist(D2,P)[source(entregador2)] & dist(D3,P)[source(entregador3)] & D3 < D2 & pacote(P,origem(XO,YO),destino(XD,YD))
    <- .print("Pedindo para entregador3 levar ", P);
        !limpa_dist(P);
        .send(entregador3,tell,pacote(P,origem(XO,YO),destino(XD,YD)));
        .send(entregador3,achieve,entrega).

+!mais_proximo(P) : pacote(P,origem(XO,YO),destino(XD,YD))
    <- .print("Aguaradando disponibilidade");
        !limpa_dist(P);
        .wait(5000);
        +pacote(P, XO, YO, XD, YD);
        !entrega(P).

+!limpa_dist(P) : true
    <-  //.wait(10000);
        -dist(D1,P)[source(entregador1)];
        -dist(D2,P)[source(entregador2)];
        -dist(D3,P)[source(entregador3)];
        -pacote(P, origem(XO,YO), destino(XD,YD)).