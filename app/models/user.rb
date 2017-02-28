class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :rankings

  def ranking_info
  	Girl.all.map{|x| { id: x.id, name: x.name, rank: x.rank(self) } }.sort_by{|x| x[:rank] == 0 ? 99999 : x[:rank] }
  end
end
