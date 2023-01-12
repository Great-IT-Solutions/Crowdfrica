# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Beneficiary do
  it { is_expected.to define_enum_for(:btype).with_values(%i[patient health_facility classroom_supplies entrepreneur]) }
end
