class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, #:registerable 管理者のアカウント登録禁止
         :recoverable, :rememberable, :validatable
end
