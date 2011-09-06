is_defined = function(suspect) {
	return ((suspect === undefined) || (suspect === null)) ? false : true;
};

is_undefined = function(suspect) {
	return (suspect === undefined) ? true : false;
};

is_typeof = function(type, suspect) {
	if (is_undefined(type)) {
		throw new SyntaxError("is_typeof(Type, suspect): type is undefined");
	}
	if (is_undefined(suspect)) {
		throw new SyntaxError("is_typeof(Type, suspect): suspect is undefined");
	}

	return (suspect.constructor == type) ? true : false;
};

is_numeric = function(suspect) {
	if(is_typeof(Number, suspect)) {
		return true;
	}
	else {
		var pattern = /^-?\d+(?:\.\d*)?(?:e[+\-]?\d+)?$/i;
		return pattern.test(suspect);
	}
};

is_string = function(suspect) {
	return is_typeof(String, suspect);
};

is_array = function(suspect) {
	return is_typeof(Array, suspect);
};

is_number = function(suspect) {
	return is_typeof(Number, suspect);
};

is_date = function(suspect) {
	return is_typeof(Date, suspect);
};

is_bool = function(suspect) {
	return is_typeof(Boolean, suspect);
};

is_regex = function(suspect) {
	return is_typeof(RegExp, suspect);
};

is_empty = function(suspect) {
	return suspect.length === 0;
};

is_not_empty = function(suspect) {
	return suspect.length >= 1;
};
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
var dom = (function() {
	var userAgent = navigator.userAgent;
	var browser = {
		agent: userAgent,
		mozilla: (/mozilla/.test(userAgent.toLowerCase())) && !(/(compatible|webkit)/.test(userAgent.toLowerCase())),
		webkit: /webkit/.test(userAgent.toLowerCase()),
		firefox: /firefox/.test(userAgent.toLowerCase()),
		chrome: /webkit/.test(userAgent.toLowerCase()),
		safari: /safari/.test(userAgent.toLowerCase()),
		opera: /opera/.test(userAgent.toLowerCase()),
		msie: (/msie/.test(userAgent.toLowerCase())) && !(/opera/.test( userAgent.toLowerCase() ))
	};

	var readyBound = false;
	var isReady = false;
	var readyList = [];

	function domReady() {
		if (!isReady) {
			isReady = true;
			if (readyList) {
				for(var fn = 0; fn < readyList.length; fn++) {
					readyList[fn].call(window, []);
				}
				readyList = [];
			}
		}
	}

	function addLoadEvent(func) {
		var oldonload = window.onload;
		if (typeof window.onload != 'function') {
			window.onload = func;
		}
		else {
			window.onload = function() {
				if (oldonload) {
					oldonload();
				}
				func();
			};
		}
	}

	function bindReady() {
		if (readyBound) {
			return;
		}

		readyBound = true;

		if (document.addEventListener && !browser.opera) {
			document.addEventListener("DOMContentLoaded", domReady, false);
		}

		if (browser.msie && window == top) {
			(function() {
				if (isReady) {
					return;
				}
				try {
					document.documentElement.doScroll("left");
				} catch(error) {
					setTimeout(arguments.callee, 0);
					return;
				}
				domReady();
			})();
		}

		if (browser.opera) {
			document.addEventListener( "DOMContentLoaded", function () {
				if (isReady) {
					return;
				}
				for (var i = 0; i < document.styleSheets.length; i++) {
					if (document.styleSheets[i].disabled) {
						setTimeout( arguments.callee, 0 );
						return;
					}
					domReady();
				}
			}, false);
		}

		if (browser.safari) {
			var numStyles;
			(function() {
				if (isReady) {
					return;
				}
				if (document.readyState != "loaded" && document.readyState != "complete") {
					setTimeout( arguments.callee, 0 );
					return;
				}
				if (numStyles === undefined) {
					var links = document.getElementsByTagName("link");
					for (var i=0; i < links.length; i++) {
						if (links[i].getAttribute('rel') == 'stylesheet') {
							numStyles++;
						}
					}
					var styles = document.getElementsByTagName("style");
					numStyles += styles.length;
				}
				if (document.styleSheets.length != numStyles) {
					setTimeout( arguments.callee, 0 );
					return;
				}

				domReady();
			})();
		}

		addLoadEvent(domReady);
	}

	return {
		bind: bindReady,
		is_ready: isReady,
		ready_list: readyList
	};
})();

NinjsDOM = function() {
	this.cached_selectors = {};
};

NinjsDOM.prototype.ready = function(fn, args) {
	dom.bind();

	if (dom.is_ready()) {
		fn.call(window, args || []);
	}
	else {
		dom.ready_list.push( function() { return fn.call(window, args || []); } );
	}
};

dom.bind();
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
