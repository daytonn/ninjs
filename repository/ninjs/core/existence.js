if (is_defined === undefined) {
	var is_defined = function(variable) {	
		return (variable === undefined) ? false : true;
	};
}

if (!is_defined(is_undefined)) {
	var is_undefined = function(variable) {
		return (variable === undefined) ? true : false;
	};
}

if (is_undefined(is_typeof)) {
	var is_typeof = function(type, variable) {
		try {
			if (is_undefined(type)) {
				throw new SyntaxError("is_typeof(Type, variable): type is undefined");
			}
			if (is_undefined(variable)) {
				throw new SyntaxError("is_typeof(Type, variable): variable is undefined");
			}

			return (variable.constructor == type) ? true : false;
		}
		catch(error) {
			alert(error.message);
		}
	};
}

if (is_undefined(is_numeric)) {
	var is_numeric = function(suspect) {
		if(is_typeof(Number, suspect)) {
			return true;
		}
		else {
			var pattern = /^-?\d+(?:\.\d*)?(?:e[+\-]?\d+)?$/i;
			return pattern.test(suspect);	
		}
	};
}
