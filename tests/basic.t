function firstWord ( str : string ): string
	for i : 1 .. length ( str )
		if str ( i ) = " " then
			result str ( 1 .. i - 1)
		end if
	end for
end firstWord

put "The first word is: ", firstWord ("Henry Hudson")
	% The output is Henry.

% Integer literals
2#1
2#11
16#a
16#FF
16#FFFF
8#10


% Character constants
var c : char := 'H'
var d : char (2) := 'Hi'

% Character escaping
'a\"a'
"Don\'t stop"
"New \n line"
"Form \f feed"
"Back \b space"
"Back \\ slash"
"Escape \e character"
"Return \r return"

% Type
type nameType : string ( 30 )
type range : 0 .. 150
type entry :
	record
		name : nameType
		age : int
	end record


% Conditional compilation
#if stats and debug then
	var count : array 1 .. 5 of real
	var message : string
#else
	put "Debugging message"
#end if

case mark of
	label 9, 10 :   put "Excellent"
	label 7, 8 :    put "Good"
	label 6 :       put "Fair"
	label :         put "Poor"
end case


procedure ProcName (Type1 : name1)
	
end ProcName

% For loops
for i : 1 .. 10
	put i
end for

for i : 1 .. 10 by 2
	put i
end for

for decreasing j : 10 .. 1
	put j
end for

for decreasing j : 10 .. 1 by 4
	put j
end for


for j : 1 .. 10 by 20
	put j
end for

for j : 5 .. 2
	put j
end for


% "Regular" loops
loop
	put "Happy"
end loop

var word : string
loop
	get word
	exit when word = "Stop"
end loop
