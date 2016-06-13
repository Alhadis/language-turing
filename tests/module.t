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
