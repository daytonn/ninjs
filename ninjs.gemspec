# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ninjs}
  s.version = "0.14.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dayton Nolan"]
  s.date = %q{2011-06-05}
  s.default_executable = %q{ninjs}
  s.description = %q{Ninjs is a ruby application and small javascript framework that helps you build clean, modular javascript applications. Ninjs encourages "Good Parts" best practices and the Crockford school Module pattern (http://www.crockford.com/). The ninjs command line application is an automatic compiler, written in ruby, and based on the Sprockets library (http://getsprockets.org/).}
  s.email = %q{daytonn@gmail.com}
  s.executables = ["ninjs"]
  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  s.files = [
    ".bundle/config",
    "CNAME",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE",
    "README.md",
    "Rakefile",
    "VERSION",
    "bin/ninjs",
    "lib/ninjs.rb",
    "lib/ninjs/command.rb",
    "lib/ninjs/configuration.rb",
    "lib/ninjs/dependencies.rb",
    "lib/ninjs/generator.rb",
    "lib/ninjs/helpers.rb",
    "lib/ninjs/manifest.rb",
    "lib/ninjs/notification.rb",
    "lib/ninjs/project.rb",
    "ninjs.gemspec",
    "repository/jquery/1.1.4.js",
    "repository/jquery/1.2.6.js",
    "repository/jquery/1.3.2.js",
    "repository/jquery/1.4.2.js",
    "repository/jquery/1.4.3.js",
    "repository/jquery/1.4.4.js",
    "repository/jquery/1.5.js",
    "repository/jquery/fancybox/1.3.1.js",
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
    "repository/jquery/fancybox/assets/1.3.1/images/fancybox/jquery.easing-1.3.pack.js",
    "repository/jquery/fancybox/latest.js",
    "repository/jquery/latest.js",
    "repository/jquery/mobile/1.0a3.js",
    "repository/jquery/mobile/1.0a3/assets/css/jquery.mobile.css",
    "repository/jquery/mobile/1.0a3/assets/images/jquerymobile/ajax-loader.png",
    "repository/jquery/mobile/1.0a3/assets/images/jquerymobile/form-check-off.png",
    "repository/jquery/mobile/1.0a3/assets/images/jquerymobile/form-check-on.png",
    "repository/jquery/mobile/1.0a3/assets/images/jquerymobile/form-radio-off.png",
    "repository/jquery/mobile/1.0a3/assets/images/jquerymobile/form-radio-on.png",
    "repository/jquery/mobile/1.0a3/assets/images/jquerymobile/icon-search-black.png",
    "repository/jquery/mobile/1.0a3/assets/images/jquerymobile/icons-18-black.png",
    "repository/jquery/mobile/1.0a3/assets/images/jquerymobile/icons-18-white.png",
    "repository/jquery/mobile/1.0a3/assets/images/jquerymobile/icons-36-black.png",
    "repository/jquery/mobile/1.0a3/assets/images/jquerymobile/icons-36-white.png",
    "repository/jquery/mobile/latest.js",
    "repository/jquery/mousewheel/3.0.2.js",
    "repository/jquery/mousewheel/latest.js",
    "repository/jquery/ui/1.8.7.js",
    "repository/jquery/ui/assets/1.8.7/css/jqueryui/jquery.ui.accordion.css",
    "repository/jquery/ui/assets/1.8.7/css/jqueryui/jquery.ui.all.css",
    "repository/jquery/ui/assets/1.8.7/css/jqueryui/jquery.ui.autocomplete.css",
    "repository/jquery/ui/assets/1.8.7/css/jqueryui/jquery.ui.base.css",
    "repository/jquery/ui/assets/1.8.7/css/jqueryui/jquery.ui.button.css",
    "repository/jquery/ui/assets/1.8.7/css/jqueryui/jquery.ui.core.css",
    "repository/jquery/ui/assets/1.8.7/css/jqueryui/jquery.ui.datepicker.css",
    "repository/jquery/ui/assets/1.8.7/css/jqueryui/jquery.ui.dialog.css",
    "repository/jquery/ui/assets/1.8.7/css/jqueryui/jquery.ui.progressbar.css",
    "repository/jquery/ui/assets/1.8.7/css/jqueryui/jquery.ui.resizable.css",
    "repository/jquery/ui/assets/1.8.7/css/jqueryui/jquery.ui.selectable.css",
    "repository/jquery/ui/assets/1.8.7/css/jqueryui/jquery.ui.slider.css",
    "repository/jquery/ui/assets/1.8.7/css/jqueryui/jquery.ui.tabs.css",
    "repository/jquery/ui/assets/1.8.7/css/jqueryui/jquery.ui.theme.css",
    "repository/jquery/ui/assets/1.8.7/images/jqueryui/ui-bg_flat_0_aaaaaa_40x100.png",
    "repository/jquery/ui/assets/1.8.7/images/jqueryui/ui-bg_flat_75_ffffff_40x100.png",
    "repository/jquery/ui/assets/1.8.7/images/jqueryui/ui-bg_glass_55_fbf9ee_1x400.png",
    "repository/jquery/ui/assets/1.8.7/images/jqueryui/ui-bg_glass_65_ffffff_1x400.png",
    "repository/jquery/ui/assets/1.8.7/images/jqueryui/ui-bg_glass_75_dadada_1x400.png",
    "repository/jquery/ui/assets/1.8.7/images/jqueryui/ui-bg_glass_75_e6e6e6_1x400.png",
    "repository/jquery/ui/assets/1.8.7/images/jqueryui/ui-bg_glass_95_fef1ec_1x400.png",
    "repository/jquery/ui/assets/1.8.7/images/jqueryui/ui-bg_highlight-soft_75_cccccc_1x100.png",
    "repository/jquery/ui/assets/1.8.7/images/jqueryui/ui-icons_222222_256x240.png",
    "repository/jquery/ui/assets/1.8.7/images/jqueryui/ui-icons_2e83ff_256x240.png",
    "repository/jquery/ui/assets/1.8.7/images/jqueryui/ui-icons_454545_256x240.png",
    "repository/jquery/ui/assets/1.8.7/images/jqueryui/ui-icons_888888_256x240.png",
    "repository/jquery/ui/assets/1.8.7/images/jqueryui/ui-icons_cd0a0a_256x240.png",
    "repository/jquery/ui/latest.js",
    "repository/json2.js",
    "repository/modernizr/1.5.js",
    "repository/modernizr/latest.js",
    "repository/ninjs/core/.core.pdoc.yaml",
    "repository/ninjs/core/.existence.pdoc.yaml",
    "repository/ninjs/core/.extend.pdoc.yaml",
    "repository/ninjs/core/.nin.pdoc.yaml",
    "repository/ninjs/core/application.js",
    "repository/ninjs/core/dom.js",
    "repository/ninjs/core/existence.js",
    "repository/ninjs/core/extend.js",
    "repository/ninjs/core/module.js",
    "repository/ninjs/core/nin.js",
    "repository/ninjs/docs/Data/ClassHierarchy.nd",
    "repository/ninjs/docs/Data/ConfigFileInfo.nd",
    "repository/ninjs/docs/Data/FileInfo.nd",
    "repository/ninjs/docs/Data/ImageFileInfo.nd",
    "repository/ninjs/docs/Data/ImageReferenceTable.nd",
    "repository/ninjs/docs/Data/IndexInfo.nd",
    "repository/ninjs/docs/Data/PreviousMenuState.nd",
    "repository/ninjs/docs/Data/PreviousSettings.nd",
    "repository/ninjs/docs/Data/SymbolTable.nd",
    "repository/ninjs/docs/Languages.txt",
    "repository/ninjs/docs/Menu.txt",
    "repository/ninjs/docs/Topics.txt",
    "repository/ninjs/docs/files/core/application-js.html",
    "repository/ninjs/docs/files/core/existence-js.html",
    "repository/ninjs/docs/files/core/extend-js.html",
    "repository/ninjs/docs/files/core/module-js.html",
    "repository/ninjs/docs/files/core/nin-js.html",
    "repository/ninjs/docs/index.html",
    "repository/ninjs/docs/index/Classes.html",
    "repository/ninjs/docs/index/Files.html",
    "repository/ninjs/docs/index/Functions.html",
    "repository/ninjs/docs/index/General.html",
    "repository/ninjs/docs/index/Variables.html",
    "repository/ninjs/docs/javascript/main.js",
    "repository/ninjs/docs/javascript/prettify.js",
    "repository/ninjs/docs/javascript/searchdata.js",
    "repository/ninjs/docs/search/ClassesN.html",
    "repository/ninjs/docs/search/FilesA.html",
    "repository/ninjs/docs/search/FilesE.html",
    "repository/ninjs/docs/search/FilesM.html",
    "repository/ninjs/docs/search/FilesN.html",
    "repository/ninjs/docs/search/FunctionsA.html",
    "repository/ninjs/docs/search/FunctionsC.html",
    "repository/ninjs/docs/search/FunctionsE.html",
    "repository/ninjs/docs/search/FunctionsI.html",
    "repository/ninjs/docs/search/FunctionsM.html",
    "repository/ninjs/docs/search/FunctionsR.html",
    "repository/ninjs/docs/search/FunctionsS.html",
    "repository/ninjs/docs/search/FunctionsSymbols.html",
    "repository/ninjs/docs/search/FunctionsU.html",
    "repository/ninjs/docs/search/GeneralA.html",
    "repository/ninjs/docs/search/GeneralC.html",
    "repository/ninjs/docs/search/GeneralD.html",
    "repository/ninjs/docs/search/GeneralE.html",
    "repository/ninjs/docs/search/GeneralF.html",
    "repository/ninjs/docs/search/GeneralI.html",
    "repository/ninjs/docs/search/GeneralM.html",
    "repository/ninjs/docs/search/GeneralN.html",
    "repository/ninjs/docs/search/GeneralR.html",
    "repository/ninjs/docs/search/GeneralS.html",
    "repository/ninjs/docs/search/GeneralSymbols.html",
    "repository/ninjs/docs/search/GeneralT.html",
    "repository/ninjs/docs/search/GeneralU.html",
    "repository/ninjs/docs/search/GeneralV.html",
    "repository/ninjs/docs/search/NoResults.html",
    "repository/ninjs/docs/search/VariablesD.html",
    "repository/ninjs/docs/search/VariablesN.html",
    "repository/ninjs/docs/search/VariablesR.html",
    "repository/ninjs/docs/search/VariablesT.html",
    "repository/ninjs/docs/styles/main.css",
    "repository/ninjs/extensions/jquery.elements.js",
    "repository/ninjs/tests/application.test.js",
    "repository/ninjs/tests/array.utilities.test.js",
    "repository/ninjs/tests/existence.test.js",
    "repository/ninjs/tests/extension.test.js",
    "repository/ninjs/tests/index.html",
    "repository/ninjs/tests/module.test.js",
    "repository/ninjs/tests/qspec.js",
    "repository/ninjs/tests/string.utilities.test.js",
    "repository/ninjs/utilities/all.js",
    "repository/ninjs/utilities/array.js",
    "repository/ninjs/utilities/cookie.js",
    "repository/ninjs/utilities/css.js",
    "repository/ninjs/utilities/number.js",
    "repository/ninjs/utilities/string.js",
    "repository/nullconsole.js",
    "repository/qunit/assets/css/qunit.css",
    "repository/qunit/qunit.js",
    "repository/selectivizr/1.0.js",
    "repository/selectivizr/latest.js",
    "repository/syntaxhighlighter/all.js",
    "repository/syntaxhighlighter/assets/css/syntaxhighlighter/shCore.css",
    "repository/syntaxhighlighter/assets/css/syntaxhighlighter/shCoreDefault.css",
    "repository/syntaxhighlighter/assets/css/syntaxhighlighter/shCoreDjango.css",
    "repository/syntaxhighlighter/assets/css/syntaxhighlighter/shCoreEclipse.css",
    "repository/syntaxhighlighter/assets/css/syntaxhighlighter/shCoreEmacs.css",
    "repository/syntaxhighlighter/assets/css/syntaxhighlighter/shCoreFadeToGrey.css",
    "repository/syntaxhighlighter/assets/css/syntaxhighlighter/shCoreMDUltra.css",
    "repository/syntaxhighlighter/assets/css/syntaxhighlighter/shCoreMidnight.css",
    "repository/syntaxhighlighter/assets/css/syntaxhighlighter/shCoreRDark.css",
    "repository/syntaxhighlighter/assets/css/syntaxhighlighter/shThemeDefault.css",
    "repository/syntaxhighlighter/assets/css/syntaxhighlighter/shThemeDjango.css",
    "repository/syntaxhighlighter/assets/css/syntaxhighlighter/shThemeEclipse.css",
    "repository/syntaxhighlighter/assets/css/syntaxhighlighter/shThemeEmacs.css",
    "repository/syntaxhighlighter/assets/css/syntaxhighlighter/shThemeFadeToGrey.css",
    "repository/syntaxhighlighter/assets/css/syntaxhighlighter/shThemeMDUltra.css",
    "repository/syntaxhighlighter/assets/css/syntaxhighlighter/shThemeMidnight.css",
    "repository/syntaxhighlighter/assets/css/syntaxhighlighter/shThemeRDark.css",
    "repository/syntaxhighlighter/assets/scss/syntaxhighlighter/_shCore.scss",
    "repository/syntaxhighlighter/assets/scss/syntaxhighlighter/_shCoreDefault.scss",
    "repository/syntaxhighlighter/assets/scss/syntaxhighlighter/_shCoreDjango.scss",
    "repository/syntaxhighlighter/assets/scss/syntaxhighlighter/_shCoreEclipse.scss",
    "repository/syntaxhighlighter/assets/scss/syntaxhighlighter/_shCoreEmacs.scss",
    "repository/syntaxhighlighter/assets/scss/syntaxhighlighter/_shCoreFadeToGrey.scss",
    "repository/syntaxhighlighter/assets/scss/syntaxhighlighter/_shCoreMDUltra.scss",
    "repository/syntaxhighlighter/assets/scss/syntaxhighlighter/_shCoreMidnight.scss",
    "repository/syntaxhighlighter/assets/scss/syntaxhighlighter/_shCoreRDark.scss",
    "repository/syntaxhighlighter/assets/scss/syntaxhighlighter/_shThemeDefault.scss",
    "repository/syntaxhighlighter/assets/scss/syntaxhighlighter/_shThemeDjango.scss",
    "repository/syntaxhighlighter/assets/scss/syntaxhighlighter/_shThemeEclipse.scss",
    "repository/syntaxhighlighter/assets/scss/syntaxhighlighter/_shThemeEmacs.scss",
    "repository/syntaxhighlighter/assets/scss/syntaxhighlighter/_shThemeFadeToGrey.scss",
    "repository/syntaxhighlighter/assets/scss/syntaxhighlighter/_shThemeMDUltra.scss",
    "repository/syntaxhighlighter/assets/scss/syntaxhighlighter/_shThemeMidnight.scss",
    "repository/syntaxhighlighter/assets/scss/syntaxhighlighter/_shThemeRDark.scss",
    "repository/syntaxhighlighter/assets/scss/syntaxhighlighter/_theme_template.scss",
    "repository/syntaxhighlighter/shAutoloader.js",
    "repository/syntaxhighlighter/shBrushAS3.js",
    "repository/syntaxhighlighter/shBrushAppleScript.js",
    "repository/syntaxhighlighter/shBrushBash.js",
    "repository/syntaxhighlighter/shBrushCSharp.js",
    "repository/syntaxhighlighter/shBrushColdFusion.js",
    "repository/syntaxhighlighter/shBrushCpp.js",
    "repository/syntaxhighlighter/shBrushCss.js",
    "repository/syntaxhighlighter/shBrushDelphi.js",
    "repository/syntaxhighlighter/shBrushDiff.js",
    "repository/syntaxhighlighter/shBrushErlang.js",
    "repository/syntaxhighlighter/shBrushGroovy.js",
    "repository/syntaxhighlighter/shBrushJScript.js",
    "repository/syntaxhighlighter/shBrushJava.js",
    "repository/syntaxhighlighter/shBrushJavaFX.js",
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
    "spec/cli_spec.rb",
    "spec/command_spec.rb",
    "spec/configuration_spec.rb",
    "spec/dependencies_spec.rb",
    "spec/fixtures/autoload.js",
    "spec/fixtures/changed.ninjs.conf",
    "spec/fixtures/compressed.myapp.js",
    "spec/fixtures/core.js",
    "spec/fixtures/dependencies.js",
    "spec/fixtures/foo.elements.js",
    "spec/fixtures/foo.js",
    "spec/fixtures/foo.model.js",
    "spec/fixtures/foo.module.js",
    "spec/fixtures/hello.elements.js",
    "spec/fixtures/hello.js",
    "spec/fixtures/hello.model.js",
    "spec/fixtures/hello.module.js",
    "spec/fixtures/myapp.initial.js",
    "spec/fixtures/myapp.js",
    "spec/fixtures/mymodule.alias.module.js",
    "spec/fixtures/mymodule.dependencies.module.js",
    "spec/fixtures/mymodule.elements.js",
    "spec/fixtures/mymodule.model.js",
    "spec/fixtures/mymodule.module.js",
    "spec/fixtures/new.ninjs.conf",
    "spec/fixtures/nin.js",
    "spec/fixtures/ninjs.conf",
    "spec/generator_spec.rb",
    "spec/helpers_spec.rb",
    "spec/manifest_spec.rb",
    "spec/ninjs_spec.rb",
    "spec/notification_spec.rb",
    "spec/project_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/textnotspeech/ninjs}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{nowarning}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{ninjs is a command line application to help you write clean, modular javascript applications.}
  s.test_files = [
    "spec/cli_spec.rb",
    "spec/command_spec.rb",
    "spec/configuration_spec.rb",
    "spec/dependencies_spec.rb",
    "spec/generator_spec.rb",
    "spec/helpers_spec.rb",
    "spec/manifest_spec.rb",
    "spec/ninjs_spec.rb",
    "spec/notification_spec.rb",
    "spec/project_spec.rb",
    "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<fssm>, [">= 0"])
      s.add_runtime_dependency(%q<jsmin>, [">= 0"])
      s.add_runtime_dependency(%q<sprockets>, ["= 1.0.2"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_runtime_dependency(%q<rubikon>, [">= 0"])
      s.add_runtime_dependency(%q<fssm>, [">= 0"])
      s.add_runtime_dependency(%q<jsmin>, [">= 0"])
      s.add_runtime_dependency(%q<sprockets>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<fssm>, [">= 0"])
      s.add_dependency(%q<jsmin>, [">= 0"])
      s.add_dependency(%q<sprockets>, ["= 1.0.2"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<rubikon>, [">= 0"])
      s.add_dependency(%q<fssm>, [">= 0"])
      s.add_dependency(%q<jsmin>, [">= 0"])
      s.add_dependency(%q<sprockets>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<fssm>, [">= 0"])
    s.add_dependency(%q<jsmin>, [">= 0"])
    s.add_dependency(%q<sprockets>, ["= 1.0.2"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<rubikon>, [">= 0"])
    s.add_dependency(%q<fssm>, [">= 0"])
    s.add_dependency(%q<jsmin>, [">= 0"])
    s.add_dependency(%q<sprockets>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end

