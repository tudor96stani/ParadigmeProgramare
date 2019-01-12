declare
fun {Eval Node Env}
   if {Number.IsNumber Node} then Node
   else
      case Node
      of var(X) then Env.X
      [] mul(X Y) then {Eval X Env} * {Eval Y Env}
      [] add(X Y) then {Eval X Env} + {Eval Y Env}
      end
   end
end

declare
Ans = {Eval add(var(a) mul(3 var(b))) env(a:2 b:4)}