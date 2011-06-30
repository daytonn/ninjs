var spec = new QSpec("NinjsApplication");

spec.before = function() {
	this.app = new NinjsApplication('myapp');
};

spec.after = function() {
	delete this.app;
};

spec.should("create a ninjs application object", function() {
	this.app = new NinjsApplication('myapp');
	ok(is_defined(this.app), 'app is defined');
	ok(is_typeof(NinjsApplication, this.app), 'app is a valid NinjsApplication');
});

spec.should("create a NinjsModule", function() {
	this.app = new NinjsApplication('myapp');
	this.app.add_module('mymod');

	ok(is_typeof(NinjsModule, this.app.mymod), 'app.mymod is a valid NinjsModule');
});

spec.run_all();