# Copyright 2013, Dell 
# 
# Licensed under the Apache License, Version 2.0 (the "License"); 
# you may not use this file except in compliance with the License. 
# You may obtain a copy of the License at 
# 
#  http://www.apache.org/licenses/LICENSE-2.0 
# 
# Unless required by applicable law or agreed to in writing, software 
# distributed under the License is distributed on an "AS IS" BASIS, 
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
# See the License for the specific language governing permissions and 
# limitations under the License. 

require 'test_helper'
require 'network_test_helper'
 
class InterfaceMapModelTest < ActiveSupport::TestCase
  # Test successful creation
  test "InterfaceMap creation: success" do
    barclamp = NetworkTestHelper.create_a_barclamp()
    deployment = barclamp.create_or_get_deployment()

    interface_map = NetworkTestHelper.create_an_interface_map(deployment)
    interface_map.save!
  end


  # Test creation failure due to missing BusMap
  test "IntefaceMap creation: failure due to missing BusMap" do
    assert_raise ActiveRecord::RecordInvalid do
      BarclampNetwork::InterfaceMap.create!()
    end
  end


  # Test deletion cascade to BusMaps
  test "IntefaceMap deletion: cascade" do
    barclamp = NetworkTestHelper.create_a_barclamp()
    deployment = barclamp.create_or_get_deployment()

    interface_map = NetworkTestHelper.create_an_interface_map(deployment)
    interface_map.save!
    bus_map_id = interface_map.bus_maps[0]
    interface_map.destroy

    assert_raise ActiveRecord::RecordNotFound do
      BarclampNetwork::BusMap.find(bus_map_id)
    end
  end


  # Test retrieval of a bus order
  test "InterfaceMap: retrieval of bus order success" do
    barclamp = NetworkTestHelper.create_a_barclamp()
    deployment = barclamp.create_or_get_deployment()

    interface_map = NetworkTestHelper.create_an_interface_map(deployment)
    interface_map.save!

    node = Node.new(:name => "fred.flintstone.org")
    node.save!

    node.set_attrib("product_name", "PowerEdge R710")

    buses = BarclampNetwork::InterfaceMap.get_bus_order(node)
    assert_not_nil buses

    assert_equal "0000:00/0000:00:01", buses[0].path
    assert_equal "0000:00/0000:00:03", buses[1].path
  end


  # Test failure to retrieve bus order
  test "InterfaceMap: retrieval of bus order failure" do
    barclamp = NetworkTestHelper.create_a_barclamp()
    deployment = barclamp.create_or_get_deployment()

    interface_map = NetworkTestHelper.create_an_interface_map(deployment)
    interface_map.save!

    node = Node.new(:name => "fred.flintstone.org")
    node.save!

    node.set_attrib("product_name", "Magical Mystery Box")

    buses = BarclampNetwork::InterfaceMap.get_bus_order(node)
    assert_nil buses
  end
end
