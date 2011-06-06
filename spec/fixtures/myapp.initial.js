(function() {
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
	var userAgent = navigator.userAgent;
	var browser = {
		agent: userAgent,
		mozilla: (/mozilla/.test(userAgent.toLowerCase())) && (!/(compatible|webkit)/.test(userAgent.toLowerCase())),
		webkit: /webkit/.test(userAgent.toLowerCase()),
		firefox: /firefox/.test(userAgent.toLowerCase()),
		chrome: /webkit/.test(userAgent.toLowerCase()),
		safari: /safari/.test(userAgent.toLowerCase()),
		opera: /opera/.test(userAgent.toLowerCase()),
		msie: (/msie/.test(userAgent.toLowerCase())) && (!/opera/.test( userAgent.toLowerCase() ))
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
	  } else {
	    window.onload = function() {
	      if (oldonload) {
	        oldonload();
	      }
	      func();
	    }
	  }
	};

	function bindReady() {
		if (readyBound) {
		    return;
	    }

		readyBound = true;

		if (document.addEventListener && !browser.opera) {
			document.addEventListener("DOMContentLoaded", domReady, false);
		}

		if (browser.msie && window == top) (function(){
			if (isReady) return;
			try {
				document.documentElement.doScroll("left");
			} catch(error) {
				setTimeout(arguments.callee, 0);
				return;
			}
		    domReady();
		})();

		if (browser.opera) {
			document.addEventListener( "DOMContentLoaded", function () {
				if (isReady) return;
				for (var i = 0; i < document.styleSheets.length; i++)
					if (document.styleSheets[i].disabled) {
						setTimeout( arguments.callee, 0 );
						return;
					}
	            domReady();
			}, false);
		}

		if (browser.safari) {
		    var numStyles;
			(function(){
				if (isReady) return;
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
	};

	window.NinjsDOM = function() {
		this.cached_selectors = {};
	};

	NinjsDOM.method('ready', function(fn, args) {
		bindReady();

		if (isReady) {
			fn.call(window, []);
		}
		else {
			readyList.push( function() { return fn.call(window, []); } );
		}
	});

	bindReady();
	window.NinjsModule = function(name) {
		this.dom = new NinjsDOM(this);
		this.browser = browser;
		this.data = {};
		this.name = name;
		this.run_tests = false;
		this.tests = [];
	};

	NinjsModule.method('actions', function() {});

	NinjsModule.method('run', function() {
		var mod = this;
		this.dom.ready(function() {
			mod.execute();
		});
	});

	NinjsModule.method('execute', function() {
		if (this.run_tests) {
			this._run_tests();
		}

		this.actions();
	});

	NinjsModule.method('elements', function(elements) {
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
	});

	NinjsModule.method('set_data', function(key, value) {
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
	});

	NinjsModule.method('add_test', function(test_file) {
		this.tests.push(test_file);
	});

	NinjsModule.method('_run_tests', function() {
		var test_template = [];
		test_template.push('<div class="test-results" title="Test Results">');
		test_template.push('<h1 id="qunit-header">' + this.name + ' module tests</h1>');
		test_template.push('<h2 id="qunit-banner"></h2>');
		test_template.push('<h2 id="qunit-userAgent"></h2>');
		test_template.push('<ol id="qunit-tests"></ol>');
		test_template.push('</div>');

		var qunit_dependencies = '<script src="' + _.tests_path +'qunit/qunit.js"></script>';
		$.getScript(_.tests_path + 'qunit/qunit.js');
		var qunit_styles = '<link rel="stylesheet" href="' + _.tests_path + 'qunit/qunit.css">';
		$('body').append(qunit_styles);
		$('body').append(test_template.join("\n"));

		this.tests.each(function(test) {
			$.getScript(_.tests_path + test + '.test.js', function() {
				var test_results_dialog = $('.test-results');
				var height = $(window).height() - 200;
				var width = $(window).width() - 300;
				try {
					test_results_dialog.dialog({
						width: width,
						height: height,
						autoOpen: false,
						buttons: {
							"Thanks buddy": function() {
								test_results_dialog.dialog('close');
							}
						}
					});
					var failed = $('.failed');
					console.log(failed.html());
					test_results_dialog.dialog('open');
				}
				catch(error) {
					alert("Test harness requires jQueryUI");
				}
			});
		});
	});

	window.NinjsApplication = function(base_url, tests_path) {
		if(is_defined(tests_path)) {
			this.tests_path = tests_path;
		}

		if(is_defined(base_url)) {
			this.site_url = function(path) {
				var path = path || '';
				return base_url + path;
			};
		}
	};

	NinjsApplication.method('add_module', function(name) {
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
	});
})();

var myapp = new NinjsApplication();