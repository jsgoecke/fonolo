require 'rubygems'
require 'lib/fonolo'
require 'test/unit'
 
class Fonolo_Test < Test::Unit::TestCase
  
  def setup
    #Initialize the Fonolo object
    @fonolo = Fonolo.new("uname", "passwd", "apikey")
    @check_member_result = {"result"=>{"head"=>{"response_message"=>"check successful", "response_code"=>200}, "data"=>nil}, "version"=>"1.1"}
  end
  
  def teardown
  end
  
  #Test that the check member method works properly
  def test_check_member
    assert_equal(@check_member_result, @fonolo.check_member)
  end
  
end