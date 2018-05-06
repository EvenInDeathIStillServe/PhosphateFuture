//Checks for specific types in a list
/proc/is_type_in_list(var/atom/A, var/list/L)
	for(var/type in L)
		if(istype(A, type))
			return 1
	return 0

//Checks for specific paths in a list
/proc/is_path_in_list(var/path, var/list/L)
	for(var/type in L)
		if(ispath(path, type))
			return 1
	return 0