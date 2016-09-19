dir = File.dirname(File.expand_path(__FILE__))
$LOAD_PATH.unshift("#{dir}/../lib")

require "minitest/autorun"
require "mocha/test_unit"
require "shoulda-context"
require "unimidi"

module TestHelper

end
