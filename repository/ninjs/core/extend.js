unless = function(expression, callback, fallback) {
	if (is_undefined(callback)) {
		throw new SyntaxError("unless(expression, callback[, fallback]): callback is undefined");
	}

	if (!!!expression) {
		callback.call(this);
	}
	else {
		if (is_defined(fallback)) {
			fallback.call(this);
		}
	}
};