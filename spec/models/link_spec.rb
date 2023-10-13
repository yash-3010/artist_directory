# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Link, type: :model do
  it 'belongs to an artist' do
    link = FactoryBot.create(:link)
    expect(link.artist).to be_a(Artist)
  end
end
