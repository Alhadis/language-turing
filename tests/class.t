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
