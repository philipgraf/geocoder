# encoding: utf-8
$: << File.join(File.dirname(__FILE__), "..", "..")
require 'test_helper'

class NominatimTest < GeocoderTestCase

  def setup
    Geocoder.configure(lookup: :nominatim)
    set_api_key!(:nominatim)
  end

  def test_result_components
    result = Geocoder.search("Madison Square Garden, New York, NY").first
    assert_equal "10001", result.postal_code
    assert_equal "Madison Square Garden, West 31st Street, Long Island City, New York City, New York, 10001, United States of America", result.address
  end

  def test_host_configuration
    Geocoder.configure(nominatim: {host: "local.com"})
    query = Geocoder::Query.new("Bluffton, SC")
    assert_match %r(http://local\.com), query.url
  end
end
