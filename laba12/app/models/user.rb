class User < ApplicationRecord
  def self.authenticate(login, submitted_password)#в лекции
    user = find_by_login(login)
    return nil if user.nil?

    return user if user.password == submitted_password #ищу пользователя по логину и сверяю введенный пароль с БД
  end
end
