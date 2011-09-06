var Cookie = function(name, data, exp) {
	if (is_undefined(name)) {
		throw new SyntaxError('new Cookie(name, data[, exp]): name is undefined');
	}

	function set_exp(days) {
		var date = new Date();
		date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
		var expires = "; expires=" + date.toGMTString();
	}

	this.name = name;

	unless(this.read(), function() {
		if (is_undefined(data)) {
			this.data = '';
		}
		else {
			this.data = data;
		}

		if (is_defined(days)) {
			this.exp = set_exp(days);
		}
		else {
			this.exp = '';
		}
	});

	this.save();
};

Cookie.prototype.save = function() {
	document.cookie = this.name + "=" + this.data + this.exp + "; path=/";
};

Cookie.prototype.read = function() {
	var nameEQ = this.name + "=";
	var ca = document.cookie.split(';');
	var length = ca.length;

	for (var i = 0; i < length; i++) {
		var c = ca[i];
		while (c.charAt(0) == ' ') {
			c = c.substring(1, c.length);
		}
		if (c.indexOf(nameEQ) === 0) {
			return c.substring(nameEQ.length,c.length);
		}
	}

	return null;
};

Cookie.prototype.remove = function() {
	this.data = '';
	this.exp = -1;
	this.save();
};