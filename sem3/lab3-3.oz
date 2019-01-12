declare
fun {Head Xs}
    Xs.1
end

fun {Tail Xs}
    Xs.2
end

fun {Zip L1 L2}
    case L1 of nil then nil
    [] H|T then H#{Head L2}|{Zip T {Tail L2}} end 
end

{Browse {Zip [1 2 3] [a b c]}}

fun {Unzip P L1 L2}
    case P of nil then L1#L2
    [] H|T then {Unzip T {List.append L1 [H.1]} {List.append L2 [H.2]}} end
end

{Browse {Unzip [a#1 b#2 c#3] nil nil}}