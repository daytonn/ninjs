// Slightly modified version of domready: http://code.google.com/p/domready/
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

	// From Simon Willison. A safe way to fire onload w/o screwing up everyone else.
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

	// does the heavy work of working through the browsers idiosyncracies (let's call them that) to hook onload.
	function bindReady() {
		if (readyBound) {
			return;
		}

		readyBound = true;

		// Mozilla, Opera (see further below for it) and webkit nightlies currently support this event
		if (document.addEventListener && !browser.opera) {
			// Use the handy event callback
			document.addEventListener("DOMContentLoaded", domReady, false);
		}

		// If IE is used and is not in a frame
		// Continually check to see if the document is ready
		if (browser.msie && window == top) {
			(function() {
				if (isReady) {
					return;
				}
				try {
					// If IE is used, use the trick by Diego Perini
					// http://javascript.nwbox.com/IEContentLoaded/
					document.documentElement.doScroll("left");
				} catch(error) {
					setTimeout(arguments.callee, 0);
					return;
				}
				// and execute any waiting functions
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
					// and execute any waiting functions
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

				// and execute any waiting functions
				domReady();
			})();
		}

		// A fallback to window.onload, that will always work
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

// This is the public function that people can use to hook up ready.
NinjsDOM.prototype.ready = function(fn, args) {
	// Attach the listeners
	dom.bind();

	// If the DOM is already ready
	if (dom.is_ready()) {
		// Execute the function immediately
		fn.call(window, args || []);
	}
	else {
		// Add the function to the wait list
		dom.ready_list.push( function() { return fn.call(window, args || []); } );
	}
};

dom.bind();
