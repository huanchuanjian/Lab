%%%-------------------------------------------------------------------
%%% @author huancj
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 27. 十月 2014 下午5:44
%%%-------------------------------------------------------------------
-module(mafiapp).
-author("huancj").

-behaviour(application).

%% API
-export([install/1, add_friend/4, add_service/4, friend_by_name/1]).

%% Application Callback
-export([start/2, stop/1]).

-record(mafiapp_friends, {name, contact=[], info=[], expertise}).
-record(mafiapp_services, {from, to, date, description}).

install(Nodes) ->
    ok = mnesia:create_schema(Nodes),
    rpc:multicall(Nodes, application, start, [mnesia]),
    mnesia:create_table(mafiapp_friends,
        [
            {attributes, record_info(fields, mafiapp_friends)},
            {index, [#mafiapp_friends.expertise]},  % 索引
            {disc_copies, Nodes} % 存储方式
        ]
    ),
    mnesia:create_table(mafiapp_services,
        [
            {attributes, record_info(fields, mafiapp_services)},
            {index, [#mafiapp_services.to]},
            {disc_copies, Nodes},
            {type, bag}
        ]
    ),
    rpc:multicall(Nodes, application, stop, [mnesia]).

start(normal, []) ->
    mnesia:wait_for_tables([mafiapp_friends, mafiapp_services], 5000),
    mafiapp_sup:start_link().

stop(_) -> ok.

%% 设计接口时，尽量把数据结构暴露出来，比如 foo:bar(#record{})，一方面便于重构，另一方面不需要include相关的hrl文件
add_friend(Name, Contact, Info, Expertise) ->
    F = fun() ->
        mnesia:write(#mafiapp_friends{name=Name,contact=Contact,info=Info,expertise=Expertise})
        end,
    mnesia:activity(transaction, F).

%% 在事务外部，根据需要可以随意的验证输入参数，事务内部尽量少用，因为这会占用数据库资源
add_service(From, To, Date, Desc) ->
    F = fun() ->
            case mnesia:read({mafiapp_friends, From}) =:= [] orelse
                 mnesia:read({mafiapp_friends, To}) =:= [] of
                true -> {error, unkown_friend};
                false ->
                    mnesia:write(#mafiapp_services{from=From,to=To,date=Date,description=Desc})
            end
        end,
    mnesia:activity(transaction, F).

friend_by_name(Name) ->
    F = fun() -> 
            case mnesia:read({mafiapp_friends, Name}) of
                [#mafiapp_friends{contact=C, info=I, expertise=E}] ->
                    {Name, C, I, E, find_services(Name)};
                [] ->
                    undefined
            end
        end,
    mnesia:activity(transaction, F).

%% Private functions
find_services(_Name) -> undefined.


