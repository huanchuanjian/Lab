%%%-------------------------------------------------------------------
%%% @author huanzh
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 04. 四月 2015 下午3:05
%%%-------------------------------------------------------------------
-module(tcp_client).
-export([nano_client_eval/1]).

nano_client_eval(Num) ->
    {ok, Socket} = gen_tcp:connect("localhost", 5566, [binary, {packet, 4}]),
    ok = gen_tcp:send(Socket, term_to_binary(Num)),
    receive
        {tcp, Socket, Bin} ->
            io:format("Client received binary = ~p~n", [Bin]),
            Val = binary_to_term(Bin),
            io:format("Client result = ~p~n", [Val]),
            gen_tcp:close(Socket)
    end.
