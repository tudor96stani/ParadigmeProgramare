declare
fun { Minus X }
   ~X
end
{Browse {Minus 15}}
declare
fun {Max X Y}
   if X>Y then X else Y
   end
end
declare
X = {Max 22 18}
Y = {Max X 43}
{Browse Y}

declare
fun {Absol X}
   if X>0 then X else ~X
   end
end

{Browse {Absol ~5}}

declare
fun {Fact N}
   if N == 0 then 1 else N * {Fact N-1}
   end
end
{Browse {Fact 5}}
%{Browse {Fact 100}}
%{Browse {Fact 10000}}


declare
fun {Fibo N}
   case N of
      1 then 1
   [] 2 then 1
   [] M then {Fibo (M-1)} + {Fibo (M-2)}
   end
end
%{Browse {Fibo 100}}


declare
fun {FiboTwo N A1 A2}
   case N of
      1 then A1
   [] 2 then A2
   [] M then {FiboTwo (M-1) A2 (A1+A2)}
   end
end
%{Browse {FiboTwo 100 1 1}}

declare
fun {Pow N M}
   if M==0 then 1 else N*{Pow N M-1}
   end
end
{Browse {Pow 2 3}}

declare
fun {MaxRec A B}
   if A==0 
      then B
   else 
      if B==0 
         then A 
      else 
         1+{MaxRec A-1 B-1}
      end
   end
end
{Browse {MaxRec 3 5}}