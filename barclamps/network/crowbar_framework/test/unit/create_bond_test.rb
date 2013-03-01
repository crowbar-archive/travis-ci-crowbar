# Copyright 2012, Dell 
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
 
class CreateBondTest < ActiveSupport::TestCase

  # Test successful creation
  test "CreateBond creation: success" do
    CreateBond.create!( :name => "fred", :team_mode => 6 )
  end


  # Test creation failure due to missing team_mode
  test "CreateBond creation: failure due to missing team_mode" do
    assert_raise ActiveRecord::RecordInvalid do
      CreateBond.create!( :name => "fred" )
    end
  end


  # Test creation failure due to low team_mode
  test "CreateBond creation: failure due to low team_mode" do
    assert_raise ActiveRecord::RecordInvalid do
      CreateBond.create!( :name => "fred", :team_mode => -1 )
    end
  end


  # Test creation failure due to high team_mode
  test "CreateBond creation: failure due to high team_mode" do
    assert_raise ActiveRecord::RecordInvalid do
      CreateBond.create!( :name => "fred", :team_mode => 7 )
    end
  end
end
