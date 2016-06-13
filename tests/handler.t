const stackOverflow := 500
const maxTop := 100
var top : 0 .. maxTop := 0
var stack : array 1 .. maxTop of int

procedure push ( i : int )
	if top = maxTop then
		quit : stackOverflow
	end if
	top := top + 1
	stack ( top ) := i
end push

procedure parse
	handler ( exceptionNumber )
		put "Failure number ", exceptionNumber
		case exceptionNumber of
		label stackOverflow :
			put "Stack has overflowed!!"
		… other exceptions handled here …
		label :         % Unexpected failures
			quit >      % Pass exception further
		end case
	end handler
	parseExpn           % Eventually push is called
end parse
