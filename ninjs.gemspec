# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ninjs}
  s.version = "0.9.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dayton Nolan"]
  s.date = Time.now.strftime '%Y-%m-%d'
  s.default_executable = %q{bin/ninjs}
  s.description = %q{Ninjs is a javascript meta framework. Ninjs uses the Sprockets engine (http://getsprockets.org/) to allow you to create modular javascript applications.}
  s.email = %q{daytonn@gmail.com}
  s.executables = ["ninjs"]
  s.files = ["bin/ninjs",
             "lib/ninjs.rb",
             "lib/ninjs/command.rb",
             "lib/ninjs/configuration.rb",
             "lib/ninjs/dependencies.rb",
             "lib/ninjs/helpers.rb",
             "lib/ninjs/manifest.rb",
             "lib/ninjs/project.rb",
             "repository/jquery/1.1.4.js",
             "repository/jquery/1.2.6.js",
             "repository/jquery/1.3.2.js",
             "repository/jquery/1.4.2.js",
             "repository/jquery/1.4.3.js",
             "repository/jquery/1.4.4.js",
             "repository/jquery/latest.js",
             "repository/jquery/fancybox/1.3.1.js",
             "repository/jquery/fancybox/latest.js",
             "repository/jquery/fancybox/assets/1.3.1/css/fancybox.css",
             "repository/jquery/fancybox/assets/1.3.1/images/fancybox/blank.gif",
             "repository/jquery/fancybox/assets/1.3.1/images/fancybox/fancy_close.png",
             "repository/jquery/fancybox/assets/1.3.1/images/fancybox/fancy_loading.png",
             "repository/jquery/fancybox/assets/1.3.1/images/fancybox/fancy_nav_left.png",
             "repository/jquery/fancybox/assets/1.3.1/images/fancybox/fancy_nav_right.png",
             "repository/jquery/fancybox/assets/1.3.1/images/fancybox/fancy_shadow_e.png",
             "repository/jquery/fancybox/assets/1.3.1/images/fancybox/fancy_shadow_n.png",
             "repository/jquery/fancybox/assets/1.3.1/images/fancybox/fancy_shadow_ne.png",
             "repository/jquery/fancybox/assets/1.3.1/images/fancybox/fancy_shadow_nw.png",
             "repository/jquery/fancybox/assets/1.3.1/images/fancybox/fancy_shadow_s.png",
             "repository/jquery/fancybox/assets/1.3.1/images/fancybox/fancy_shadow_se.png",
             "repository/jquery/fancybox/assets/1.3.1/images/fancybox/fancy_shadow_sw.png",
             "repository/jquery/fancybox/assets/1.3.1/images/fancybox/fancy_shadow_w.png",
             "repository/jquery/fancybox/assets/1.3.1/images/fancybox/fancy_title_left.png",
             "repository/jquery/fancybox/assets/1.3.1/images/fancybox/fancy_title_main.png",
             "repository/jquery/fancybox/assets/1.3.1/images/fancybox/fancy_title_over.png",
             "repository/jquery/fancybox/assets/1.3.1/images/fancybox/fancy_title_right.png",
             "repository/jquery/fancybox/assets/1.3.1/images/fancybox/fancybox-x.png",
             "repository/jquery/fancybox/assets/1.3.1/images/fancybox/fancybox-y.png",
             "repository/jquery/fancybox/assets/1.3.1/images/fancybox/fancybox.png",
             "repository/jquery/mousewheel/3.0.2.js",
             "repository/jquery/mousewheel/latest.js",
             "repository/modernizr/1.5.js",
             "repository/modernizr/latest.js",
             "repository/ninjs/core/existence.js",
             "repository/ninjs/core/extend.js",
             "repository/ninjs/core/nin.js",
             "repository/ninjs/tests/index.html",
             "repository/ninjs/tests/ninjs.test.js",
             "repository/ninjs/tests/ninjs.utilities.test.js",
             "repository/ninjs/utilities/all.js",
             "repository/ninjs/utilities/array.js",
             "repository/ninjs/utilities/css.js",
             "repository/ninjs/utilities/number.js",
             "repository/ninjs/utilities/string.js",
             "repository/qunit/qunit.js",
             "repository/qunit/assets/css/qunit.css",
             "repository/selectivizr/1.0.js",
             "repository/selectivizr/latest.js",
             "repository/syntaxhighlighter/default.js",
             "repository/syntaxhighlighter/shAutoloader.js",
             "repository/syntaxhighlighter/shBrushAppleScript.js",
             "repository/syntaxhighlighter/shBrushAS3.js",
             "repository/syntaxhighlighter/shBrushBash.js",
             "repository/syntaxhighlighter/shBrushColdFusion.js",
             "repository/syntaxhighlighter/shBrushCpp.js",
             "repository/syntaxhighlighter/shBrushCSharp.js",
             "repository/syntaxhighlighter/shBrushCss.js",
             "repository/syntaxhighlighter/shBrushDelphi.js",
             "repository/syntaxhighlighter/shBrushDiff.js",
             "repository/syntaxhighlighter/shBrushErlang.js",
             "repository/syntaxhighlighter/shBrushGroovy.js",
             "repository/syntaxhighlighter/shBrushJava.js",
             "repository/syntaxhighlighter/shBrushJavaFX.js",
             "repository/syntaxhighlighter/shBrushJScript.js",
             "repository/syntaxhighlighter/shBrushPerl.js",
             "repository/syntaxhighlighter/shBrushPhp.js",
             "repository/syntaxhighlighter/shBrushPlain.js",
             "repository/syntaxhighlighter/shBrushPowerShell.js",
             "repository/syntaxhighlighter/shBrushPython.js",
             "repository/syntaxhighlighter/shBrushRuby.js",
             "repository/syntaxhighlighter/shBrushSass.js",
             "repository/syntaxhighlighter/shBrushScala.js",
             "repository/syntaxhighlighter/shBrushSql.js",
             "repository/syntaxhighlighter/shBrushVb.js",
             "repository/syntaxhighlighter/shBrushXml.js",
             "repository/syntaxhighlighter/shCore.js",
             "repository/syntaxhighlighter/shLegacy.js",
             "repository/json2.js",
             "repository/nullconsole.js",
             "spec/spec_helper.rb",
             "spec/test_spec.rb",
             "LICENSE",
             "ninjs.gemspec",
             "README.textile"]
  s.homepage = %q{http://textnotspeech.github.com/ninjs/}
  s.add_dependency 'rubikon'
  s.add_dependency 'fssm'
  s.add_dependency 'jsmin'
  s.add_dependency 'sprockets'
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{ninjs is a command line application to help you write clean, modular javascript applications.}
end