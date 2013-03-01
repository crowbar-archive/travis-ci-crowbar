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

class BarclampNetwork::Interface < ActiveRecord::Base
  attr_protected :id
  
  has_many :allocated_ip_addresses, :inverse_of => :interface, :dependent => :destroy, :class_name => "BarclampNetwork::AllocatedIpAddress"
  belongs_to :vlan_interface, :inverse_of => :interfaces, :class_name => "BarclampNetwork::VlanInterface"
  belongs_to :node
  has_and_belongs_to_many :networks, :join_table => "#{BarclampNetwork::TABLE_PREFIX}interfaces_networks", :class_name => "BarclampNetwork::Network"
  
  # attr_accessible :name

  validates :name, :presence => true
end
