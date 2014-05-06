transporte-cargo-ai
===================


#### TODO
- Explicação extensa da solução não informada com justificativa de complexidade;
- As justificativas da solução não informada;

## Cenário
  
Necessidade de transportar containers utilizando uma plataforma de transporte 
do porto respeitando sua restrição de capacidade no menor número de viagens 
possíveis para o navio cargueiro.

## Especificação do Problema

A plataforma de transporte possui restrições quanto ao peso máximo
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

O **estado inicial** do problema é uma lista de containers com diferentes pesos
e uma lista vazia de plataformas.

Uma **plataforma** tem uma restrição de peso máximo e pode suportar N containers,
contato que a soma dos pesos dos N containers seja menor ou igual ao peso máximo.

O **estado final** resulta na lista de containers vazia e a lista de plataforma
completa com o menor número de plataformas que consigam levar os containers da
primeira lista.

## Implementação 

### Busca Não Informada

O algoritmo utilizado é o de **Busca em Profundidade**. Como possibilidades estão todos
os estados que não violam a condição de peso máximo da plataforma. A busca deverá
encontrar o caminho (a ordem de colocação dos containers) que otimize a utilização das
plataformas.

Para exemplificar o problema de busca proposto, considere os seguintes cenários.

#### Cenário 1
* 2 containers com pesos 5 e 4, respectivamente.
* O peso máximo suportado pela plataforma é 10;

![Busca em Profundidade 01](http://brunoric.info/ia/busca_profundidade_img_01.png)
![Busca em Profundidade 02](http://brunoric.info/ia/busca_profundidade_img_02.png)


### Busca Heurística

Algoritmo greedy usado é o Best First.

A transição de um estado para o outro na busca representa a tentativa de colocar
um container dentro de uma plataforma. Essa escolha é informada pela soma total
do peso de cada container já dentro das plataformas. Sabendo dessa informação, o
algoritmo vai seguir para o próximo estado que coloca o container na plataforma
mais pesada que ainda suporta o peso do container em questão. Se não existir
nenhuma plataforma que mantenha esses critérios, a busca segue para o estado com
o container em outra plataforma.

A figura abaixo visualiza a transição de um estado para o outro. 

**Lc** representa a lista de containers que ainda precisam ser posicionados. Um
integer representa seu peso máximo.

**Lp** representa a lista de plataformas com seus containers.

No primeiro estado, imagem da esquerda, estamos tentando adicionar o container com
peso 12 em alguma plataforma. A plataforma com maior peso é a primeira, mas não
oferece espaço. A terceira plataforma é a próxima a ser avaliada e também é inválida
porque não tem espaço. O mesmo acontece com a segunda plataforma. Por causa dessa
heuristica, o unico caminho a ser seguido é de colocar o container em uma nova
plataforma. O próximo estado tem a plataforma tirada da lista Lc e colocada em uma
plataforma na lista Lp.

![Algoritmo Best Fit](http://atadosapp.s3.amazonaws.com/best-fit.png)

Se tivermos k containers para serem transportados. Mémoria usada sera O(k) e o
complexidade é O(k).

Esse algoritmo não promete sempre a solução perfeita de menor containers, pois depende
da ordem inicial da lista de containers. Mas oferece a melhor opção na maioria das vezes,
com resultados melhores que a heuristica usada pela outra alternativa, o algoritmo greedy
Best Fit. O best fit tenta colocar o container na primeira plataforma que ainda tem espaço
na lista. Mas nem sempre a plataforma primeira que tem espaço é melhor opção. A melhor
opção seria a que potencialmente vai diminuiar a criação de outra plataforma.

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
P = [plataforma(15, [container(15)]), plataforma(15, [container(2), container(3), 
container(2), container(7)]), plataforma(15, [container(4), container(5)]), plataforma(15, [container(10)])] 
```


