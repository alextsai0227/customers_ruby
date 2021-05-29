class CustomersController < ApplicationController
  def index
    
    if !params[:page]
      page = 1
    else
      page = params[:page].to_i
    end
    # init the customers array
    customers = []
    @customers = []
    @pages = []
    # Get the total numbers of customer
    total_customers = Bigcommerce::Customer.count.count

    #  create input

    # the number of customer per page
    num_cus_per_page = Bigcommerce::Customer.all(page: 1).length

    customers = Bigcommerce::Customer.all(page: page)
    (total_customers / num_cus_per_page + 1).times do |i|
      @pages.append((i+1).to_s)
    end

    # (total_customers / num_cus_per_page + 1).times do |i|
    #   customers += Bigcommerce::Customer.all(page: i+1)
    # end
    # get all the orders
    orders = Bigcommerce::Order.all



    # calculate the number of order for each customer
    for customer in customers
      tmp_num_of_order = 0
      for order in orders
        if order.customer_id == customer.id
          tmp_num_of_order += 1
        end
      end
      @customers.append({name: customer.first_name + ' ' + customer.last_name, 
        num_of_order: tmp_num_of_order, customer_id: customer.id
      })
    end

  end

  def show
    orders = Bigcommerce::Order.all
    @customer = Bigcommerce::Customer.find(params[:id])
    @orders = []
    @lifetime_value = 0
    for order in orders
      if order.customer_id == @customer.id
        @orders.append(order)
        @lifetime_value += order.total_inc_tax.to_f
      end
    end
    @lifetime_value = @lifetime_value.round(2)
  end
end

