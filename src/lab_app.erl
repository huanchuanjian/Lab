-module(lab_app).

-behaviour(application).

%% Application callbacks
-export([start/0, start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================
%% erlang start application in cmd - Google
start() ->
    application:start(lab).

start(_StartType, _StartArgs) ->
	ok = lager:start(),
    lab_sup:start_link().

stop(_State) ->
    ok.
