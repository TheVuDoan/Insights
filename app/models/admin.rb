class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  belongs_to :role

  def sysop?
    role.slug == 'sysop'
  end

  def analyst?
    role.slug == 'analyst'
  end

  def editor?
    role.slug == 'editor'
  end
end
