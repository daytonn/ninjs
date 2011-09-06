NinjsModule = function(name) {
	this.dom = new NinjsDOM(this);
	this.data = {};
	this.name = name;
};

NinjsModule.prototype.actions = function() {};

NinjsModule.prototype.run = function() {
	var mod = this;
	this.dom.ready(function() {
		mod.execute();
	});
};

NinjsModule.prototype.execute = function() {
	this.actions();
};

NinjsModule.prototype.elements = function(elements) {
	if (is_undefined(elements)) {
		if (is_typeof(Object, elements)) {
			throw new SyntaxError("NinjsModule.elements(elements): elements is undefined");
		}
		else if (is_string(elements)) {
			throw new SyntaxError("NinjsModule.elements(name): name is undefined");
		}
	}

	if (is_string(elements)) {
		var name = elements;
		return this.dom.cached_selectors[name];
	}
	else {
		var dom = this.dom;
		dom.ready(function() {
			for(var key in elements) {
				if (elements.hasOwnProperty(key)) {
					dom.cached_selectors[key] = elements[key];
				}
			}
		});
	}
};

NinjsModule.prototype.set_data = function(key, value) {
	if (is_undefined(key)) {
		throw new SyntaxError('NinjsModule.set_data(key, value): key is undefined');
	}

	if (is_typeof(String, key) && is_undefined(value)) {
		throw new SyntaxError('NinjsModule.set_data(key, value): value is undefined');
	}

	if (is_typeof(String, key)) {
		this.data[key] = value;
	}
  else if (is_typeof(Object, key)) {
		var data = key;
		for(var property in data) {
			this.data[property] = data[property];
		}
	}

	return this;
};