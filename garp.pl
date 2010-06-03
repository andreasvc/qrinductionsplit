% Garp interface, TBD

struct_rel(self, X, X) :-
	has_quantity(X, _X).

model(M) :-
	M = [].
	% fetch all dependencies from the currently active model fragment?
	% fetch dependencies from induced model?
	%
	%dependency(prop_pos, size1, growth_rate1),
	%dependency(prop_pos, size1, shade1),
	%dependency(q_correspondence, size1, shade1),
	%dependency(q_correspondence, shade1, size1)

isa(A, B) : -
	true.
	% A is an instance of entity B
	% or
	% A is an instance of quantity B

% has_quantity(Entity, Quantity). one to many
has_quantity(A, B) :-
	true.
