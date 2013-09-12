class CustomersController < ApplicationController
  before_action :set_current_user
  before_action :set_customer, only: [:edit, :update, :destroy]

  # GET /customers
  def index
    @customers = current_user.customers
    redirect_to new_user_customer_path if @customers.empty?
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      redirect_to user_customers_path(current_user), notice: 'Customer was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /customers/1
  def update
    if @customer.update(customer_params)
      redirect_to user_customers_path, notice: 'Customer was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /customers/1
  def destroy
    Customer.transaction do
      @customer.notifications.pending.each(&:destroy)
      @customer.destroy
    end
    redirect_to user_customers_path, notice: 'Customer was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def customer_params
      params.require(:customer).permit(:user_id, :first_name, :last_name, :phone)
    end
end
