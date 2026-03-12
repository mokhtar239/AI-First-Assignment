% Test file for verifying solution predicates
:- consult('../src/solution.pl').

% Run all tests
run_tests :-
    write('=== Running Tests ==='), nl,
  % test_task1,
    test_task2,
    test_task3,
    test_task4,
  % test_task5,
  % test_task6,
    write('=== All Tests Passed ==='), nl.

test_task1 :-
    write('Task 1: books_borrowed_by_student... '),
    books_borrowed_by_student(mona, [prolog_fundamentals, recursion_in_depth, list_programming]),
    write('PASSED'), nl.

test_task2 :-
    write('Task 2: borrowers_count... '),
    borrowers_count(recursion_in_depth, 4),
    write('PASSED'), nl.

test_task3 :-
    write('Task 3: most_borrowed_book... '),
    most_borrowed_book(recursion_in_depth),
    write('PASSED'), nl.

test_task4 :-
    write('Task 4: ratings_of_book... '),
    ratings_of_book(list_programming, [(ali,90),(mona,91),(yousef,60)]),
    write('PASSED'), nl.

test_task5 :-
    write('Task 5: top_reviewer... '),
    top_reviewer(sara),
    write('PASSED'), nl.

test_task6 :-
    write('Task 6: most_common_topic_for_student... '),
    most_common_topic_for_student(mona, tracing),
    write('PASSED'), nl.
