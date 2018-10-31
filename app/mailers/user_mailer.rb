class UserMailer < ApplicationMailer
  default from: 'hellenpukkacodes@gmail.com'
 
  def order_details
    user = params[:user]
    @user = user.user
    @url  = 'http://localhost:3000'
    mail(to: @user.email, subject: 'Order details')
  end
  def delivery_request
    user = params[:user]
    @user = user.user
    @url  = 'http://localhost:3000'
    mail(to: @user.email, subject: 'Delivery request')
  end
end
