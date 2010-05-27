% split a monolithic model fragment into modular fragments



go :-
	do(treeshade).

go1 :-
	do(bathtub).

go2 :-
	do(comves).

do(File) :-
	consult(File),
	% monolithic model
	model(M),
	write('Input: '), nl, write(M), nl, nl,
	split(M, MF),
	write(MF).


% SCENARIO

/*
%engine:isa
entity(A, B) :-
	isa_transitive(B, A).

%TODO
has_quantity(A, B) :-
	get_quantity_entity_types([B], EntityTypes),
	member(A,  EntityTypes).
	%input.pl:65 ongeveer

struct_rel(R, A, B) :-
	.
*/


%todo: automate etc. atom_concat etc.

% given a flat list of dependencies, return a partition corresponding to maximally generalized fragments
% this output can be converted into multiple model fragments
split(M, MF) :-
	fragments(M, F),
	length(F, N),
	write('Fragments ('), write(N), write('): '), nl,
	forall(member(Fr, F), (write(Fr), nl)), nl,
	unfragment(M, F, UF),
	write('Unfragments: '), write(UF), nl, nl,
	append(F, UF, MF).

% find an instance of a structural relation and two entity classes
instance(R, Q1, Q2, QI1, QI2) :-
	struct_rel(R, EI1, EI2),
	has_quantity(EI1,QI1),
	has_quantity(EI2,QI2),
	entity(Q1, QI1),
	entity(Q2, QI2).

% check whether all instances of a triple of a structural relation and two entity classes share the same dependencies
same_deps(R, QI1, QI2, M) :-
	%same_deps1(QI1, QI2
	forall(	instance(R, QI1, QI2, QJ1, QJ2),
		(	forall(	member(dependency(D, QI1, QI2), M),
				member(dependency(D, QJ1, QJ2), M)
			),
			forall(	member(dependency(D, QI2, QI1), M),
				member(dependency(D, QJ2, QJ1), M)
			)
		)
	).

% delete this? or is it more efficient than same_deps?
get_deps(_QI1, _QI2, []).
get_deps(QI1, QI2, [dependency(D, QI1, QI2) | M ], [dependency(D, Q1, Q2) | Result]) :-
	!,	
	entity(Q1, QI1), entity(Q2, QI2),
	get_deps(QI1, QI2, M, Result).

get_deps(QI1, QI2, [dependency(_, _, _) | M ], Result) :-
	get_deps(QI1, QI2, M, Result).

% fragments that can be generalized (ie., relations between quantity classes)
% collapes M into a set of sets containing generalized dependencies.
%
% incorrect definition (todo): fragments = smallest union of all possible sets
% { d | dependency(d) & d = generalized(di) & di in M } such that there is
% exactly one structural relation shared by them.
%
% where dependency is true for dependency triples, and generalized is a
% function that takes a dependency between instances of quantities and returns
% a dependency between the classes of those entities.
fragments(M, F) :-
	findall((R, Q1, Q2),
		(	instance(R, Q1, Q2, QI1, QI2),
			same_deps(R, QI1, QI2, M)
		),
		Rels1
	), 
	findall((R, Q1, Q2),
		(	member((R, Q1, Q2), Rels1),
			(R = self ->
				Q1 @=< Q2
			; 	true)
		),
		Rels2),
	list_to_set(Rels2, Rels),
	write('Set of struct rels: '), write(Rels), nl,
	findall([ (R, Q1, Q2) | Deps ],
		(	member((R, Q1, Q2), Rels), 
			findall(Dep,
				(	instance(R, Q1, Q2, QI1, QI2),
					member(DepI, M), 
					(	(	DepI = dependency(D, QI1, QI2),
							Dep = dependency(D, Q1, Q2)
						)
					;	(	DepI = dependency(D, QI2, QI1),
							Dep = dependency(D, Q2, Q1)
						)
					)	
				),
				Deps1
			),
			list_to_set(Deps1, Deps),
			\+ Deps = []
		),
		F
	).

% unfragment: all dependencies that cannot be generalized; ie., relations
% between specific quantities, would need further conditions to generalize, 
% here we give up and specify them using particular quantity names).
%
% definition: unfragments = { d | dependency(d) & not exists f in Fragments s.t. generalized(d) in f }
unfragment(M, F, UF) :-
	findall(dependency(D, QI1, QI2), 
		(	member(dependency(D, QI1, QI2), M), 
			\+ (	member(Fr, F), 
				entity(Q1, QI1), entity(Q2, QI2), 
				memberchk(dependency(D, Q1, Q2), Fr))),
		UF).
