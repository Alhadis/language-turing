function firstWord ( str : string ): string
	for i : 1 .. length ( str )
		if str ( i ) = " " then
			result str ( 1 .. i - 1)
		end if
	end for
end firstWord

put "The first word is: ", firstWord ("Henry Hudson")
	% The output is Henry.
