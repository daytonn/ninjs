(function(app) {
	var self = app.add_module('hello');

	//= require "../elements/hello.elements"

	//= require "../models/hello.model"

	app.hello.actions = function() {

	};

	app.hello.run();
})(myapp);