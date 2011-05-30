(function(app) {
	var self = app.add_module('foo');

	//= require "../elements/foo.elements"

	//= require "../models/foo.model"

	app.foo.actions = function() {

	};

	app.foo.run();
})(myapp);