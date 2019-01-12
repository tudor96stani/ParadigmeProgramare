declare
fun {Append L1 L2}
   case L1 of nil then L2
   [] H|T then H|{Append T L2}
   end
end

fun {Member Xs Y}
    case Xs of nil then false
    [] H|T then if H==Y then true else {Member T Y} end
    end
end

fun {FreeSetRec E B}
    case E of apply(E1 E2) then {Append {FreeSetRec E1 B}  {FreeSetRec E2 B}}
    [] lam(ID E1) then {FreeSetRec E1 ID | B}
    [] let(ID#E1 E2) then {Append {FreeSetRec E1 ID | B} {FreeSetRec E2 ID |B}}
    [] ID then if {Member B ID} then nil else [ID] end
    end
end

fun {FreeSet E}
    {FreeSetRec E nil}
end

{Browse {FreeSet apply(x let(x#y x))}}
{Browse {FreeSet apply(y apply(let(x#x x) y))}}