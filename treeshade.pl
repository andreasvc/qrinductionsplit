struct_rel(self, X, X) :-
	has_quantity(X, _X).

model([
	dependency(inf_pos, growth_rate1, size1),
	dependency(prop_pos, size1, growth_rate1),
	dependency(prop_pos, size1, shade1),
	dependency(q_correspondence, size1, shade1),
	dependency(q_correspondence, shade1, size1)
]).

isa(tree1, tree).

isa(size1, size).
isa(shade1, shade).
isa(growth_rate1, growth_rate).

% quantity(Entity, Quantity). one to many
has_quantity(tree1, size1).
has_quantity(tree1, shade1).
has_quantity(tree1, growth_rate1).
