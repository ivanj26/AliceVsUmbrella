/* Nama File : K02_Alice_vs_Umbrella.pl */
/* Alice vs The Umbrella Corperation */

/* Deklarasi Fakta */
list(armory, [sword, poison, maps]).
list(infirmary, [medicine, food, drink]).
list(outer_castle, [zombie, knight]).
list(mount_doom, [spell_of_resurruction]).
list(garden, [zombie, knight]).
list(village, [zombie, food, knight, medicine, poison]).
list(way, [i,j,k,l]).

/* Basic rules */
writeln(X) :- write(X), nl.
isMember(X, [X|_]).
isMember(X, [Y|Z]) :- X\==Y, isMember(X,Z).
delElmt(_,[],[]).
delElmt(X,[X|Xs],Xs).
delElmt(X,[Y|Xs],[Y|Ys]) :- X\==Y, delElmt(X,Xs,Ys).
addElmt(X, Y, [X|Y]).	
isLocation(X) :- list(location, List), isMember(X, List).
objectLoc(X, Y) :- list(Y, List), isMember(X, List).

/* Implementasi run */
run(look) :- look, nl, !. /* */
run(help) :- help, nl, !. /* */
run(quit) :- quit, writeln(''), !. /* */
run(maps) :- maps, nl,!.
run(take(Obj)) :- take(Obj), nl, !.
run(drop(Obj)) :- drop(Obj), nl, !.
run(uses(Obj)) :- uses(Obj), nl, !.
run(attack) :- attack, nl, !.
run(status) :- status, nl, !.
run(save(FileName)) :- save(FileName), nl, !.
run(load(FileName)) :- load(FileName), nl, !.

/* Commands */
start:- writeln('Welcome to Alice vs Umbrella Corp.!'),
		write(''),
		writeln('White Queen Kingdom has been invaded by Umbrella Corp.!'),
		writeln('Help Alice to meet Gandalf in Mount Doom!'),
		help,
		game_loop.

look :- game_loop.

help :- writeln('These are the available commands:'),
		writeln('- start. (start over the game!)'),
		writeln('- look. (look things around you)'),
		writeln('- help. (see available commands)'),
		writeln('- maps. (show map if you have one)'),
		writeln('- take(Obj). (pick up an object)'),
		writeln('- drop(Obj). (drop an object)'),
		writeln('- uses(Obj). (uses an object)'),
		writeln('- attack. (attack enemy that accross your path)'),
		writeln('- status. (display Alice status)'),
		writeln('- save(FileName). (save your game)'),
		writeln('- load(FileName). (load previously saved game)'),
		writeln('- quit. (quit the game)'),
		game_loop.

maps :- game_loop.

take(Obj) :- game_loop.

drop(Obj) :- game_loop.

uses(Obj) :- game_loop.

attack	:- game_loop.

status :- game_loop.

save(FileName) :- game_loop.

load(FileName) :- game_loop.

quit :- write('').

/* Game loop */
game_loop   :- repeat,
			write('<command>  '), 
			read(X),
			run(X),
			(X==quit), !. /*condition stop in this line */