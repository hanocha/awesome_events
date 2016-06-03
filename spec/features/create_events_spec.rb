require 'rails_helper'

RSpec.feature "CreateEvents", type: :feature do
  describe 'ユーザがイベントを新規登録する' do
    before do
      visit root_path
      click_link 'Twitterでログイン'
      visit new_event_path
    end

    context 'イベントの登録に成功したとき' do
      before do
        fill_in 'event_name', with: 'testname'
        fill_in 'event_place', with: 'testeplace'
        fill_in 'event_content', with: 'testcontent'
        select '2016', from: 'event_start_time_1i'
        select '2017', from: 'event_end_time_1i'
        click_button '作成'
      end

      it 'イベント詳細ページに遷移すること' do
        expect(page.current_path).to eq event_path(assigns[:event])
      end
    end

    context 'イベントの登録に失敗したとき' do
      before do # こっちは何もfill_inしないでよさそう
        click_button '作成'
      end

      it 'エラーメッセージが表示されること' do
        expect(page).to have_content '名前を入力してください' # 違う書き方がありそう
      end
    end
  end
end
