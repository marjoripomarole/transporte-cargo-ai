% Grupo: Marjori Pomarole, TODO
%
% Busca Heurística
% Usando Best fit algorithm.
% 

cenarioBase(Plataformas) :-
  solucao([], 15, Plataformas).

cenario1(_) :-
  solucao([container(10)], 15, [plataforma(15, [container(10)])]).

cenario2(P) :-
  % P = [plataforma(15, [container(1), container(1)])],
  solucao([container(1), container(1)], 15, P).

cenario3(_) :-
  solucao([container(14), container(2)], 15, [plataforma(15, [container(14)]), plataforma(15, [container(2)])]).

cenario10(Plataformas) :-
  solucao([container(10), container(4), container(2), container(5), container(15),
           container(3), container(2), container(7)], 15, Plataformas).

% Temos N números de containers sobrando para serem colocados.
% solucao(Containers, PesoMaxPlataforma, Plataformas).
solucao([], _, []).
solucao([Container|Resto], PesoMax, Plataformas1) :-
  % write('P1 '), write(Plataformas1), nl, 
  solucao(Resto, PesoMax, Plataformas),
  colocarNasPlataformas(Plataformas, Container, PesoMax, Plataformas1).

% A melhor plataforma é a que consegue
% adicionar o container e tem o menor número de capacidade restante.
% colocarNasPlataformas(Plataformas, Container, PesoMax, NovaPlataformas).
colocarNasPlataformas([], Container, PesoMax, [plataforma(PesoMax, [Container])]).
colocarNasPlataformas(Plataformas, Container, PesoMax, [NovaP|ListSem]) :-
  plataformaMaisPesada(Plataformas, PesoMax, MaiorP),
  MaiorP = plataforma(PesoMax, Cs),
  NovaP = plataforma(PesoMax, [Container|Cs]), % Nova plataforma com o container
  delete(Plataformas, MaiorP, ListSem), !.
colocarNasPlataformas(Plataformas, Container, PesoMax, NovaPs) :-
  write('this happens when heaviest platform is not ideal').

% Retorna a plataforma com best fit para o Container na lista de Plataformas.
% melhorPlataformaParaContainer(Plataformas, PesoMax, Container, MaiorP).
% $melhorPlataformaParaContainer([], PM, Container, plataforma(PM, [Container])).
% $melhorPlataformaParaContainer([P|Ps], _, Container, Melhor) :-

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
