class SorceryCore < ActiveRecord::Migration[7.0]
  def change
    # 既存のusersテーブルにカラムを追加
    add_column :users, :crypted_password, :string
    add_column :users, :salt, :string
  end
end
