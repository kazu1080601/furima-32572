class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, :first_name_kanji, :last_name_kanji, :first_name_kana, :last_name_kana, :birthday, presence: true

  validate :password_complexity
  validate :first_name_kanji_check
  validate :last_name_kanji_check
  validate :first_name_kana_check
  validate :last_name_kana_check

  has_many :items

  def password_complexity
    # Regexp extracted from https://stackoverflow.com/questions/19605150/regex-for-password-must-contain-at-least-eight-characters-at-least-one-number-a
    return if password.blank? || password =~ /\A(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}\z/

    errors.add :password,
               'Complexity requirement not met. Length should be 6 characters minimum and include at least one letter and one number.(Excluding full-width)'
  end

  def first_name_kanji_check
    return if first_name_kanji.blank? || first_name_kanji =~ /\A[ぁ-んァ-ヶ一-龥々]+\z/

    errors.add :base, 'お名前（全角）の名前には、全角文字を記入してください'
  end

  def last_name_kanji_check
    return if last_name_kanji.blank? || last_name_kanji =~ /\A[ぁ-んァ-ヶ一-龥々]+\z/

    errors.add :base, 'お名前（全角）の名字には、全角文字を記入してください'
  end

  def first_name_kana_check
    return if first_name_kana.blank? || first_name_kana =~ /\A[ァ-ヶ]+\z/

    errors.add :base, 'お名前（カナ）の名前には、全角カナを記入してください'
  end

  def last_name_kana_check
    return if last_name_kana.blank? || last_name_kana =~ /\A[ァ-ヶ]+\z/

    errors.add :base, 'お名前（カナ）の名字には、全角カナを記入してください'
  end
end
