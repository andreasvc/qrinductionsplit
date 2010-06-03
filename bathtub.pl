struct_rel(self, X, X) :-
	has_quantity(X, _X).

model([
	dependency(inf_pos,flow12, level12),
	dependency(inf_pos,flow11, level11),
	dependency(inf_neg,flow12, level11),
	dependency(prop_pos,level11, flow12),
	dependency(q_correspondence,level11, flow12)
]).

isa(pipe11, pipe).
isa(pipe12, pipe).
isa(container11, container).
isa(container12, container).

% quantities.
isa(flow11, flow).
isa(flow12, flow).
isa(level11, level).
isa(level12, level).

%struct_rel(in, flow11, level11).
%struct_rel(out, flow12, level11).
%struct_rel(in, flow12, level12).

struct_rel(in, pipe11, container11).
struct_rel(in, pipe12, container12).
struct_rel(out, pipe12, container11).

% quantity(Entity, Quantity). one to many
has_quantity(pipe11, flow11).
has_quantity(pipe12, flow12).
has_quantity(container11, level11).
has_quantity(container12, level12).
