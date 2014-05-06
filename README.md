transporte-cargo-ai
===================

## Cenário
  
Necessidade de transportar containers pela plataforma de transporte do porto
em menor viagens possíveis para o navio cargueiro.

## Especificação do Problema

A plataforma de transporte possue restrições quanto ao peso máximo
transportado. Os containers variam em seus pesos.

Temos de buscar a melhor combinação entre os containers transportados por
uma determinada vez na plataforma, de forma que sempre sejam transportados
o maior número possível dos mesmos, garantindo um menor número de
viagens da plataforma e a segurança no transporte da mesma, isto é, não
podem ser ultrapassados a carga máxima especificados
pela plataforma de transporte.

Não há vantagem em transportar primeiro os containers mais leves,
deixando os mais pesados por último, pois no começo transportaremos o maior 
número possível de containers mas, no final, somente um pequeno número de
containers será transportado em função do excesso de peso.

## Modelagem de Estados

O **estado inicial** do problema é uma lista de containers com diferentes pesos e uma lista vazia de plataformas.

Uma **plataforma** tem uma restrição de peso máximo e pode suportar N containers, contanto que a soma dos pesos dos N containers seja menor ou igual ao peso máximo.

O **estado final** resulta na lista de containers vazia e a lista de plataforma completa com o menor número de plataformas que consigam levar os containers da primeira lista.


## Implementação 

### Busca Não Informada

Consiste em fazer uma Busca em Profundidade em todas as possíveis combinações
dos grupos de containers. Achar a permutação que não viola a restrição de peso
máximo em cada grupo e tem o menor número de grupos de containers (plataformas).

### Busca Heurística

Algoritmo guloso usado é o Best First.

A transição de um estado para o outro na busca representa a tentativa de colocar um container dentro de uma plataforma. Essa escolha é informada pela soma total do peso de cada container já dentro das plataformas. Sabendo dessa informação, o algoritmo vai seguir para o próximo estado que coloca o container na plataforma mais pesada que ainda suporta o peso do container em questão. Se não existir nenhuma plataforma que mantenha esses critérios, a busca segue para o estado com o container em outra plataforma.

A figura abaixo visualiza a transição de um estado para o outro. 

**Lc** representa a lista de containers que ainda precisam ser posicionados. Um integer representa seu peso máximo.

**Lp** representa a lista de plataformas com seus containers.

No primeiro estado, imagem da esquerda, estamos tentando adicionar o container com peso 12 em alguma plataforma. A plataforma com maior peso é a primeira, mas não oferece espaço. A terceira plataforma é a próxima a ser avaliada e também é inválida porque não tem espaço. O mesmo acontece com a segunda plataforma. Por causa dessa heuristica, o unico caminho a ser seguido é de colocar o container em uma nova plataforma. O próximo estado tem a plataforma tirada da lista Lc e colocada em uma plataforma na lista Lp.

![Algoritmo Best Fit](http://atadosapp.s3.amazonaws.com/best-fit.png)

Se tivermos k containers para serem transportados. Memória usada sera O(k<sup>p</sup>) e o complexidade é O(k<sup>p</sup>). Onde p é a profundidade do grafo.

Esse algoritmo não promete sempre a solução perfeita de menor containers, pois depende da ordem inicial da lista de containers. Mas oferece a melhor opção na maioria das vezes, com resultados melhores que a heurística usada pela outra alternativa, o algoritmo greedy First Fit. O first fit tenta colocar o container na primeira plataforma que ainda tem espaço na lista. Mas nem sempre a primeira plataforma que tem espaço é a melhor opção. A melhor opção seria a que potencialmente vai diminuiar a criação de outra plataforma.

### Como rodar

Linguagem: **prolog**

Compilador: **swi-prolog**

Em ambiente GNU/Unix com swipl instalado, rode:

```
swipl -f busca_nao_informada.pl
```

```
swipl -f busca_heuristica.pl
?- cenario10(P).
P = [plataforma(15, [container(15)]), plataforma(15, [container(2), container(3), container(2), container(7)]), plataforma(15, [container(4), container(5)]), plataforma(15, [container(10)])] 
```


