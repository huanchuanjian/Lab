%%%-------------------------------------------------------------------
%%% @author mac01
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. 十二月 2014 下午5:17
%%%-------------------------------------------------------------------
-module(ms).
-author("mac01").

%% API
-compile(export_all).


even1(L) ->
    lists:reverse(even1(L, [])).
even1([], Acc) -> Acc;
even1([H|T], Acc) ->
    case H rem 2 =:= 0 of
        true -> even1(T, [H|Acc]);
        false -> even1(T, Acc)
    end.

even2(L) ->
    lists:foldr(
        fun(X, Acc) ->
            case X rem 2 =:= 0 of
                true -> [X|Acc];
                false -> Acc
            end
        end,
        [], L).

even3(L) ->
    [X || X <- L, X rem 2 =:= 0].


%% quick sort
qsort([]) -> [];
qsort([Privot|T]) ->
    qsort([X || X <- T, X < Privot]) ++ Privot ++ qsort([X || X <- T, X > Privot]).

