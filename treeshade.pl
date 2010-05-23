struct_rel(self, X, X) :-
	has_quantity(X, _X).

model([
	dependency(inf_pos, growth_rate1, size1),
	dependency(prop_pos, size1, growth_rate1),
	dependency(prop_pos, size1, shade1),
	dependency(q_correspondence, size1, shade1),
	dependency(q_correspondence, shade1, size1)
]).

entity(tree, tree1).

entity(size, size1).
entity(shade, shade1).
entity(growth_rate, growth_rate1).

% quantity(Entity, Quantity). one to many
has_quantity(tree1, size1).
has_quantity(tree1, shade1).
has_quantity(tree1, growth_rate1).