%%%-------------------------------------------------------------------
%%% @author huancj
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 27. 十月 2014 下午5:37
%%%-------------------------------------------------------------------
-module(mafiapp_SUITE).
-author("huancj").
-include_lib("common_test/include/ct.hrl").

%% API
-export([all/0, init_per_suite/1, end_per_suite/1]).

all() -> [].

init_per_suite(Config) ->
    Priv = ?config(priv_dir, Config),
    application:set_env(mnesia, dir, Priv),
    mafiapp:install([node()]),
    application:start(mnesia),
    application:start(mafiapp),
    Config.

end_per_suite(_Config) ->
    application:stop(mnesia),
    ok.

