% Grupo: 
% Bruno Ricardo Siqueira 4953672
% Lucas Macedo De Lemos 6920122
% Marjori Pomarole NUSP
% Rosaldo Alves 6309280
%
% Gerador automatizado de containers.
generateContainers(Num,Range,Set) :-
	Num = 1,
	randset(1,Range,S),
	append(S,[],Set), !.
generateContainers(N1,Range,Set) :-
	N2 is N1 - 1,
	generateContainers(N2,Range,S1),
	randset(1,Range,S2),
	append(S1,S2,Set).

% Exemplo de uso:
% ? - generateContainers(3,15, Set).
% Set = [[12, 14], [8, 12], [5, 13]].