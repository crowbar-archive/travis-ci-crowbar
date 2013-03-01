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

class Selector < ActiveRecord::Base
  attr_accessible :value

  belongs_to :interface_selector, :inverse_of => :selectors

  validates :value, :presence => true


  CONDUIT_REGEX = /^([-+?]?)(\d{1,3}[mg])(\d+)$/ # [1]=sign, [2]=speed, [3]=if_index
  
  def select(if_remap)
    raise "Subclasses must implement select"
  end
end
