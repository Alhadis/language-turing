var token : string

forward procedure expn ( var eValue : real )

forward procedure term ( var tValue : real )

forward procedure primary ( var pValue: real )

body procedure expn
	var nextValue : real
	term ( eValue )         % Evaluate t
	loop                    % Evaluate { + t}
		exit when token not= "+"
		get token
		term ( nextValue )
		eValue := eValue + nextValue
	end loop
end expn

body procedure term
	var nextValue : real
	primary (tValue )       % Evaluate p
	loop                    % Evaluate { * p}
		exit when token not= "*"
		get token
		primary ( nextValue )
		tValue := tValue * nextValue
	end loop
end term
body procedure primary
	if token = "(" then
		get token
		expn ( pValue )     % Evaluate (e)
		assert token = ")"
	else                    % Evaluate "explicit real"
		pValue := strreal ( token )
	end if
	get token
end primary

get token               % Start by reading first token
var answer : real
expn ( answer )         % Scan and evaluate input expression
put "Answer is ", answer
