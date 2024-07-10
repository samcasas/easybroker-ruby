require 'minitest/autorun'
require_relative 'easybroker'
require 'json'

class TestEasybroker < Minitest::Test
    def setup
        @easybroker = Easybroker.new()
    end

    def test_properties_titles
        #Testeo del formato de salida
        expected_output = "Propiedad 1\n"
        assert_output(expected_output) { @easybroker.properties_titles }
    end
end
