	if (window.is_defined === undefined) {
		window.is_defined = function(suspect) {
			return ((suspect === undefined) || (suspect === null)) ? false : true;
		};
	}

	if (!is_defined(window.is_undefined)) {
		window.is_undefined = function(suspect) {
			return (suspect === undefined) ? true : false;
		};
	}

	if (is_undefined(window.is_typeof)) {
		window.is_typeof = function(type, suspect) {
			if (is_undefined(type)) {
				throw new SyntaxError("is_typeof(Type, suspect): type is undefined");
			}
			if (is_undefined(suspect)) {
				throw new SyntaxError("is_typeof(Type, suspect): suspect is undefined");
			}

			return (suspect.constructor == type) ? true : false;
		};
	}

	if (is_undefined(window.is_numeric)) {
		window.is_numeric = function(suspect) {
			if(is_typeof(Number, suspect)) {
				return true;
			}
			else {
				var pattern = /^-?\d+(?:\.\d*)?(?:e[+\-]?\d+)?$/i;
				return pattern.test(suspect);
			}
		};
	}

	if (is_undefined(window.is_string)) {
		window.is_string = function(suspect) {
			return is_typeof(String, suspect);
		};
	}

	if (is_undefined(window.is_array)) {
		window.is_array = function(suspect) {
			return is_typeof(Array, suspect);
		};
	}

	if (is_undefined(window.is_number)) {
		window.is_number = function(suspect) {
			return is_typeof(Number, suspect);
		};
	}

	if (is_undefined(window.is_date)) {
		window.is_date = function(suspect) {
			return is_typeof(Date, suspect);
		};
	}

	if (is_undefined(window.is_bool)) {
		window.is_bool = function(suspect) {
			return is_typeof(Boolean, suspect);
		};
	}

	if (is_undefined(window.is_regex)) {
		window.is_regex = function(suspect) {
			return is_typeof(RegExp, suspect);
		};
	}

	if (is_undefined(window.is_empty)) {
		window.is_empty = function(suspect) {
			return suspect.length === 0;
		};
	}

	if (is_undefined(window.is_not_empty)) {
		window.is_not_empty = function(suspect) {
			return suspect.length >= 1;
		};
	}

	if (is_undefined(Function.prototype['method'])) {
		Function.prototype.method = function(name, func) {
			if (is_undefined(name)) {
				throw new SyntaxError("Object.method(name, func): name is undefined");
			}

			if (is_undefined(func)) {
				throw new SyntaxError("Object.method(name, func): func is undefined");
			}

			if (is_undefined(this.prototype[name])) {
				this.prototype[name] = func;
				return this;
			}
		};
	}

	if (is_undefined(window.unless)) {
		window.unless = function(expression, callback, fallback) {
			if (is_undefined(expression)) {
				throw new SyntaxError("unless(expression, callback[, fallback]): expression is undefined");
			}

			if (is_undefined(callback)) {
				throw new SyntaxError("unless(expression, callback[, fallback]): callback is undefined");
			}

			if (!expression) {
				callback.call(this);
			}
			else if (is_defined(fallback)) {
				fallback.call(this);
			}
		};
	}
