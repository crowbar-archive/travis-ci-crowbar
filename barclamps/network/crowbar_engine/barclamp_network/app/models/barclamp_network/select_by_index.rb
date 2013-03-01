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

class BarclampNetwork::SelectByIndex < BarclampNetwork::Selector
  def select(if_remap)
    value = (self.value.instance_of? Integer) ? self.value : self.value.to_i
    new_if_remap = {}
    if_remap.keys.each do |conduit_name|
      m = CONDUIT_REGEX.match(conduit_name)
      index = m[3].to_i
      new_if_remap[conduit_name] = if_remap[conduit_name] if index == value
    end

    new_if_remap
  end
end
