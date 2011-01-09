//= require "existence"

if (is_undefined(Function.prototype['method'])) {
	Function.prototype.method = function(name, func) {
		try {
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
		}
		catch(error) {
			alert(error.message);
		}
	};
}