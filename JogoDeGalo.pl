/*------------------------------Start the table of game----------*/

iniciatabuleiro([
		[0,0,0],
		[0,0,0],
		[0,0,0]
		]).

/*--------------------------------------------------------------------*/

/*Verify if is member*/

member(X,[X|L]).
member(X,[Y|L]):- X \== Y,
		member(X,L).



/*------------------------------ALTERAR O JOGO------------------------*/
 
 alterar(O,J,L,L1):- coordenadas(O,Li,Co),
		  alterar_aux(Li,Co,J,L,L1).

 alterar_aux(1,1,J,[[X|L],A,B],[[J|L],A,B]):- X =:= 0.
 alterar_aux(1,2,J,[[X,Y|L],A,B],[[X,J|L],A,B]):- Y =:= 0.
 alterar_aux(1,3,J,[[X,Y,Z],A,B],[[X,Y,J],A,B]):- Z =:= 0.
 alterar_aux(2,1,J,[A,[X|L],B],[A,[J|L],B]):- X =:= 0.
 alterar_aux(2,2,J,[A,[X,Y|L],B],[A,[X,J|L],B]):- Y =:= 0.
 alterar_aux(2,3,J,[A,[X,Y,Z],B],[A,[X,Y,J],B]):- Z =:= 0.
 alterar_aux(3,1,J,[A,B,[X|L]],[A,B,[J|L]]):- X =:= 0.
 alterar_aux(3,2,J,[A,B,[X,Y|L]],[A,B,[X,J|L]]):- Y =:= 0.
 alterar_aux(3,3,J,[A,B,[X,Y,Z]],[A,B,[X,Y,J]]):- Z =:= 0.


/*---- OBER AS COORDENADAS DA LINHA E COLUNA -----*/

coordenadas([W,Y],W,Y).

/*------------------------------TESTAR O JOGO------------------------*/
teste(L,V):- testevenc(L,V,V1),
	        jogador(V1,L,L1).


/*VENCEDOR JOGADOR*/
 testevenc([[1,1,1],A,B],1,4).
 testevenc([A,[1,1,1],B],1,4). 
 testevenc([A,B,[1,1,1]],1,4).
 testevenc([[1,X,Y],[1,X1,Y1],[1,X2,Y2]],1,4).
 testevenc([[X,1,Y],[X1,1,Y1],[X2,1,Y2]],1,4).
 testevenc([[X,Y,1],[X1,Y1,1],[X2,Y2,1]],1,4).
 testevenc([[1,X,Y],[X1,1,Y1],[X2,Y2,1]],1,4).
 testevenc([[X,Y,1],[X1,1,Y1],[1,X2,Y2]],1,4).

/*VENCEDOR COMPUTADOR*/
 testevenc([[2,2,2],A,B],2,5).
 testevenc([A,[2,2,2],B],2,5). 
 testevenc([A,B,[2,2,2]],2,5).
 testevenc([[2,X,Y],[2,X1,Y1],[2,X2,Y2]],2,5).
 testevenc([[X,2,Y],[X1,2,Y1],[X2,2,Y2]],2,5).
 testevenc([[X,Y,2],[X1,Y1,2],[X2,Y2,2]],2,5).
 testevenc([[2,X,Y],[X1,2,Y1],[X2,Y2,2]],2,5).
 testevenc([[X,Y,2],[X1,2,Y1],[2,X2,Y2]],2,5).

/*JOGO EMPATADO OU PROXIMO JOGADOR*/

 testevenc([],X,3).
 testevenc([1],1,2).
 testevenc([2],2,1).

 testevenc([W|L],X,X1):- member(0,W),
			X =:= 1,
			X1 is 2,
		 	testevenc([1],X,X1).

 testevenc([W|L],X,X1):- member(0,W),
			X =:= 2,
			X1 is 1,
			testevenc([2],X,X1).

 testevenc([W|L],X,X1):- \+ member(0,W),
			 testevenc(L,X,X1).


/*------------------------------JOGADOR------------------------------*/

utilizador(L,L1):- write('Coloque as coordenadas no formato [linha,coluna]'),
		   read(O),
		   alterar(O,1,L,L1),
		   imprimetabuleiro(L1),
		   teste(L1,1).

