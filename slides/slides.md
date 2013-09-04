% Intro à Prolog
% Mog
% 4 septembre 2013 --- Nantes FP

# Introduction
## Introduction
### Kezako, Prolog ?
PROgrammation en LOGique :

- basé sur la logique du premier ordre
- déclaratif
- general purpose
- particulièrement bon pour des DFS

## Introduction
### Grosses différences par rapport au Haskell

- fonctions multi-valuées (relations)
- unification au lieu de pattern matching
- typage faible

# Logique
## Logique
### Logique du premier ordre

Formalisation permettant d'évaluer la validité d'énoncés.

Ressemble à : $\forall A\ \forall B\ \exists C\quad A → B\ ∨ C$

## Logique
### Ce qui nous intéresse

Algo automatique trivial de déduction si les formules ont certaines
propriétés (clauses de Horn) + hypothèse du monde clos :

```
A ← B ∧ C ∧ D ∨ E
B ← F
E ← G
```

Pour savoir si A est vrai, il suffit de regarder si l'une de ses
clauses (`B ∧ C ∧ D` ou `E`) est vraie, récursivement.

# Software
## Software
### Implémentations de Prolog

Parmi les grandes implémentations (tiré de SO) :

- [SWI-Prolog](http://www.swi-prolog.org/) (free)
- [SICStus](http://www.sics.se/sicstus/) (commercial)
- [GNU Prolog](http://www.gprolog.org/) (free)
- [ECLiPSe-CLP](http://eclipseclp.org/) (free)
- [Jekejeke Prolog](http://www.jekejeke.ch/) (commercial)
- …

## Software
### Pour aujourd'hui

On utilisera [SWI-Prolog](http://www.swi-prolog.org/) :

- beaucoup de modules
- développeur actif et qui répond vite sur la ML
- pas tout à fait standard mais pour de bonnes raisons
- multi-plateformes

## Software
### Le REPL Prolog 1/3
Une fois SWI-Prolog installé :

Dans un terminal, `swipl` ou `prolog` pour lancer le REPL

`Ctrl-d` ou `Ctrl-c` puis `e` pour le quitter.

Le prompt `?-` attend une _query_. Par exemple :

```prolog
?- Y is 3 * 2.
Y = 6.
```

## Software
### Le REPL Prolog 2/3

`?- [fichier].` charge `fichier.pl` dans le REPL.

`?- make.` recharge tous les fichiers déjà consultés qui ont été modifiés

Pour lancer automatiquement des tests après chargement :

```prolog
:- initialization(go).
go :-
	writeln('Hello World').
```

## Software
### Le REPL Prolog 3/3

Il est aussi possible d'entrer un programme à la main :

```prolog
?- [user].
test :-
|:	writeln('Hello World !').
|: % user://1 compiled 0.01 sec, 2 clauses
true.
```

`Ctrl-d` termine l'input. Test de notre programme :

```prolog
?- test.
Hello World !
true.
```

# Prolog, le langage
## Prolog, le langage
### Les termes de base

Ils varient selon les implémentations. Pour SWI :

- __atom__ ('an atom', 'Atom', atom)
- __string__ (\`une string comme en C`)
- __integer__ (1, 154, -42)
- __float__ (1.5, 0.1)

## Prolog, le langage
### Les termes composés 1/2

De la forme `a(b(c, d(e), f, g), h)`.

La liste vide s'écrit `[]`.

Les listes s'écrivent `'.'(Head, Tail)`.  
Par exemple, `1, 2, 3, 4` s'écrit :

```prolog
'.'(1,'.'(2,'.'(3,'.'(4,[]))))
```
Ou, avec le raccourci syntaxique `[Head|Tail]` :

```prolog
[1|[2|[3|[4|[]]]]]
```
Ou, avec le raccourci syntaxique `[Head|Tail]` :

```prolog
[1|[2|[3|[4|[]]]]]
```

## Prolog, le langage
### Termes composés 2/2
Ce raccourci syntaxique a un raccourci syntaxique :

```prolog
[1, 2, 3, 4]
```

Il est possible de mixer les deux :

```prolog
[1, 2, 3|A]
```

Les strings entre doubles quotes sont des listes de codes de caractères :

```prolog
?- write_canonical("Hai").
'.'(72,'.'(97,'.'(105,[])))
```

## Prolog, le langage
### Variables 1/3 : Affectation

L'affectation est __définitive__, comme en Haskell.


## Prolog, le langage
### Variables 2/3 : États

Une variable commence par une majuscule. 3 états principaux.

Libre : rien ne lui a été assigné. Par exemple, `X`.

Liée : ne contient pas de variable libre. Exemple, `X = [1, 2, 3]`.

Semi-liée : est partiellement liée, partiellement libre. Exemple, `X = [1, 2, A]` où `A` est libre.

## Prolog, le langage
### Variables 3/3 : Affectation

L'affectation est __définitive__ mais peut se préciser au cours du temps :

```prolog
?- A = a(B, C), B = lulz, C = [3|E], E = [3.14].
A = a(lulz, [3, 3.14]),
B = lulz,
C = [3, 3.14],
E = [3.14].
```

## Prolog, le langage
### Unification

L'unification est le PGCD de deux variables : si `A = [B, 3]` et `C =
[4, D]`, alors l'unification de `A` et `C` sera `B = 4` et `D = 3`.

Au lieu de PGCD on dit MGU pour Most General Unifier.

L'unification se fait uniquement en donnant des valeurs aux variables
libres d'une variable.

Des fois elle n'est pas possible.

## Prolog, le langage
### Faits

Un fait déclare ce qui est vrai tout le temps :

```prolog
dad(john, bob).
dad(jim, rita).
```

On peut dès maintenant poser des questions à Prolog :

```prolog
?- dad(john, bob).
?- dad(X, bob).
?- dad(john, X).
?- dad(X, Y).
```

<details>Practice time!</details>

## Prolog, le langage
### Clauses

Une clause est un fait avec une ou plusieurs conditions reliées par
`,` (__et__) ou `;` (__ou__) :

```prolog
white(michaelJackson) :-
	singer(michaelJackson),
	old(michaelJackson).
```

correspond à

```
white(michealJackson) ←
	singer(michaelJackson) ∧ old(michaelJackson)
```

## Prolog, le langage
### Prédicats

Un prédicat est un ensemble de clauses :

```prolog
white(michaelJackson) :- old(michaelJackson).
white(michaelJackson) :- ghost(michaelJackson).
```

Un prédicat correspond à la disjonction (le __ou__) de toutes ses
clauses.

## Prolog, le langage
### Exécution 1/3 Intro

Prolog essaye de rendre votre query __vraie__.

Il proposera toutes les solutions qu'il trouve :

```prolog
?- member(X, [1, 2, 3]).
X = 1 ;
X = 2 ;
X = 3.
```

`;` pour passer à la solution suivant et `.` pour arrêter là.

## Prolog, le langage
### Exécution 2/3 Non-déterminisme

Gestion des solutions multiples par stockage des points de choix.

Quand Prolog a besoin de la solution suivante, il repart du plus
ancien point de choix.

Parcourt du programme de haut en bas puis de gauche à droite.

## Prolog, le langage
### Exécution 3/3 Exemple

Puzzle time! Que produit la query `?- test(X).` ?

```prolog
test(X) :-
	member(X, [1, 2, 3]) ; X = a.

test(b).

test(X) :-
	X * X #= 25,
	label([X]).
```

## Prolog, le langage
### Récursion

Puzzle time bis <3

```prolog
dad(bob, luke).
dad(luke, anakin).
dad(anakin, someGuy).
dad(someGuy, adam).

ancestor(Person, Ancestor) :-
    dad(Person, Ancestor).

ancestor(Person, Ancestor) :-
    dad(Person, Dad),
    ancestor(Dad, Ancestor).
```

# Combo practice time!