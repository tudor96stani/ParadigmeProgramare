%1

declare
fun { Mul N K }
   if N==K then N
   else
      N*{Mul (N-1) K}
   end
end


declare
fun {Comb N K}
   if K==0 then 1
   else
      {Mul N (N-K+1)} div {Mul K 1}
   end
end


declare
fun {CombOpt N K}
   if K==1.0 then N
   else
     ( N /  K )* {CombOpt (N+1.0) (K-1.0)} 
   end
end

declare
fun { Do N K}
   if K==0.0 then 1.0
   else
      {CombOpt (N-K+1.0) K}
   end
end


%{Browse {Comb 10 0}}
%{Browse {Comb 10 3}}
%{Browse {Do 10.0 3.0}}

%2
declare
fun {Append L1 L2}
   case L1 of nil then L2
   [] H|T then H|{Append T L2}
   end
end


declare
fun {Reverse L}
   case L of nil then nil
   [] H|T then {Append {Reverse  T} [H]}
   end
end


declare
fun {Rev L PL}
   case L of nil then PL
   [] H|T then {Rev T {List.append [H] PL}}
   end
end


{Browse {Reverse [1 2 3]}}
{Browse {Rev [5 6 7 8 9] nil}}


declare
fun lazy {Sieve L}
  case L of
        nil then nil
    []  H|T then H|{Sieve {Filter T H}}
    end
end

fun lazy {Filter L H}
  case L of
        nil then nil
    []  A|As then  if (A mod H == 0) then {Filter As H}
                  else A|{Filter As H} end
  end
end


fun lazy {Gen N}
  N | {Gen N+1}
end


fun {Prime}
  {Sieve {Gen 2}}
end

fun {Find L N}
   case L of
      H|T then if (H < N) then {Find T N} else H end
   end
end

fun {GetAfter N}
   local R in
      R = {Prime}
      {Find R N}
   end
end

L = {GetAfter 20}

{Browse L}
