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
			if (is_undefined(callback)) {
				throw new SyntaxError("unless(expression, callback[, fallback]): callback is undefined");
			}

			if (!!!expression) {
				callback.call(this);
			}
			else if (is_defined(fallback)) {
				fallback.call(this);
			}
		};
	}
