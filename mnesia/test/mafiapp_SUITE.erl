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
-export([all/0, 
         init_per_suite/1, 
         end_per_suite/1, 
         init_per_testcase/2, 
         friend_by_name/1]).

all() -> [friend_by_name].

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

init_per_testcase(_, Config) ->
    ok = mafiapp:add_friend("panxh", [], [boss], erlang),
    Config.

friend_by_name(_Config) ->
    ok = mafiapp:add_friend("panxh", [{phone, "8888888"}, 
                                      {email, "qhhd@qhhd.cn"},
                                      {other, "boss"}],
                                      [{born, {1983,1,1}},
                                      boss, china], erlang),
    {"panxh", _Contact, _Info, erlang, _Services} = mafiapp:friend_by_name("panxh"),
    undefined = mafiapp:friend_by_name(make_ref()).






