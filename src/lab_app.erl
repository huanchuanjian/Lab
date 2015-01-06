-module(lab_app).

-behaviour(application).

%% Application callbacks
-export([start/0, start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================
%% erlang start application in cmd - Google
start() ->
	application:start(crypto),
	application:start(mimetypes),
    application:start(lab).

start(_StartType, _StartArgs) ->
	ok = lager:start(),
	ok = init_webserver(),
    lab_sup:start_link().

stop(_State) ->
	application:stop(lab),
	application:stop(mimetypes),
	application:stop(crypto),
    ok.


init_webserver() ->
	error_logger:info_msg("Starting cowboy on ~p~n", [node()]),
	ok = application:start(cowlib),
	ok = application:start(ranch),
	ok = application:start(cowboy),
	Dispatch = cowboy_router:compile([
		{'_', [{"/", http_handler, []}]}
	]),
	cowboy:start_http(lab_http_listener, 100, [{port, 8088}], [{env, [{dispatch, Dispatch}]}]),
	ok.
