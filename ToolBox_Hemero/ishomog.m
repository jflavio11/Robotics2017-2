%ISHOMOG	Comprueba si el argumento que se le pasa es una transformación homogénea


function h = ishomog(tr)
	if ndims(tr) == 2,
		h =  all(size(tr) == [4 4]);
	else
		h = 0;
	end
