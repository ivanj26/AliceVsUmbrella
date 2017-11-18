/* Nama File : K02_Alice_vs_Umbrella.pl */
/* Alice vs The Umbrella Corperation */

/*
Anggota kelompok :
	1.
	2.
	3.
	4.
*/

/*Dynamics fact disini itu fact bisa berubah2 seiring berjalan game
*Untuk player position ,look, dll yang berhubungan sama map itu belum bisa dibikin
*/
:- use_module(library(random)).
:- dynamic(player_pos/2, item/2, ingamestate/1, bag/1, health/1, hunger/1, thirsty/1, weapon/1).

/*Inisialisasi game
* 0 = belum mulai permainan | udah mati, 1 = hidup | sedang bermain
*/
ingamestate(0). 

/***** Deklarasi Fakta *****/
place(0, openfield).
place(1, openfield).
place(2, garden).
place(3, armory).
place(4, openfield).
place(5, forest).
place(6, cave).
place(7, lake).

/*locate
* Perhitungan : x mod 5 = 0<=a<=4 , y mod 4 = 0<=b<=3,0<= a+b <=7 
* Misal ->  a = openfield, b = lake, dst
*/
locate(X, Y, Place) :- A is X mod 5, B is Y mod 4, N is A+B, place(N, Place).

/* Game loop */
game_loop   :- ingamestate(1),
			repeat,
			write('<command>  '), 
			read(X),
			run(X),
			(X==quit), !.

/* Path (from - to)*/

/* Basic rules */
writelist([]):- nl.
writelist([H|T]):- write('> '), write(H),nl,writelist(T).
writeln(X) :- write(X), nl.
isMember(X, [X|_]).
isMember(X, [Y|Z]) :- X\==Y, isMember(X,Z).
delElmt(_,[],[]).
delElmt(X,[X|Xs],Xs).
delElmt(X,[Y|Xs],[Y|Ys]) :- X\==Y, delElmt(X,Xs,Ys).
addElmt(X, Y, [X|Y]).	
isLocation(X) :- list(location, List), isMember(X, List).
objectLoc(X, Y) :- list(Y, List), isMember(X, List).

/***** Implementasi run command from input *****/
run(look) :- look, nl, !. /* */
run(help) :- help, nl, !. /* */
run(quit) :- quit, nl, !. /* */
run(maps) :- maps, nl,!.
run(take(Obj)) :- take(Obj), nl, !.
run(drop(Obj)) :- drop(Obj), nl, !.
run(use(Obj)) :- use(Obj), nl, !.
run(start) :- start, nl,  !.
run(attack) :- attack, nl, !.
run(status) :- status, nl, !.
run(save(FileName)) :- save(FileName), nl, !.
run(load(FileName)) :- load(FileName), nl, !.

/***** Commands *****/
start:- writeln('Welcome to Alice vs Umbrella Corp.!'),
		writeln('White Queen Kingdom has been invaded by Umbrella Corp.!'),
		writeln('Help Alice to defeat the invaders!'),
		help,
		restartgame,
		asserta(item(lake,[water, meat, axe])),
		asserta(item(openfield,[])),
		asserta(item(armory,[sword, medicine])),
		asserta(item(garden,[hoe,banana])),
		asserta(item(forest,[pig,honey])),
		asserta(item(cave,[bandage,spear])),
		random(0, 10, X), /*random Alice (X position)*/
 		random(0, 20, Y), /*random Alice (Y position)*/
		asserta(player_pos(X,Y)),
		asserta(health(100)),
		asserta(hunger(100)),
		asserta(thirsty(100)),
		asserta(weapon([])),
		asserta(bag([])),
		retract(ingamestate(_)),
		asserta(ingamestate(1)),
		game_loop.

restartgame :- 
		retract(ingamestate(_A)),
		asserta(ingamestate(0)),
		retract(player_pos(_X,_Y)),
		retract(bag(_C)),
		retract(item(openfield,_)),
		retract(item(lake,_)),
		retract(item(armory,_)),
		retract(item(garden,_)),
		retract(item(cave,_)),
		retract(item(forest,_)),
		retract(health(_D)),
		retract(hunger(_E)),
		retract(thirsty(_F)),
		retract(weapon(_G)), !.
		restartgame.

look :- ingamestate(1),
		player_pos(X, Y),
		locate(X, Y, Place),nl,
		item(Place, ItemList),
		write('You are in '), write(Place), write('.'), nl, 
		writeln('Items in this place is/are '), writelist(ItemList), !. 

help :- writeln('These are the available commands:'),
		writeln('- start.          = start the game.'),
		writeln('- n. e. w. s.     = go to somewhere (follow compass rules).'),
		writeln('- look.           = look things around you.'),
		writeln('- help.           = see available commands.'),
		writeln('- maps.           = show map if you have one.'),
		writeln('- take(Obj).      = pick up an object.'),
		writeln('- drop(Obj).      = drop an object.'),
		writeln('- use(Obj)        = use an object.'),
		writeln('- attack.         = attack enemy that accross your path.'),
		writeln('- status.         = display Alice status.'),
		writeln('- save(FileName). = save your game.'),
		writeln('- load(FileName). = load previously saved game.'),
		writeln('- quit.           = quit the game.'),
		writeln('Legends : '),
		writeln('W = Water'),
		writeln('M = Medicine'),
		writeln('F = Food'),
		writeln('@ = Weapon'),
		writeln('A = Alice'),
		writeln('E = Enemy'),
		writeln('# = Inaccesible'),
		writeln('- = Accesible').

maps :- write('').

take(Obj) :- write('').

drop(Obj) :- write('').

use(Obj) :- write('').

attack	:- write('').

status :- ingamestate(1),
		weapon(WeaponList),
		health(HP),
		thirsty(T),
		bag(BagList),
		write('Health    = '), writeln(HP),
		write('Thirsty   = '), writeln(T),
		writeln('Weapon    = '), writelist(WeaponList),
		writeln('Inventory = '), writelist(BagList),!.

save(FileName) :- write('').

load(FileName) :- write('').

quit :- write('Alice gives up to the zombies. Game over.'), halt.

/*go_to another place with direction*/

go_to(Direction) :- 
			ingamestate(1), 
			player_pos(Here),
			path(Here, Direction, There),
			retract(player_pos(Here)),
			asserta(player_pos(There)).

go_to(_) :- ingamestate(1), 
			writeln('There is no place there or your inputs wrong. Undefined!.').

go_to(_) :- ingamestate(0), 
			writeln('You must start the game first!').

n :- go_to(n).
s :- go_to(s).
w :- go_to(w).
e :- go_to(e).