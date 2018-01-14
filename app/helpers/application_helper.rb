module ApplicationHelper
  def current_order
      if !session[:order_id].nil?
        Order.find(session[:order_id])
      else
        #Order.new
        if team_signed_in?
          current_team.orders.build
        end
      end
  end
end
