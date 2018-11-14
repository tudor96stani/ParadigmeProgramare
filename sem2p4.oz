declare
Root=node(left:X1 right:X2 value:4)
X1=node(left:X3 right:X4 value:2)
X2=node(left:X5 right:X6 value:6)
X3=node(left:nil right:nil value:1)
X4=node(left:nil right:nil value:3)
X5=node(left:nil right:nil value:5)
X6=node(left:nil right:nil value:7)
%{Browse Root}
declare
fun {MinOfTree X}
   if X.left\=nil
       then {MinOfTree X.left}
       else X.value
   end
end

declare
fun {MaxOfTree X}
   if X.right\=nil then {MaxOfTree X.right}
   else X.value
   end
end

declare
fun {IsSorted X}
   if X\=nil
   then
      local ML MR in
	 if X.left \=nil
	 then
	    ML = {MinOfTree X.left}
	    if X.right \= nil
	    then
	       MR ={MaxOfTree X.right}
	       if {Or ML > X.value MR < X.value}
	          then false
	          else {And {IsSorted X.left} {IsSorted X.right}}
	       end
	    else
	       {IsSorted X.left}
	    end
	 else
	    if X.right \= nil
	    then
	       {IsSorted X.right}
	    else
	       true
	    end
	 end
      end
   else
      true
   end
end
%{Browse {MinOfTree Root}}
%{Browse {MaxOfTree Root}}
{Browse {IsSorted Root}}
