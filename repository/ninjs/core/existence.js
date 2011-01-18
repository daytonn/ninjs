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

if (is_undefined(is_string)) {
  var is_string = function(suspect) {
    return is_typeof(String, suspect);
  };
}

if (is_undefined(is_array)) {
  var is_array = function(suspect) {
    return is_typeof(Array, suspect);
  };
}

if (is_undefined(is_number)) {
  var is_number = function(suspect) {
    return is_typeof(Number, suspect);
  };
}

if (is_undefined(is_date)) {
  var is_date = function(suspect) {
    return is_typeof(Date, suspect);
  };
}

if (is_undefined(is_bool)) {
  var is_bool = function(suspect) {
    return is_typeof(Boolean, suspect);
  };
}

if (is_undefined(is_regex)) {
  var is_regex = function(suspect) {
    return is_typeof(RegExp, suspect);
  };
}
