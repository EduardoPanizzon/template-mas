
!inicializar_lampada.

+!inicializar_lampada
  <- 	makeArtifact("lampada_quarto","artifacts.Lampada",[],D);
  	   	focus(D);
  	   	!ligar_lampada.
  	   	
+interuptor 
  <-  !!verificar_lampada.
      
+closed  <-  .print("Close event from GUIInterface").
   
 +!verificar_lampada: ligada(false)  
 	<-  .print("Alguém DESLIGOU a Lâmpada").
 	
 +!verificar_lampada: ligada(true)  
 	<-  .print("Alguém LIGOU a Lâmpada").
 	
 +!ligar_lampada
 	<-  ligar;
 		.print("Liguei a Lâmpada!").

 +!desligar_lampada
 	<-  desligar;
 		.print("Desliguei a Lâmpada!").

+!invasor_mode: invasor(true)
	<-	!desligar_lampada;
		.wait(1500);
		!ligar_lampada;
		.wait(1500);
		!invasor_mode.

+!invasor_mode: true
	<-	!desligar_lampada.

+!seguro : true	
	<-	-invasor(true)[source(_)].