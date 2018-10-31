module OrdersHelper
  def payment_list
  	payments = Payment.all
  	payments.map{|p|[p.payment_method, p.id]}
  end
end
