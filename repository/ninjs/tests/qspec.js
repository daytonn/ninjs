function QSpec(context) {
	this.context = context;
	this.tests = [];
	this.before = function() {};
	this.after = function() {};
}

QSpec.prototype.run_all = function() {
	var slf = this;
	
	if (this.context !== undefined && typeof this.context === 'string') {
		module(this.context);
	}
	
	var length = this.tests.length;
	
	for (var i = 0; i < length; i++) {
		this.before();
		test(this.tests[i].spec, this.tests[i].assertions); 
		this.after();
	}
};

QSpec.prototype.should = function(spec, assertions) {
	this.tests.push({ spec: spec, assertions: assertions });
};