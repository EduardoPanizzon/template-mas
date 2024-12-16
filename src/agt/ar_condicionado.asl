// Agent gui in project aula10

/* Initial beliefs and rules */

/* Initial goals */

!inicializar_AC.

+!inicializar_AC
  <- 	makeArtifact("ac_quarto","artifacts.ArCondicionado",[],D);
  	   	focus(D);
  	   	!definir_temperatura;
  	   	!!climatizar.

+alterado : temperatura_ambiente(TA) & temperatura_ac(TAC)
  <-  .drop_intention(climatizar);
  	  .print("Houve interação com o ar condicionado!");
  	  .print("Temperatura Ambiente: ", TA);
 	  .print("Temperatura Desejada: ", TAC);
  	  !!climatizar.
      
+closed  <-  .print("Close event from GUIInterface").
   
 +!definir_temperatura: temperatura_ambiente(TA) & temperatura_ac(TAC) 
 			& temperatura_de_preferencia(User,TP) & TP \== TD & ligado(false)
 	<-  definir_temperatura(TP);
 		.print("Definindo temperatura baseado na preferência do usuário ", User);
 		.print("Temperatura: ", TP);
		!!climatizar.
 	
 +!definir_temperatura: temperatura_ambiente(TA) & temperatura_ac(TAC) & ligado(false)
 	<-  .print("Usando última temperatura");
 		.print("Temperatura: ", TAC).
 		
 		
 +!climatizar: temperatura_ambiente(TA) & temperatura_ac(TAC) & TA \== TAC & ligado(false)
 	<-   ligar;
 		.print("Ligando ar condicionado...");
 		.print("Temperatura Ambiente: ", TA);
 		.print("Temperatura Desejada: ", TAC);
 		.wait(1000);
 		!!climatizar.
 		
 +!climatizar: temperatura_ambiente(TA) & temperatura_ac(TAC) & TA \== TAC & ligado(true) 
 	<-  .print("Aguardando regular a temperatura de ", TA, " para ", TAC, "...");
 		.wait(4000);
 		!!climatizar.
 		 	
  +!climatizar: temperatura_ambiente(TA) & temperatura_ac(TAC) & TA == TAC & ligado(true) 
 	<-   desligar;
 		.print("Desligando ar condicionado...");
 		.print("Temperatura Ambiente: ", TA);
 		.print("Temperatura Desejada: ", TAC).

 +!climatizar 
 	<- 	.print("Não foram implementadas outras opções.");
 		.print("Temperatura regulada.").

+!desligar_ac: ligado(true)
	<-	desliga;
		.print("Desligando!").

+!desligar_ac: true
	<-	.print("Desligado!").

+!invasor_mode: invasor(true)
	<-	.print("bip");
		definir_temperatura(15);
		!climatizar;
		.wait(15000);
		.print("bip");
		definir_temperatura(30);
		!climatizar;
		.wait(15000);
		!invasor_mode.

+!invasor_mode: true
	<-	.print("Parando o AC");
		definir_temperatura(24).

+!seguro : true	
	<-	-invasor(true)[source(_)].