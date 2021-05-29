require 'rails_helper'

describe CustomersController, type: :controller do
  describe '#index' do
    context 'for any request' do
      it 'should respond successfully' do
        get :index
        expect(response.status).to eq 200
      end
    end

    it 'assigns @customers' do
        # check the index request return the correct customer list or not
        tmp_customers_list = Bigcommerce::Customer.all
        orders = Bigcommerce::Order.all
        customers_list = []
        for customer in tmp_customers_list
            tmp_num_of_order = 0
            for order in orders
                if order.customer_id == customer.id
                tmp_num_of_order += 1
                end
            end
            customers_list.append({name: customer.first_name + ' ' + customer.last_name, 
                num_of_order: tmp_num_of_order, customer_id: customer.id
              })
        end
        get :index
        expect(assigns(:customers)).to eq(customers_list)
    end

    it "should get a exact customer with correct value" do
        # get customer id 10
        customer = Bigcommerce::Customer.find(10)
        orders = Bigcommerce::Order.all
        order_list = []
        # get the orders of customer id 10
        for order in orders
            if order.customer_id == customer.id
                order_list.append(order)
            end
        end
        # run the show request and check the values
        get :show, params: { id: customer.id }
        expect(response.status).to eq(200)
        expect(assigns(:lifetime_value)).to eq(220.75)
        expect(assigns(:customer)).to eq(customer)
        expect(assigns(:orders)).to eq(order_list)
      end
  end


end
