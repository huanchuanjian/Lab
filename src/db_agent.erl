%%%-------------------------------------------------------------------
%%% @author huanzh
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%     数据库中间层
%%% @end
%%% Created : 12. 三月 2015 下午4:44
%%%-------------------------------------------------------------------
-module(db_agent).
-author("huanzh").

-include("../deps/mysql/include/mysql.hrl").

-define(DB_POOL, mysql_pool).
-record(sql_field, {
    id,
    name,
    birth,
    last_login_ts
}).

%% API
-export([start/0, insert/1]).

-compile(export_all).

start() ->
    create_pool().

create_pool() ->
    mysql:start_link(?DB_POOL, "localhost", "root", "12345", "android_log").

insert_sql(Table, Fields, Values) ->
    Fields1 = [atom_to_list(X) || X <- Fields],
    Sql = [
        "insert into ", Table, "(", string:join(Fields1, ", "),
        ") values(", string:join(Values, ", "), ");"
    ],
    lists:concat(Sql).

%% @doc 关于 erlang-mysql-driver 使用说明，可以参考 mysql.erl 文件最上方的注释
insert(Sql) ->
    case mysql:fetch(?DB_POOL, Sql) of
        {updated, #mysql_result{affectedrows = 1}} -> ok;
        Error ->
            Reason = mysql:get_result_reason(Error),
            ErrCode = mysql:get_result_err_code(Error),
            {error, ErrCode, Reason}
    end.

test() ->
    [_Id|Fields1] = record_info(fields, sql_field),
    insert_sql("game", Fields1, ["huanzh", "person", "sowhat"]).
