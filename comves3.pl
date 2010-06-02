% two communicating vessels; induced by Hylke's code
struct_rel(self, X, X) :-
	has_quantity(_X, X).

model([
	dependency(inf_pos, flow3, amount5),
	dependency(inf_neg, flow3, amount4),
	dependency(prop_neg, flow3, pressure5), 
	dependency(prop_pos, flow3, pressure4),
	dependency(prop_pos, height4, amount4),
	dependency(prop_pos, height5, amount5),
	dependency(prop_pos, pressure5, height5),
	dependency(prop_pos, pressure4, height4),
	dependency(q_correspondence, height5, amount5),
	dependency(q_correspondence, pressure4, height4),
	dependency(q_correspondence, pressure5, height5),
	dependency(q_correspondence, height4, amount4),
	dependency(equals, flow3, min(pressure4, pressure5)),
	%NB: the following two were not induced:
	dependency(equals, height4, pressure4),	
	dependency(equals, height5, pressure5),
	%Added by hand for 3 vessels
	dependency(inf_pos, flow4, amount6),
	dependency(inf_neg, flow4, amount5),
	dependency(prop_neg, flow4, pressure6), 
	dependency(prop_pos, flow4, pressure5),
	dependency(prop_pos, height6, amount6),
	dependency(prop_pos, pressure6, height6),
	dependency(q_correspondence, height6, amount6),
	dependency(q_correspondence, pressure6, height6),
	dependency(equals, flow4, min(pressure5, pressure6)),
	%NB: the following two were not induced:
	dependency(equals, height6, pressure6)	
]).

%TODO: rename entity to "isa"
% entity(generic, instance)
isa(pipe, pipe1).
isa(pipe, pipe2).
isa(container, container_left).
isa(container, container_center).
isa(container, container_right).

isa(flow, flow3).
isa(flow, flow4).
isa(amount, amount4).
isa(amount, amount5).
isa(amount, amount6).
isa(height, height4).
isa(height, height5).
isa(height, height6).
isa(pressure, pressure4).
isa(pressure, pressure5).
isa(pressure, pressure6).

struct_rel(from, container_left, pipe1).
struct_rel(to, pipe1, container_center).
struct_rel(from, container_center, pipe2).
struct_rel(to, pipe2, container_right).

% quantity(Entity, Quantity). one to many relation between instances
has_quantity(pipe1, flow3).
has_quantity(pipe2, flow4).
has_quantity(container_left, amount4).
has_quantity(container_left, height4).
has_quantity(container_left, pressure4).
has_quantity(container_center, amount5).
has_quantity(container_center, height5).
has_quantity(container_center, pressure5).
has_quantity(container_right, amount6).
has_quantity(container_right, height6).
has_quantity(container_right, pressure6).
