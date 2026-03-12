
% Load the library data
:- consult('library_data.pl').

% -----------------------TASK-1-----------------------------
books_borrowed_by_student(Student, L) :-
    find_books(_, Student, [], L).

find_books(Book, Student, Acc, L) :-
    borrowed(Student, Book),
    \+ member(Book, Acc), !,
    find_books(_, Student, [Book|Acc], L).

find_books(_, _, Acc, Acc).
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



% -----------------------TASK-5-----------------------------
% Collect all (Student, Score) pairs from all ratings
collect_all_ratings([], []).
collect_all_ratings([rating(S, _, Score) | Rest], [(S, Score) | RestPairs]) :-
    collect_all_ratings(Rest, RestPairs).

% Helper to gather all rating/3 facts into a list
all_ratings(Ratings) :-
    collect_all_rating_facts([], Ratings).

collect_all_rating_facts(Seen, Result) :-
    rating(S, B, Score),
    \+ member(rating(S, B, Score), Seen), !,
    collect_all_rating_facts([rating(S, B, Score) | Seen], Result).
collect_all_rating_facts(Result, Result).

% Find the maximum score in a list of (Student, Score) pairs
max_score([(_, Score)], Score).
max_score([(_, Score) | Rest], Max) :-
    max_score(Rest, RestMax),
    (Score > RestMax -> Max = Score ; Max = RestMax).

% Find the student who gave the max score
find_reviewer_with_score([(Student, Score) | _], Score, Student) :- !.
find_reviewer_with_score([_ | Rest], MaxScore, Student) :-
    find_reviewer_with_score(Rest, MaxScore, Student).

% Top reviewer: student who gave the highest single rating
top_reviewer(Student) :-
    all_ratings(Ratings),
    collect_all_ratings(Ratings, Pairs),
    max_score(Pairs, MaxScore),
    find_reviewer_with_score(Pairs, MaxScore, Student), !.

% -----------------------TASK-6-----------------------------
collect_topics([], []).
collect_topics([Book|Rest], AllTopics) :-
    topics(Book, BookTopics),
    collect_topics(Rest, RestTopics),
    append(BookTopics, RestTopics, AllTopics).

count(_, [], 0).
count(X, [X|T], N) :- !,
    count(X, T, N1),
    N is N1 + 1.
count(X, [_|T], N) :-
    count(X, T, N).

most_frequent([H|T], Most) :-
    most_frequent_acc([H|T], [H|T], H, 0, Most).

most_frequent_acc([], _, Best, _, Best).
most_frequent_acc([H|T], FullList, CurrentBest, CurrentMax, Most) :-
    count(H, FullList, N),
    N > CurrentMax, !,
    most_frequent_acc(T, FullList, H, N, Most).
most_frequent_acc([_|T], FullList, CurrentBest, CurrentMax, Most) :-
    most_frequent_acc(T, FullList, CurrentBest, CurrentMax, Most).


most_common_topic_for_student(Student, Topic) :-
    books_borrowed_by_student(Student, Books),
    collect_topics(Books, AllTopics),
    most_frequent(AllTopics, Topic).

