describe("Extensions", function() {
  it("should test a negated conditional with unless", function() {
    var is_true = false,
        does_fallback_work = false;
    
    unless (false,
      function() {
        is_true = true;
      }
    );

    unless (true,
      function() {},
      function() {
        does_fallback_work = true;
      }
    );

    expect(is_true).toBeTruthy();
    expect(does_fallback_work).toBeTruthy();
  });
});