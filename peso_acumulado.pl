% Grupo: 
% Bruno Ricardo Siqueira 4953672
% Lucas Macedo De Lemos 6920122
% Marjori Pomarole NUSP
% Rosaldo Alves 6309280
%
% Cálculo do valor acumulado de pesos.
cumulativeWeight([], 0).
cumulativeWeight([Head|Tail], TotalSum) :-
    cumulativeWeight(Tail, Sum),
    TotalSum is Head + Sum.