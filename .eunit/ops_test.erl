-module(ops_test).

-include_lib("eunit/include/eunit.hrl").


%% ?assert(Expression), ?assertNot(Expression)
%% ?assertEqual(A, B)


add_test() ->
	4 = ops:add(2,2).

new_add_test() ->
	?assert(is_number(ops:add(1,2))),

	?assertEqual(4,ops:add(2,2)),
	%?assertEqual(3,ops:add(2,2)),

	?assertError(badarith, 1/0).


%% test generators
my_test_() ->
	[test_them_types(),
	 test_them_values(),
	 ?_assertError(badarith, 1/0)].

test_them_types() ->
	?_assert(is_number(ops:add(2,2))).

test_them_values() ->
	[?_assertEqual(4,ops:add(2,2)),
	?_assertEqual(3,ops:add(1,2))].