% Grupo: 
% Bruno Ricardo Siqueira 4953672
% Lucas Macedo De Lemos 6920122
% Marjori Pomarole 7152013
% Rosaldo Alves 6309280
%
% Busca não informada: usando o algoritmo de busca em profundidade.

% aumentando tamanho máximo da pilha para 2GB
:- set_prolog_stack(global, limit(2 000 000 000)).
:- set_prolog_stack(trail,  limit(2 000 000 000)).
:- set_prolog_stack(local,  limit(2 000 000 000)).

% Cálculo do valor acumulado de pesos
cumulativeWeight([], 0).
cumulativeWeight([Head|Tail], TotalSum) :-
    cumulativeWeight(Tail, Sum),
    TotalSum is Head + Sum.
% ------------

% Gerador automatizado de cenários.
generateContainers(Num,Range,Set) :-
	Num = 1,
	randset(1,Range,S),
	append(S,[],Set), !.
generateContainers(N1,Range,Set) :-
	N2 is N1 - 1,
	generateContainers(N2,Range,S1),
	randset(1,Range,S2),
	append(S1,S2,Set).
% ------------

% Gerador automatizado de cenários.
% Busca em largura cenário 1: 2 containers de peso 5 e 4, peso máximo
% suportado pelas plataformas 10.
depthFirst(Head,[Head]) :-
	final(Head).
depthFirst(Head, [Head|Tail]) :-
	s(Head, H1),
	depthFirst(H1, Tail).
s(Head, H1) :-
	edge(Head, H1).

% colocando o primeiro container
edge([[],[]], [[5],[]]).
edge([[],[]], [[],[5]]).
edge([[],[]], [[4],[]]).
edge([[],[]], [[],[4]]).

% colocando o segundo container
edge([[5],[]], [[5],[4]]).
edge([[5],[]], [[5,4],[]]).
edge([[],[5]], [[4],[5]]).
edge([[],[5]], [[],[5,4]]).
edge([[4],[]], [[4],[5]]).
edge([[4],[]], [[4,5],[]]).
edge([[],[4]], [[5],[4]]).
edge([[],[4]], [[],[4,5]]).

%final([[5,4],[]]).
final([[],[5,4]]).