NinjsApplication = function() {};

NinjsApplication.prototype.add_module = function(name) {
	if (is_undefined(name)) {
		throw new SyntaxError("NinjsApplication.add_module(name): name is undefined");
	}

	if (is_defined(this[name])) {
		throw new SyntaxError("NinjsApplication.add_module(name): '" + name + "' already declared");
	}

	if (this.name === name) {
		throw new SyntaxError("NinjsApplication.add_module(name): a module cannot have the same name as the application");
	}

	return this[name] = new NinjsModule(name);
};
