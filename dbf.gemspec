# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{dbf}
  s.version = "1.2.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Keith Morrison"]
  s.date = %q{2010-07-15}
  s.default_executable = %q{dbf}
  s.description = %q{A small fast library for reading dBase, xBase, Clipper and FoxPro database files.}
  s.email = %q{keithm@infused.org}
  s.executables = ["dbf"]
  s.extra_rdoc_files = [
    "README.markdown"
  ]
  s.files = [
    ".autotest",
     ".gitignore",
     "History.txt",
     "MIT-LICENSE",
     "README.markdown",
     "Rakefile",
     "VERSION.yml",
     "bin/dbf",
     "dbf.gemspec",
     "docs/supported_types.markdown",
     "lib/dbf.rb",
     "lib/dbf/column.rb",
     "lib/dbf/globals.rb",
     "lib/dbf/record.rb",
     "lib/dbf/table.rb",
     "spec/fixtures/dbase_03.dbf",
     "spec/fixtures/dbase_30.dbf",
     "spec/fixtures/dbase_30.fpt",
     "spec/fixtures/dbase_31.dbf",
     "spec/fixtures/dbase_83.dbf",
     "spec/fixtures/dbase_83.dbt",
     "spec/fixtures/dbase_83_schema.txt",
     "spec/fixtures/dbase_8b.dbf",
     "spec/fixtures/dbase_8b.dbt",
     "spec/fixtures/dbase_f5.dbf",
     "spec/fixtures/dbase_f5.fpt",
     "spec/functional/dbf_shared.rb",
     "spec/functional/format_03_spec.rb",
     "spec/functional/format_30_spec.rb",
     "spec/functional/format_31_spec.rb",
     "spec/functional/format_83_spec.rb",
     "spec/functional/format_8b_spec.rb",
     "spec/functional/format_f5_spec.rb",
     "spec/spec_helper.rb",
     "spec/unit/column_spec.rb",
     "spec/unit/record_spec.rb",
     "spec/unit/table_spec.rb"
  ]
  s.homepage = %q{http://github.com/infused/dbf}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Read xBase files}
  s.test_files = [
    "spec/functional/dbf_shared.rb",
     "spec/functional/format_03_spec.rb",
     "spec/functional/format_30_spec.rb",
     "spec/functional/format_31_spec.rb",
     "spec/functional/format_83_spec.rb",
     "spec/functional/format_8b_spec.rb",
     "spec/functional/format_f5_spec.rb",
     "spec/spec_helper.rb",
     "spec/unit/column_spec.rb",
     "spec/unit/record_spec.rb",
     "spec/unit/table_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 2.3.5"])
      s.add_runtime_dependency(%q<fastercsv>, [">= 1.4.0"])
    else
      s.add_dependency(%q<activesupport>, [">= 2.3.5"])
      s.add_dependency(%q<fastercsv>, [">= 1.4.0"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 2.3.5"])
    s.add_dependency(%q<fastercsv>, [">= 1.4.0"])
  end
end

