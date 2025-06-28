# frozen_string_literal: true

require 'spec_helper'

describe 'chattr' do
  context 'with absolute path' do
    let(:title) { '/foo' }

    it {
      is_expected.to be_valid_type.with_provider(:linux)

      is_expected.to be_valid_type.with_properties('immutable')
      is_expected.to be_valid_type.with_properties('append_only')
    }
  end
end
