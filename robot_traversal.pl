% Define possible movements
move(state(X, Y), state(NewX, Y)) :- NewX is X + 1. % Move right
move(state(X, Y), state(NewX, Y)) :- NewX is X - 1. % Move left
move(state(X, Y), state(X, NewY)) :- NewY is Y + 1. % Move up
move(state(X, Y), state(X, NewY)) :- NewY is Y - 1. % Move down

% Calculate Manhattan distance
distance(state(X1, Y1), state(X2, Y2), D) :-
    D is abs(X1 - X2) + abs(Y1 - Y2).

% Means-End Analysis algorithm
means_end_analysis(CurrentState, GoalState, [CurrentState|Path]) :-
    CurrentState = GoalState, % Base case: if current state is goal state, stop
    Path = []. % Path is empty when goal is reached.

means_end_analysis(CurrentState, GoalState, [CurrentState|Path]) :-
    CurrentState \= GoalState, % If current state is not the goal
    move(CurrentState, NextState), % Select a possible move
    distance(NextState, GoalState, D1), % Calculate distance after the move
    distance(CurrentState, GoalState, D2),
    D1 < D2, % Ensure the move brings us closer to the goal
    means_end_analysis(NextState, GoalState, Path). % Recursively continue the process

% Start the robot from initial position
solve_robot(Start, Goal, Path) :- means_end_analysis(Start, Goal, Path).
