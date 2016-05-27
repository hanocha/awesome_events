require 'rails_helper'

RSpec.describe Event, type: :model do
  describe '#name' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(50) }
  end

  describe '#place' do
    it { should validate_presence_of(:place) }
    it { should validate_length_of(:place).is_at_most(100) }
  end

  describe '#start_time' do
    it { should validate_presence_of(:start_time) }

    context 'end_timeより後のとき' do
      it 'valid でないこと' do
        event = Event.new(
          name: 'test_name',
          place: 'test_place',
          content: 'test_content',
          start_time: Date.today + 1.days,
          end_time: Date.today
        )
        event.valid?
        expect(event.errors[:start_time]).to be_present
      end
    end
  end

  describe '#end_time' do
    it { should validate_presence_of(:end_time) }
  end

  describe '#content' do
    it { should validate_presence_of(:content) }
    it { should validate_length_of(:content).is_at_most(2000) }
  end
end
