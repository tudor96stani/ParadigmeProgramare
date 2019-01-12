declare
fun {IsMember L ID}
    case L of nil then false
    [] (IDH#LH) | T then 
        if IDH == ID then true
        else {IsMember T ID}
        end
    end
end

%{Browse {IsMember [ a#e1 b#y c#e3 ] c}}
%{Browse {IsMember [ a#e1 b#y c#e3 ] y}}

fun {Fetch L ID}
    case L of nil then ID
    [] (IDH#LH) | T then 
        if IDH == ID then LH
        else {Fetch T ID}
        end
    end
end

{Browse {Fetch [ a#e1 b#y c#e3 ] c}}
{Browse {Fetch [ a#e1 b#y c#e3 ] d}}

fun {AdjoinRec L X}
    case L of nil then nil
    [] (IDH#LH) | T then 
        case X of (ID#E) then
        if IDH == ID then {AdjoinRec T X}
        else (IDH#LH) | {AdjoinRec T X}
        end
        end
    end
end

fun {Adjoin L E}
    E | {AdjoinRec L E}
end

{Browse {Adjoin [ a#e1 b#y c#e3 ] c#e4}}
{Browse {Adjoin [ a#e1 b#y c#e3 ] d#e4}}