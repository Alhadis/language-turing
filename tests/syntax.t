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

const speed := 2.93e3

% Bindings
bind var item1 to A (n), var item2 to B
item := 15


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


% Union example
const passenger := 0
const farm  := 1
const recreational  := 2

type vehicleInfo :
	union kind : passenger .. recreational of
		label passenger :
			cylinders : 1..16
		label farm :
			farmClass :string ( 10 )
		label : % No fields for "otherwise" clause
	end union
var v : vehicleInfo
…
tag v, passenger % Activate passenger part v.cylinders := 6


% Handler examples
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


%===============================================================================
% FORWARD EXAMPLES
%===============================================================================
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



%===============================================================================
% CLASS EXAMPLES
%===============================================================================
class stackClass    % Template for creating individual stacks
	export push, pop /* Something */

	var top : int := 0
	var contents : array 1 .. 100 of string

	procedure push (s : string)
		top := top + 1
		contents (top) := s
	end push

	procedure pop (var s : string)
		s := contents (top)
		top := top - 1
	end pop
end stackClass

var p: pointer to stackClass % Short form: var p: ^stackClass
new stackClass, p            % Short form: new p
p -> push ("Harvey")
var name : string
p -> pop (name)              % This sets name to be Harvey



class File
	export open, close, read, write
	
	deferred procedure open  (parameters : open)
		% Stuff
	end open
	
	deferred procedure close (parameters : close)
		% Stuff
	end close
	
	deferred procedure read  (parameters : read)
		% Stuff
	end read
	
	deferred procedure write (parameters : write)
		% Stuff
	end write
end File


class TextFile
	inherit File
	var internalTextFileData :
		% … internal data for text files …

	body procedure open
		% … body for open for text files …
	end open

	% … bodies for close, read and write procedures for text files…
end TextFile


class Device
	inherit File
	export ioCtl
	deferred procedure ioCtl (parameters : ioCtl)
	end ioCtl
	
end Device



class Disk
	inherit Device
	var internalDiskFileData : % … internal data for disk files

	body procedure open
		% … body for open …
	end open

	% … bodies for close, read, write and ioCtl procedures for disk …
end Disk



class C
	export f, g

	procedure f
		put "C's f"
	end f

	procedure g
		put "C's g"
	end g
end C

class D
	inherit C           % Inherit f and g

	body procedure g    % Overrides g in C
		put "*** D's g ***"
	end g

	procedure h
		put "*** D's h ***"
	end h
end D

var p : pointer to C    % p can point to any descendant of C
new D, p        % p locates an object of class D
p -> f          % Outputs "C's f"
p -> g          % Outputs "*** D's g ***"
p -> h          % Causes error "'h' is not in export list of 'C'"




%===============================================================================
% MODULE EXAMPLES
%===============================================================================
module stack            % Implements a LIFO list of strings
	export push, pop

	var top : int := 0
	var contents : array 1 .. 100 of string

	procedure push ( s : string )
		top := top + 1
		contents ( top ) := s
	end push

	procedure pop ( var s : string )
		s := contents ( top )
		top := top - 1
	end pop
end stack

stack . push ( "Harvey" )
var name : string
stack . pop ( name )        % This sets name to Harvey



module complex
	export opaque value, constant, add
	% … other operations …
	
	type value :
		record
			realPt, imagPt : real
		end record

	function constant (realPt, imagPt: real ) : value
		var answer : value
		answer . realPt := realPt
		answer . imagPt := imagPt
		result answer
	end constant

	function add (L, R : value) : value
		var answer : value
		answer . realPt := L . realPt + R . realPt
		answer . imagPt := L . imagPt + R . imagPt
		result answer
	end add
	
	% … other operations for complex arithmetic go here …
end complex

var c,d : complex .value :=complex.constant ( 1, 5 ) 
	% c and d become the complex number (1,5)
var e : complex .value := complex.add (c, d )
	% e becomes the complex number (2,10)




monitor resource
	export request, release

	var available : boolean := true
	var nowAvailable : condition

	procedure request
		if not available then
			wait nowAvailable   % Go to sleep
		end if
		assert available
		available := false      % Allocate resource
	end request

	procedure release
		assert not available    % Resource is allocated
		available := true       % Free the resource
		signal nowAvailable % Wake up one process
		% If any are sleeping
	end release

end resource
process worker
	loop
		…
		resource.request        % Block until available
		… use resource …
		resource.release
	end loop
end worker

fork worker             % Activate one worker
fork worker             % Activate another worker
