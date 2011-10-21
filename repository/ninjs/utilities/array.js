Array.prototype.is_empty = function() {
	return is_empty(this);
};

Array.prototype.not_empty = function() {
	return is_not_empty(this);
};

Array.prototype.each = function(callback) {
	if(is_undefined(callback)) {
		throw new SyntaxError("Array.each(callback): callback is undefined");
	}

	for (var i = 0; i < this.length; i++) {
		var args = [this[i], i];
		callback.apply(this, args);
	}
};

Array.prototype.contains = function(suspect) {
	var matches = [];
	this.each(function(value, index) {
		if(value === suspect) {
			matches.push(index);
		}
	});

	return matches.not_empty() ? matches : false;
};