class BusinessLogicController < ApplicationController
  include Math

  before_action :parse_params, only: :output
  before_action :require_login

  def input; end

  def output
    if !@input_is_ok
      @result = 'ОШИБКА: недопустимый ввод'
    else
      begin
        nach = 10**(@max-1)
        konech = 10**(@max) - 1
        kolv=0
        s=0
        sum=0
        arr_b= Array.new
        while (nach <= konech) do #идем по диапозону числе от начального к конечному
            i = nach
            p i
          while i > 0 do #тут с помощью цикла будем выяснять удволтеворяет ли число условию
            s = (i % 10).to_i 
            sum = sum + s**(@max)
            p sum
            i = i.div 10
            p i
          end
          if (sum==nach)
            arr_b << nach  #добавление числа в массив
            kolv=kolv+1 
          end
          nach=nach+1
          sum = 0
        end
        if arr_b.empty?
            @ans = "В данном диапозоне чисел армстронга нет"
            @ans2 = 0
        else
        
        @ans = arr_b.to_s.delete "[]"
        @ans2= kolv
        end
        return @ans, @ans2
        end
  end
end

  protected

  def parse_params
    @input_is_ok = true
    begin
      # If params[:max]=nil then Integer(nil) throws the exception too
      @max = Integer(params[:max])
      @input_is_ok = false if @max.negative?
    rescue TypeError, ArgumentError
      @input_is_ok = false
    end
  end

  def require_login
    unless User.find_by_id (session[:current_user_id])
      flash[:danger] = "You have to be authorized"
      redirect_to auth_path
    end
  end

end
