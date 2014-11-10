-module(monitor_test).

-compile(export_all).

start() ->
	PidA = spawn(fun() -> a() end),
	register(pa, PidA),

	PidB = spawn(fun() -> b() end),
	register(pb, PidB),

	PidC = spawn(fun() -> c(PidA) end),
	register(pc, PidC),

	check(),
	ok.

check() ->
	io:format("pa=~p; pb=~p; pc=~p~n", [whereis(pa), whereis(pb), whereis(pc)]),
	ok.

a() ->
	io:format("A is running.~n", []),
	erlang:send_after(5000, self(), killself),
	receive
		killself -> exit(normal);
		_ -> skip
	end.

b() ->
	io:format("B is running.~n", []),
	case whereis(pa) of
		undefined -> skip;
		_ -> monitor(process, pa)	
	end,
	receive
		{'DOWN', _MRef, _Type, _Object, _Info} ->
			io:format("Process A is down~n", []),
			b();
		_ ->
			skip
	end.

c(PidA) ->
	io:format("C is running.~n", []),
	link(PidA).

