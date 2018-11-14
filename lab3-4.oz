declare 
fun {Position1 Xs El C}
    case Xs of nil then 0
    [] H|T then if H==El then C else {Position1 T El (C+1)} end
    end
end

%1 e bullshit

{Browse {Position1 [1 2 3] 3 1}}