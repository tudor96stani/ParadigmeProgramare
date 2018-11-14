declare
fun {Head Xs}
    Xs.1
end

fun {Tail Xs}
    Xs.2
end

fun {Take Xs N}
    case N of 0 then nil
    [] N then {Head Xs}|{Take {Tail Xs} (N-1)}
    end
end

fun {Drop Xs N}
    case N of 0 then Xs
    [] N then {Drop {Tail Xs} (N-1)}
    end
end

{Browse {Take [1 4 3 6 2] 3}}
{Browse {Drop [1 4 3 6 2] 3}}