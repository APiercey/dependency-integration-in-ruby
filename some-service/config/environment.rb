# frozen_string_literal: true

require './config/app_constants'
require './config/app_tree'

Dir[File.join('.', 'app', '**/*.rb')].sort.each { |f| require f }
