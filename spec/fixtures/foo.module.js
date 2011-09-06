(function(app) {
	var mod = app.add_module('foo');

	//= require "../elements/foo.elements"

	//= require "../models/foo.model"

	mod.actions = function() {

	};

	mod.run();
})(myapp);