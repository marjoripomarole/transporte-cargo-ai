% Grupo: 
% Bruno Ricardo Siqueira 4953672
% Lucas Macedo De Lemos 6920122
% Marjori Pomarole NUSP
% Rosaldo Alves 6309280
%
% Gerador automatizado de cenários.

generateContainers(Num,Set) :-
	Num = 1,
	randset(2,500,S),
	append([S], [], Set).

generateContainers(N1,Set) :-
	N2 is N1 - 1,
	generateContainers(N2,S1),
	randset(2,500,S2),
	append(S1, [S2], Set).