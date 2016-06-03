require 'rails_helper'

RSpec.feature "CreateEvents", type: :feature do
  describe 'ユーザがイベントを新規登録する' do
    before do
      visit new_event_path
    end

    context 'イベントの登録に成功したとき' do
      before do # まだ実装途中、ビュー作らないと定義できない
        fill_in 'name', with: 'testname'
        fill_in 'place', with: 'testeplace'
        fill_in 'content', with: 'testcontent'
        select '', from: 'start_time' # この辺の実装がどうなるのか
        select '', from: 'end_time'
        click_link '作成'
      end

      it 'イベント詳細ページに遷移すること' do
        expect(page.current_path).to eq event_path(assigns[:event])
      end
    end

    context 'イベントの登録に失敗したとき' do
      before do # こっちは何もfill_inしないでよさそう
        click_link '作成'
      end

      it 'エラーメッセージが表示されること' do
        expect(page).to have_content '名前を入力してください' # 違う書き方がありそう
      end
    end
  end
end
