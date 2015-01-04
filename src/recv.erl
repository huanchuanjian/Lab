-module(recv).

-compile(export_all).

start() ->
	Pid = spawn(fun() -> recv() end).

%% shell process
recv() ->
	receive 
		{ping, PingMsg} -> {ping, PingMsg};
		_ -> skip 
	end.

test() ->
	case recv() of
		{ping, PingMsg} -> ok;
		_ -> error
	end.