(function($) { 
	NinjsModule.prototype.elements = function(elements, force) {
		var self = this;

		unless(is_defined(force), function() {
			force = false;
		});

		if (is_string(elements)) {
			var key = elements;
			if (is_undefined(self.dom[key])) {
				throw new SyntaxError("NinjsModule.elements('" + key + "'): " + self.name + ".dom." + key + " is undefined");
			}

			if (is_string(self.dom[key])) {
				var selection = $(self.dom[key]);

				unless(selection.length === 0, function() {
					return self.dom[key] = selection;
				}, function() {
					return self.dom[key];
				});
			}
			else {
				if (self.dom[key].length === 0 || force) {

					var return_obj = undefined;

					if (is_string(force)) {
						var selector = self.dom[key].selector;
						self.dom[key] = $(force).find(selector);
						self.dom[key].selector = selector;

						return_obj = self.dom[key];
					}

					var selection = $(self.dom[key].selector);
				
					unless(selection.length === 0, function() {
						return_obj = selection;
					});

					return return_obj;
				}
				else {
					return self.dom[key];
				}
			}
		}
		else if (is_typeof(Object, elements)) {
			self.call_on_ready(function() {
				for(var key in elements) {
					if (elements.hasOwnProperty(key)) {
						self.dom[key] = elements[key];
					}
				}
			});
		}
	};
})(jQuery);