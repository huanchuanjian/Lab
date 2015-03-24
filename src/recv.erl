-module(recv).

-compile(export_all).

test() ->
    L = [1,2,3,4,[],[]],
    lists:foldl(fun(X, Acc) ->
        case X =:= [] of
            true -> Acc;
            false -> [X|Acc]
        end
    end, [], L).


