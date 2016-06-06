require 'rails_helper'

RSpec.feature "CreateEvents", type: :feature do
  describe 'ユーザがイベントを新規登録する' do
    before do
      visit root_path
      click_link 'Twitterでログイン'
      visit new_event_path
    end

    describe '正常系' do
      context 'イベントの登録に成功したとき' do
        before do
          fill_in 'event_name', with: 'testname'
          fill_in 'event_place', with: 'testplace'
          fill_in 'event_content', with: 'testcontent'
          select '2016', from: 'event_start_time_1i'
          select '2017', from: 'event_end_time_1i'
          click_button '作成'
        end

        it '登録したイベントの詳細ページに遷移すること' do
          expect(page).to have_content 'testname'
          expect(page).to have_content 'testplace'
          expect(page).to have_content 'testcontent'
        end
      end
    end

    describe '異常系' do
      context 'イベントの登録に失敗したとき' do
        before do
          click_button '作成'
        end

        it 'エラーメッセージが表示されること' do
          expect(page).to have_content "Name can't be blank"
          expect(page).to have_content "Place can't be blank"
          expect(page).to have_content "Content can't be blank"
          expect(page).to have_content "Start time は終了時間よりも前に設定してください"
        end
      end
    end
  end
end
