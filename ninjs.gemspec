# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "ninjs"
  s.version = "0.16.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dayton Nolan"]
  s.date = "2012-02-15"
  s.description = "Ninjs is a ruby application and small javascript framework that helps you build clean, modular javascript applications. Ninjs encourages \"Good Parts\" best practices and the Crockford school Module pattern (http://www.crockford.com/). The ninjs command line application is an automatic compiler, written in ruby, and based on the Sprockets library (http://getsprockets.org/)."
  s.email = "daytonn@gmail.com"
  s.executables = ["ninjs"]
  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  s.files = [
    ".bundle/config",
    ".gitmodules",
    ".travis.yml",
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
    "lib/sprockets/CHANGELOG",
    "lib/sprockets/LICENSE",
    "lib/sprockets/README.markdown",
    "lib/sprockets/ext/nph-sprockets.cgi",
    "lib/sprockets/lib/sprockets.rb",
    "lib/sprockets/lib/sprockets/concatenation.rb",
    "lib/sprockets/lib/sprockets/environment.rb",
    "lib/sprockets/lib/sprockets/error.rb",
    "lib/sprockets/lib/sprockets/pathname.rb",
    "lib/sprockets/lib/sprockets/preprocessor.rb",
    "lib/sprockets/lib/sprockets/secretary.rb",
    "lib/sprockets/lib/sprockets/source_file.rb",
    "lib/sprockets/lib/sprockets/source_line.rb",
    "lib/sprockets/lib/sprockets/version.rb",
    "lib/sprockets/sprockets.gemspec",
    "lib/sprockets/test/fixtures/assets/images/script_with_assets/one.png",
    "lib/sprockets/test/fixtures/assets/images/script_with_assets/two.png",
    "lib/sprockets/test/fixtures/assets/stylesheets/script_with_assets.css",
    "lib/sprockets/test/fixtures/constants.yml",
    "lib/sprockets/test/fixtures/double_slash_comments_that_are_not_requires_should_be_ignored_when_strip_comments_is_false.js",
    "lib/sprockets/test/fixtures/double_slash_comments_that_are_not_requires_should_be_removed_by_default.js",
    "lib/sprockets/test/fixtures/multiline_comments_should_be_removed_by_default.js",
    "lib/sprockets/test/fixtures/requiring_a_file_after_it_has_already_been_required_should_do_nothing.js",
    "lib/sprockets/test/fixtures/requiring_a_file_that_does_not_exist_should_raise_an_error.js",
    "lib/sprockets/test/fixtures/requiring_a_single_file_should_replace_the_require_comment_with_the_file_contents.js",
    "lib/sprockets/test/fixtures/requiring_the_current_file_should_do_nothing.js",
    "lib/sprockets/test/fixtures/src/constants.yml",
    "lib/sprockets/test/fixtures/src/foo.js",
    "lib/sprockets/test/fixtures/src/foo/bar.js",
    "lib/sprockets/test/fixtures/src/foo/foo.js",
    "lib/sprockets/test/fixtures/src/script_with_assets.js",
    "lib/sprockets/test/fixtures/src/script_with_comments.js",
    "lib/sprockets/test/test_concatenation.rb",
    "lib/sprockets/test/test_environment.rb",
    "lib/sprockets/test/test_helper.rb",
    "lib/sprockets/test/test_pathname.rb",
    "lib/sprockets/test/test_preprocessor.rb",
    "lib/sprockets/test/test_secretary.rb",
    "lib/sprockets/test/test_source_file.rb",
    "lib/sprockets/test/test_source_line.rb",
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
    "repository/ninjs/.travis.yml",
    "repository/ninjs/Gemfile",
    "repository/ninjs/README.md",
    "repository/ninjs/Rakefile",
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
    "repository/ninjs/extensions/jquery.elements.js",
    "repository/ninjs/spec/index.html",
    "repository/ninjs/spec/javascripts/application_spec.js",
    "repository/ninjs/spec/javascripts/array_utility_spec.js",
    "repository/ninjs/spec/javascripts/existence_spec.js",
    "repository/ninjs/spec/javascripts/extension_spec.js",
    "repository/ninjs/spec/javascripts/module_spec.js",
    "repository/ninjs/spec/javascripts/string_utility_spec.js",
    "repository/ninjs/spec/javascripts/support/jasmine.yml",
    "repository/ninjs/spec/javascripts/support/jasmine_config.rb",
    "repository/ninjs/spec/javascripts/support/jasmine_runner.rb",
    "repository/ninjs/utilities/all.js",
    "repository/ninjs/utilities/array.js",
    "repository/ninjs/utilities/cookie.js",
    "repository/ninjs/utilities/css.js",
    "repository/ninjs/utilities/number.js",
    "repository/ninjs/utilities/string.js",
    "spec/cli_spec.rb",
    "spec/command_spec.rb",
    "spec/configuration_spec.rb",
    "spec/dependencies_spec.rb",
    "spec/fixtures/_global.module.js",
    "spec/fixtures/autoload.js",
    "spec/fixtures/badpattern.module.js",
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
    "spec/fixtures/mymodule.module_alias.module.js",
    "spec/fixtures/new.ninjs.conf",
    "spec/fixtures/nin.js",
    "spec/fixtures/ninjs.conf",
    "spec/fixtures/updated.ninjs.conf",
    "spec/generator_spec.rb",
    "spec/helpers_spec.rb",
    "spec/manifest_spec.rb",
    "spec/ninjs_spec.rb",
    "spec/notification_spec.rb",
    "spec/project_spec.rb",
    "spec/spec_helper.rb",
    "templates/jasmine.yml",
    "templates/test-index.html"
  ]
  s.homepage = "http://github.com/daytonn/ninjs"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "nowarning"
  s.rubygems_version = "1.8.15"
  s.summary = "ninjs is a command line application to help you write clean, modular javascript applications."
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
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<fssm>, [">= 0"])
      s.add_runtime_dependency(%q<jsmin>, [">= 0"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<rdoc>, [">= 0"])
      s.add_runtime_dependency(%q<fssm>, [">= 0"])
      s.add_runtime_dependency(%q<jsmin>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<fssm>, [">= 0"])
      s.add_dependency(%q<jsmin>, [">= 0"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<rdoc>, [">= 0"])
      s.add_dependency(%q<fssm>, [">= 0"])
      s.add_dependency(%q<jsmin>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<fssm>, [">= 0"])
    s.add_dependency(%q<jsmin>, [">= 0"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<rdoc>, [">= 0"])
    s.add_dependency(%q<fssm>, [">= 0"])
    s.add_dependency(%q<jsmin>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end

