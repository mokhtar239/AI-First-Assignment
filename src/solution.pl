
% Load the library data
:- consult('library_data.pl').

% -----------------------TASK-2-----------------------------

% baseCase -> if no elements size of list is 0
count_list([] , 0 ).


% recursion to find size of list
count_list( [_|T] , N) :-
    count_list(T , N1) , 
    N is N1 + 1.

% baseCase -> if no students rest return empty list
collect_borrowers(_, [], []).

collect_borrowers(Book , [ Student | Rest ] , [ Student | Result ]) :-
    borrowed(Student , Book) ,
    ! , 
    collect_borrowers(Book , Rest , Result ).

collect_borrowers(Book , [ _ | Rest ] , Result) :-
    collect_borrowers(Book , Rest , Result ).


% check if element is not in list

not_member(_, []).
not_member(X, [H|T]) :-
    X \= H,
    not_member(X, T).


% List of all students
all_students(Students) :-
    collect_all_students([], Students).

collect_all_students(Seen, Result) :-
    student(S, _),
    not_member(S, Seen), !,
    collect_all_students([S|Seen], Result).

collect_all_students(Result, Result).

% Count borrowers of a book
borrowers_count(Book, N) :-
    all_students(Students),
    collect_borrowers(Book, Students, Borrowers),
    count_list(Borrowers, N), !.

% -----------------------TASK-3-----------------------------
most_borrowed_book(B) :-
    book(B, _),
    borrowers_count(B, N),
    no_book_has_more(B, N), !.

no_book_has_more(B, N) :-
    book(B2, _), B2 \= B,
    borrowers_count(B2, N2),
    N2 > N, !, fail.
no_book_has_more(_, _).

% -----------------------TASK-4-----------------------------
ratings_of_book(Book, List) :-
    ratings_of_book_helper(Book, List), !.

ratings_of_book_helper(Book, [(Person, Score) | Rest]) :-
    rating(Person, Book, Score),
    ratings_of_book_helper(Book, Rest).

ratings_of_book_helper(_, []).






