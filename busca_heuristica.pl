% Grupo: Marjori Pomarole, TODO
%
% Busca Heurística
% Usando Best fit algorithm.
% 

cenarioBase(Plataformas) :-
  solucao([], 15, Plataformas).

cenario1(Plataformas) :-
  solucao([10, 4, 2, 5, 15, 3, 2, 7], 15, Plataformas).

% Temos N números de containers sobrando para serem colocados.
% solucao(Containers, PesoMaxPlataforma, Plataformas).
solucao([], PesoMax, plataforma(PesoMax, [])).
solucao([container(X)|Resto], PesoMax, Plataformas) :-
  colocarNasPlataformas(Plataformas, container(X), PesoMax, Melhor).

% A melhor plataforma com peso máximo é a que consegue
% adicionar o container e tem o menor número de capacidade restante.
% colocarNasPlataformas(Plataformas, Container, PesoMax, NovaPlataformas).
colocarNasPlataformas([], Container, PesoMax, [plataforma(PesoMax, [Container])]).
%colocarNasPlataformas([P|Ps], Container, PesoMax, NovaPs) :-
  %P is plataforma(PesoMax, [Container|Cs])
  %plataformaMaisPesada(P, [P|PS]

% Encontra Plataforma com maior peso de carga
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
plataformaMaisPesada([P|Ps], _, MaiorP) :-
  plataformaMaisPesada(Ps, _, MaiorP).

% Dado uma lista de containers, retorna a soma de seus pesos.
% somarContainers(Containers, Soma)
% Onde Containers = [containers(X), containers(X1)...]
somarContainers([], 0).
somarContainers([container(X)], X) :- !.
somarContainers([container(X)|Resto], Soma) :-
  somarContainers(Resto, SomaR),
  Soma is X + SomaR.

container(Peso) :- Peso @> 0, Peso @< 100.

% Uma plataforma tem um peso máximo e N containers com pesos.
% Soma dos containers é menor que o peso máximo.
plataforma(0, []).
plataforma(Peso, Containers) :-
  somarContainers(Containers, Soma),
  Soma @=< Peso. 
