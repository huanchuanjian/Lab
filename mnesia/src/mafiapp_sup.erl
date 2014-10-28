%%%-------------------------------------------------------------------
%%% @author huancj
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 28. 十月 2014 上午11:41
%%%-------------------------------------------------------------------
-module(mafiapp_sup).
-author("huancj").
-behaviour(supervisor).
%% API
-export([start_link/0]).

%% Callback
-export([init/1]).


start_link() ->
    supervisor:start_link(?MODULE, []).

init([]) ->
    {ok, {{one_for_one, 1, 1}, []}}.