/*------------------------------COMPUTADOR------------------------------*/
computador(L,L1):- sucessor(L,2,1,L,Suc),
		     escolheMelhor(1,18,2,Suc,Coo,Mval),
		     alterar(Coo,2,L,L1),		     
		     imprimetabuleiro(L1),
		     teste(L1,2).


outrojogador(1,2).
outrojogador(2,1).


avaliatabuleiro(J,L,[Li,Co],Val):- aval_horizontal(J,L,Li,1,V2),
				   aval_vertical(J,L,Co,V2,V3),
				   aval_diagonal(J,L,Li,Co,V3,Val).


aval_horizontal(J,[[X,Y,Z],B,C],Li,V1,V3):- Li =:= 1,
                                            avalia(J,X,Y,Z,V2),
 				            compara_val(V1,V2,V3).

aval_horizontal(J,[A,[X,Y,Z],C],Li,V1,V3):- Li =:= 2,
                                            avalia(J,X,Y,Z,V2),
 				            compara_val(V1,V2,V3).

aval_horizontal(J,[A,B,[X,Y,Z]],Li,V1,V3):- Li =:= 3,
                                            avalia(J,X,Y,Z,V2),
 				            compara_val(V1,V2,V3).

				   				 
aval_vertical(J,[[X,Y,Z],[X1,Y1,Z1],[X2,Y2,Z2]],Co,V1,V3):- Co =:= 1,
							 avalia(J,X,X1,X2,V4),
						         compara_val(V1,V4,V3).

aval_vertical(J,[[X,Y,Z],[X1,Y1,Z1],[X2,Y2,Z2]],Co,V1,V3):- Co =:= 2,
							 avalia(J,Y,Y1,Y2,V4),
						         compara_val(V1,V4,V3).

aval_vertical(J,[[X,Y,Z],[X1,Y1,Z1],[X2,Y2,Z2]],Co,V1,V3):- Co =:= 3,
							 avalia(J,Z,Z1,Z2,V4),
						         compara_val(V1,V4,V3).



aval_diagonal(J,[[X,Y,Z],[X1,Y1,Z1],[X2,Y2,Z2]],Li,Co,V1,V3):- Li =:= 1,
							 Co =:= 1,
							avalia(J,X,Y1,Z2,V4),
						        compara_val(V1,V4,V3).
	
aval_diagonal(J,[[X,Y,Z],[X1,Y1,Z1],[X2,Y2,Z2]],Li,Co,V1,V3):- Li =:= 1,
							 Co =:= 3,
							avalia(J,Z,Y1,X2,V4),
						        compara_val(V1,V4,V3).

aval_diagonal(J,[[X,Y,Z],[X1,Y1,Z1],[X2,Y2,Z2]],Li,Co,V1,V3):- Li =:= 3,
							 Co =:= 3,
							avalia(J,X,Y1,Z2,V4),
						        compara_val(V1,V4,V3).
	
aval_diagonal(J,[[X,Y,Z],[X1,Y1,Z1],[X2,Y2,Z2]],Li,Co,V1,V3):- Li =:= 3,
							 Co =:= 1,
							avalia(J,Z,Y1,X2,V4),
						        compara_val(V1,V4,V3).
	
aval_diagonal(J,[[X,Y,Z],[X1,Y1,Z1],[X2,Y2,Z2]],Li,Co,V1,V3):- Li =:= 2,
							 Co =:= 2,
							avalia(J,Z,Y1,X2,V4),
						        compara_val(V1,V4,V5),
							avalia(J,X,Y1,Z2,V6),
						        compara_val(V5,V6,V3).	

aval_diagonal(J,[[X,Y,Z],[X1,Y1,Z1],[X2,Y2,Z2]],Li,Co,V1,V1).
			        

						   	
compara_val(A,B,A):- A =:= B.						       
compara_val(A,B,A):- A > B.
compara_val(A,B,B):- A < B.


				
avalia(J,1,1,0,20).
avalia(J,1,0,1,20).
avalia(J,0,1,1,20).

avalia(J,1,1,2,25).
avalia(J,2,1,1,25).
avalia(J,1,2,1,25).

