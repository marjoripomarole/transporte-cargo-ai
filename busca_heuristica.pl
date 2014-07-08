% Grupo: 
% Bruno Ricardo Siqueira 4953672
% Fernando Pereira Lisboa 7656241
% Lucas Macedo De Lemos 6920122
% Marjori Pomarole 7152013
% Rosaldo Alves 6309280
%
% Busca heurística: usando o algoritmo best first.

% solução: []
cenarioBase(P) :-
  solucao([], 15, P).

% solução: [plataforma(15, [container(10)])]
cenario1(P) :-
  solucao([container(10)], 15, P).

% solução: [plataforma(15, [container(1), container(1)])]
cenario2(P) :-
  solucao([container(1), container(1)], 15, P).

cenario4(P) :-
  solucao([container(4), container(5)], 10, P).

% solução: [plataforma(15, [container(2)]), plataforma(15, [container(14)])]
cenario3(P) :-
  solucao([container(14), container(2)], 15, P).

% solução: 
cenario10(P) :-
  solucao([container(10), container(4), container(2), container(5), container(15),
           container(3), container(2), container(7)], 15, P).

% Temos N números de containers sobrando para serem colocados.
% Plataformas é a lista de solução final.
% solucao(Containers, PesoMaxPlataforma, Plataformas).
solucao([], _, []).
solucao([Container|Resto], PesoMax, Plataformas1) :-
  solucao(Resto, PesoMax, Plataformas),
  colocarNasPlataformas(Plataformas, Container, PesoMax, Plataformas1).

% Coloca Container na lista de Plataformas e retorna na Nova Plataformas.
% A melhor plataforma é a que consegue
% adicionar o container e tem o menor número de capacidade restante.
% colocarNasPlataformas(Plataformas, Container, PesoMax, NovaPlataformas).
colocarNasPlataformas([], Container, PesoMax, [plataforma(PesoMax, [Container])]).
colocarNasPlataformas(Plataformas, Container, PesoMax, NovaPlataformas) :-
  plataformaMaisPesada(Plataformas, PesoMax, MaiorP),
  MaiorP = plataforma(PesoMax, Cs),
  (
    plataforma(PesoMax, [Container|Cs]) ->
      NovaP = plataforma(PesoMax, [Container|Cs]),
      delete(Plataformas, MaiorP, ListSem),
      NovaPlataformas = [NovaP|ListSem]

  ;   delete(Plataformas, MaiorP, ListaSem),
      colocarNasPlataformas(ListaSem, Container, PesoMax, NovaPlataformas1),
      NovaPlataformas = [MaiorP|NovaPlataformas1], !
  ).
  
% Encontra Plataforma mais pesada.
% plataformaMaisPesada(Plataformas, PesoMax, MaiorP)
plataformaMaisPesada([], PM, plataforma(PM, [])).
plataformaMaisPesada([P], _, P) :- !.
plataformaMaisPesada([MaiorP|Ps], PM, MaiorP) :-
  plataformaMaisPesada(Ps, PM, MaiorP1),
  MaiorP = plataforma(_, Containers),
  MaiorP1 = plataforma(_, Containers1),
  somarContainers(Containers, Soma),
  somarContainers(Containers1, Soma1),
  Soma >= Soma1, !.
plataformaMaisPesada([_|Ps], _, MaiorP) :-
  plataformaMaisPesada(Ps, _, MaiorP).

% Dado uma lista de containers, retorna a soma de seus pesos.
% somarContainers(Containers, Soma)
% Onde Containers = [containers(X), containers(X1)...]
somarContainers([], 0).
somarContainers([container(X)], X) :- !.
somarContainers([container(X)|Resto], Soma) :-
  somarContainers(Resto, SomaR),
  Soma is X + SomaR.

container(Peso) :- Peso @> 0.

% Uma plataforma tem um peso máximo e N containers com pesos.
% Soma dos containers é menor que o peso máximo.
plataforma(0, []).
plataforma(PesoMax, Containers) :-
  somarContainers(Containers, Soma),
  Soma @=< PesoMax. 
