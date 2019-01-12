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

fun {IsMember L ID}
    case L of nil then false
    [] (IDH#LH) | T then 
        if IDH == ID then true
        else {IsMember T ID}
        end
    end
end

fun {Fetch L ID}
    case L of nil then ID
    [] (IDH#LH) | T then 
        if IDH == ID then LH
        else {Fetch T ID}
        end
    end
end

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

Cnt = {NewCell 0}
fun {NewID}
    Cnt :=  @Cnt + 1
    {String.toAtom {Append "ID<" {Append {Int.toString @Cnt} ">"}}}
end

%{Browse {NewID}}
%{Browse {NewID}}

fun {DeleteElement L E}
    case L of nil then nil
    [] H | T then
        if H == E then {DeleteElement T E}
        else H | {DeleteElement T E}
        end
    end
end

fun {RenameRec E Env FreeVars}
    case E of lam(E1 E2) then lam({RenameRec E1 Env FreeVars} {RenameRec E2 Env FreeVars}) 
    [] let(ID#E1 E2) then 
        local NewName in
            NewName = {NewID}
            Env := {Adjoin @Env ID#NewName}
            
            let(NewName#{RenameRec E1 Env {DeleteElement FreeVars ID}} {RenameRec E2 Env {DeleteElement FreeVars ID}})
        end
    [] apply(E1 E2) then apply({RenameRec E1 Env FreeVars} {RenameRec E2 Env FreeVars})
    [] ID then
        if {Member FreeVars ID} then ID
        else
            if {IsMember @Env ID} then {Fetch @Env ID}
            else
                local NewName in
                    NewName = {NewID}
                    Env := {Adjoin @Env ID#NewName}
                    NewName
                end
            end
        end
    end
end

fun {Rename E}
    local FreeVars = {FreeSet E}  LocalEnv = {NewCell nil} Response in
        Response = {RenameRec E LocalEnv FreeVars}
        Response
    end
    
end

{Browse {Rename lam(z lam(x z))}}
{Browse {Rename let(id#lam(z z) apply(id y))}}