avalia(J,2,2,0,20).
avalia(J,2,0,2,20).
avalia(J,0,2,2,20).

avalia(J,2,2,2,30).
avalia(J,1,1,1,30).

avalia(J,Z,A,B,10).

/*-----------------------melhor entre----------------------------------------*/
  
melhorEntre(J,Mov1,Val1,Mov2,Val2,Mov1,Val1):- Val1 > Val2.
melhorEntre(J,Mov1,Val1,Mov2,Val2,Mov1,Val1):- Val1 =:= Val2.
melhorEntre(J,Mov1,Val1,Mov2,Val2,Mov2,Val2):- Val1 < Val2.

/*-----------------------minimax---------------------------------------------*/

escolheMelhor(Prof,MaxProf,J,[[Mov,T]],Mov,Mval):- minimax(Prof,MaxProf,J,T,Mov,_,Mval),!.
escolheMelhor(Prof,MaxProf,J,[[Mov,T]|Suc],Mmov,Mval):- minimax(Prof,MaxProf,J,T,Mov,Mov1,Val1),!	,
						        escolheMelhor(Prof,MaxProf,J,Suc,Mov2,Val2),
						        melhorEntre(J,Mov1,Val1,Mov2,Val2,Mmov,Mval).

minimax(MaxProf,MaxProf,J,T,Mov,Mov,Mval):- avaliatabuleiro(J,T,Mov,Mval).
minimax(Prof,MaxProf,J,T,Mov,Mov,Mval):- Prof < MaxProf,
				      outrojogador(J,J1),
				      Prof1 is Prof + 1,
				      sucessor(T,J1,1,T,Suc),
				      %Suc = [],
		        	      avaliatabuleiro(J,T,Mov,Mval).

minimax(Prof,MaxProf,J,T,Mov,Mov,Mval):- Prof < MaxProf,
				      outrojogador(J,J1),
				      Prof1 is Prof + 1,
				      sucessor(T,J1,1,T,Suc),
				      Suc \== [],
				      escolheMelhor(Prof1,MaxProf,J1,Suc,Mmov,Mval).






/*------------------------------SUCESSOR------------------------------*/
sucessor(L,J,N,[A,A1,A2],Suc):-  
				  suc_aux(L,J,N,1,A,B),
                                  cria_suc(B,[],Suc1),
				  suc_aux(L,J,2,1,A1,B1),
				  cria_suc(B1,Suc1,Suc2),
				  suc_aux(L,J,3,1,A2,B2),
				  cria_suc(B2,Suc2,Suc).	

suc_aux(L,J,N,C,[],[]).
suc_aux(L,J,N,C,[X|L1],[[[N,C],L2]|Y]):- X =:= 0,
					C < 4, 
					alterar([N,C],J,L,L2),
					C1 is C + 1,
					suc_aux(L,J,N,C1,L1,Y).

suc_aux(L,J,N,C,[X|L1],Y):- X =\= 0,
			C < 4,
			C1 is C + 1,
			suc_aux(L,J,N,C1,L1,Y).


cria_suc(B,[],B).
cria_suc([],Suc,Suc).
cria_suc([X|B],Suc,[X|Suc1]):-cria_suc(B,Suc,Suc1).

imprimetabuleiro([]):-nl.
imprimetabuleiro([X|L]):-write(X),nl,imprimetabuleiro(L).

/*--------------------------------------------------------------------*/

/*------------------------------ESCOLHER O JOGADOR-------------------*/
jogador(1,L,L1):- utilizador(L,L1).
jogador(2,L,L1):- computador(L,L1).
jogador(3,L,L1):- write('Jogo empatado').
jogador(4,L,L1):- write('O utilzador venceu').
jogador(5,L,L1):- write('O computador venceu').

/*--------------------------------------------------------------------*/

/*------------------------------MENU PRINCIPAL-----------------------*/
inicio:- iniciatabuleiro(L),
	 nl,nl,
	 write('Jogo do Galo'),nl,
	 write('Quem vai jogarprimeiro:'),nl,
	 write('1 - Utilizador'),nl,
	 write('2 - Computador'),nl,
	 read(Opcao),
	 jogador(Opcao,L,L1).
	
/*--------------------------------------------------------------------*/	
