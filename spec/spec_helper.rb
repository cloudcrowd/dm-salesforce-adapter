Bundler.require(:default, :test)

require 'fileutils'
root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
require File.join(root, 'lib', 'dm-salesforce-adapter')
require File.join(root, 'spec', 'fixtures', 'account')
require File.join(root, 'spec', 'fixtures', 'contact')

sf_dir = ENV["SALESFORCE_DIR"] = File.join(root, 'tmp', 'dot_salesforce')

FileUtils.rm_r(sf_dir) if File.directory?(sf_dir)
FileUtils.mkdir_p(sf_dir)

log_file = File.open(File.join(root, 'tmp', 'test.log'), 'w')
log_file.sync = true
DATABASE_CONFIG = YAML.load_file(File.join(root, 'config', 'database.yml'))
SALESFORCE_CONFIG = DATABASE_CONFIG['development']['repositories']['salesforce']

DataMapper::Logger.new(log_file, 0)
DataMapper.setup(:default, 'sqlite::memory:')
DataMapper.setup(:salesforce, SALESFORCE_CONFIG)
