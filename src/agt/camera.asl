proprietario("Eduardo").

!inicializar_camera.

+!inicializar_camera
  <- 	makeArtifact("camera_quarto","artifacts.Camera",[],D);
  	   	focus(D).
  	   	
+movimento 
  <-  !!verificar_pessoa.
      
+closed  <-  .print("Close event from GUIInterface").

 +!verificar_pessoa: pessoa_presente(P) & local(L) & proprietario(P) & L == "frente"
 	<-  .print("Dono: ", P, " reconhecida no local ", L, " da casa.");
      .send(ar_condicionado,tell,temperatura_de_preferencia(P,23));
      .send(ar_condicionado,achieve,definir_temperatura);
      .send(cortina,achieve,fechar_cortina);
      .send(lampada,achieve,ligar_lampada);
      .send(fechadura,achieve,abrir_porta).

 +!verificar_pessoa: pessoa_presente(P) & local(L) & proprietario(P) & L == "saida"
 	<-  .print("Dono: ", P, " reconhecida no local ", L, " da casa.");
      .send(ar_condicionado,achieve,desligar_ac);
      .send(cortina,achieve,fechar_cortina);
      .send(lampada,achieve,desligar_lampada);
      .send(fechadura,achieve,fechar_porta).

+!verificar_pessoa: pessoa_presente(P) & local(L) & proprietario(Q) & L == "dentro"
  <-  .print("Invasor: ", P, " detectado dentro da casa");
      .send(ar_condicionado,tell,invasor(true));
      .send(cortina,tell,invasor(true));
      .send(lampada,tell,invasor(true));
      .send(fechadura,tell,invasor(true));
      .send(ar_condicionado,achieve,invasor_mode);
      .send(cortina,achieve,invasor_mode);
      .send(lampada,achieve,invasor_mode);
      .send(fechadura,achieve,invasor_mode).

+!verificar_pessoa: pessoa_presente(P) & local(L) & proprietario(Q) & L == "saida"
  <-  .print("Invasor: ", P, " saiu da casa");
      .send(ar_condicionado,achieve,seguro);
      .send(cortina,achieve,seguro);
      .send(lampada,achieve,seguro);
      .send(fechadura,achieve,seguro).

 +!verificar_pessoa: pessoa_presente(P) & local(L)
 	<-  .print("Pessoa: ", P, " reconhecida no local ", L, " da casa.").