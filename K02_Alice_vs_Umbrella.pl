/* Nama File : K02_Alice_vs_Umbrella.pl */
/* Alice vs The Umbrella Corperation */

/* Game loop */
game_loop   :- repeat,
			write('<game console>'), 
			spasi(2),
			read(X),
			run(X),
			(X==quit), !.
            /*condition stop in this line */

/*Implementasi run */
run(look) :- look, nl, !.
run(help) :- help, nl, !.
run(quit) :- quit, writeln(''), !.
run(map) :- map, nl,!.
run(take(Obj)) :- take(Obj), nl, !.
run(drop(Obj)) :- drop(Obj), nl, !.
run(use(Obj)) :- use(Obj), nl, !.
run(attack) :- attack, nl, !.
run(status) :- status, nl, !.
run(save(FileName)) :- save(FileName), nl, !.
run(load(FileName)) :- load(FileName), nl, !.

/*Deklarasi Fakta*/
list(armory, [sword, poison, map]).
list(infirmary, [medicine, food, drink]).
list(outer_castle, [zombie, knight]).
list(mount_doom, [spell_of_resurruction]).
list(garden, [zombie, knight]).
list(village, [zombie, food, knight, medicine, poison]).
list(way, [n,e,s,w]).

connect(empty,infirmary).
connect(infirmary, armory).
connect(armory,outer_castle).
connect(outer_castle, garden).
connect(garden, village).
connect(village, mount_doom).
connect(mount_doom, empty).

/*Deklarasi Rules*/
instruction(look) :- look, nl, !.
instruction(take(object)) :- take(object), nl, !.
instruction(drop(object)) :- drop(object), nl, !.
instruction(use(object)) :- use(object), nl, !.
instruction(attack) :- attack, nl, !.
instruction(status) :- status, nl, !.
/* instruction(save) :- . */
/* instruction(load) :- . */
instruction(map) :- map, nl, !.
instruction(move(direction)) :- move(direction), nl, !.

isMember(X, [X|_]).
isMember(X, [Y|Z]) :- X\==Y, isMember(X,Z).

delElmt(_,[],[]).
delElmt(X,[X|Xs],Xs).
delElmt(X,[Y|Xs],[Y|Ys]) :- X\==Y, delElmt(X,Xs,Ys).

addElmt(X, Y, [X|Y]).	

isLocation(X) :- list(location, List), isMember(X, List).

objectLoct(X, Y) :- list(Y, List), isMember(X, List).

/*Rules*/
writeln(X) :- write(X), nl.

/* Commands */
start:- writeln('Welcome to the 77th Hunger Games!'),
		write('You have been chosen as one of the lucky contestants. '),
		writeln('Be the last man standing and you will be remembered as one of the victors.'),
		writeln('Available commands:'),
		writeln('- start. (start the game!)'),
		writeln('- quit. (quit the game)'),
		writeln(''),
		game_loop.

spasi(X) :- tab(X).

quit :- write('').