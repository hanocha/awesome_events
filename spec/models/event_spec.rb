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
    let(:end_time) { Date.today }

    describe '正常系' do
      let(:event) { create(:event) }

      context 'end_timeより前のとき' do
        it 'valid であること' do
          event.valid?
          expect(event.errors[:start_time]).not_to be_present
        end
      end
    end

    describe '異常系' do
      context 'end_timeより後のとき' do
        it 'valid でないこと' do
          event = Event.new(
            start_time: end_time + 1.days,
            end_time: end_time
          )
          event.valid?
          expect(event.errors[:start_time]).to be_present
        end
      end

      context 'end_timeと同じとき' do
        it 'valid でないこと' do
          event = Event.new(
            start_time: end_time,
            end_time: end_time
          )
          event.valid?
          expect(event.errors[:start_time]).to be_present
        end
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
