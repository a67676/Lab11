start :-
    nl,
    write('Hi, This is the "Name Game".'), nl,
    write('You will be given a set of English letters in which you will add, delete or move to create your name.'), nl,
    menu([a, b, c]).

menu(List) :-
    nl,
    write('Choose from the following:'), nl,
    write('1- Display the current set of letters'), nl,
    write('2- Add a letter'), nl,
    write('3- Add a letter at the top'), nl,
    write('4- Add a letter at the bottom'), nl,
    write('5- Delete a letter'), nl,
    write('6- Delete all letters'), nl,
    write('7- Exit'), nl,
    write('Enter your choice....'), nl,
    read(Choice),
    option(Choice, List).

% 1- Display
option(1, List) :-
    write('Current set of letters: '), write(List), nl,
    menu(List).

% 2- Add a letter at a chosen position
option(2, List) :-
    write('Enter the letter: '), read(X),
    write('Enter the position: '), read(N),
    add_at_position(X, N, List, NewList),
    menu(NewList).

% 3- Add at the top
option(3, List) :-
    write('Enter the letter: '), read(X),
    menu([X|List]).

% 4- Add at the bottom
option(4, List) :-
    write('Enter the letter: '), read(X),
    add_at_the_end(X, List, NewList),
    menu(NewList).

% 5- Delete a letter
option(5, List) :-
    write('Enter the letter to delete: '), read(X),
    remove_letter(X, List, NewList),
    menu(NewList).

% 6- Delete all
option(6, _) :-
    write('All letters deleted.'), nl,
    menu([]).

% 7- Exit
option(7, List) :-
    write('Your final set of letters: '), write(List), nl,
    write('Goodbye!'), nl.

% Anything else
option(Choice, List) :-
    \+ member(Choice, [1,2,3,4,5,6,7]),
    write('Invalid choice, try again.'), nl,
    menu(List).



add_at_the_end(X, [], [X]).
add_at_the_end(X, [H|Tail], [H|Result]) :-
    add_at_the_end(X, Tail, Result).

insert_at(X, 1, List, [X|List]).
insert_at(X, N, [H|Tail], [H|Result]) :-
    N > 1,
    N1 is N - 1,
    insert_at(X, N1, Tail, Result).

add_at_position(X, N, List, NewList) :-
    length(List, Len),
    Max is Len + 1,
    N >= 1, N =< Max,
    insert_at(X, N, List, NewList).
add_at_position(_, N, List, List) :-
    length(List, Len),
    Max is Len + 1,
    \+ (N >= 1, N =< Max),
    write('Invalid position.'), nl.

delete_first(X, [X|Tail], Tail).
delete_first(X, [Y|Tail], [Y|Result]) :-
    X \= Y,
    delete_first(X, Tail, Result).

remove_letter(X, List, NewList) :-
    member(X, List),
    delete_first(X, List, NewList).
remove_letter(X, List, List) :-
    \+ member(X, List),
    write('Letter not found.'), nl.
