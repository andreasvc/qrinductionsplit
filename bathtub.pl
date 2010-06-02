struct_rel(self, X, X) :-
	has_quantity(_X, X).

model([
	dependency(inf_pos,flow12, level12),
	dependency(inf_pos,flow11, level11),
	dependency(inf_neg,flow12, level11),
	dependency(prop_pos,level11, flow12),
	dependency(q_correspondence,level11, flow12)
]).

isa(pipe, pipe11).
isa(pipe, pipe12).
isa(container, container11).
isa(container, container12).

% quantities.
isa(flow, flow11).
isa(flow, flow12).
isa(level, level11).
isa(level, level12).

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
