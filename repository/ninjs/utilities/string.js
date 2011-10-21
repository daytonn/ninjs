String.prototype.is_empty = function() {
	return (this.length < 1) ? true : false;
};

String.prototype.not_empty = function() {
	return (this.length < 1) ? false : true;
};

String.prototype.is_numeric = function() {
	var pattern = /^(\.|-)?\d+(?:\.\d*)?(?:e[+\-]?\d+)?$/i;
	return pattern.test(this);
};

String.prototype.trim = function() {
	return this.replace(/^\s+|\s+$/g, "");
};

String.prototype.ltrim = function() {
	return this.replace(/^\s+/,"");
};

String.prototype.rtrim = function() {
	return this.replace(/\s+$/,"");
};

String.prototype.each = function(callback) {
	if(is_undefined(callback)) {
		throw new SyntaxError("String.each(callback): callback is undefined");
	}

	for (var i = 0; i < this.length; i++) {
		var args = [this.charAt(i), i];
		callback.apply(this, args);
	}
};

String.prototype.capitalize = function() {
	return this.substr(0, 1).toUpperCase() + this.substr(1);
};

String.prototype.reverse = function() {
	return this.split('').reverse().join('');
};

String.prototype.to_n = function() {
	return parseFloat(this);
};

String.prototype.pluck = function(needle) {
	var pattern = new RegExp(needle, 'g');
	return this.replace(pattern, '');
};

String.prototype.single_space = function() {
	var no_hard_spaces = this.replace(/\&nbsp\;/g, ' ');
	return no_hard_spaces.replace(/\s+/g, ' ');
};

String.prototype.compress = function() {
	return this.replace(/\s+/g, '');
};
