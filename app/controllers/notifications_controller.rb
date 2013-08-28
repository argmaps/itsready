class NotificationsController < ApplicationController
  before_action :set_current_user
  before_action :set_notification, only: [:show, :edit, :update, :destroy]

  # GET /notifications
  def index
    @notifications = current_user.notifications.pending
    @new_notification = current_user.notifications.new
    @new_notification.build_customer
  end

  # GET /notifications/new
  def new
    @notification = Notification.new
  end

  # GET /notifications/1/edit
  def edit
  end

  # POST /notifications
  def create
    if notification_params[:customer_id]
      adapted_params = notification_params.except(:customer_attributes)
    else
      adapted_params = notification_params.except(:customer_id)
    end
    @notification = Notification.new(adapted_params)

    respond_to do |format|
      if @notification.save
        format.js do
          if @notification.ready && @notification.sent_at.blank?
            begin
              NotifiesCustomer.new(@notification).run
            rescue => error
              logger.error("Error: #{error}")
              raise ActiveRecord::Rollback, "#{error.message}"
            end
            flash[:success] = "Notified #{@notification.customer.full_name}."
            render 'created_and_sent_notification'
          else
            render 'add_notification'
          end
        end
        format.html { redirect_to user_notifications_path, notice: 'Notification was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /notifications/1
  def update
    succeeded = Notification.transaction do
      if @notification.update(notification_params)
        if @notification.ready && @notification.sent_at.blank?
          begin
            NotifiesCustomer.new(@notification).run
          rescue => error
            logger.error("Error: #{error}")
            raise ActiveRecord::Rollback, "#{error.message}"
          end
        end
      else
        false
      end
    end

    if succeeded
      redirect_to user_notifications_path, notice: "Notified #{@notification.customer.full_name}."
    else
      if notification_params[:ready]
        copy = "Sorry, we weren't able to notify this customer. Our team has been alerted to this issue. Please try again later."
        flash[:error] = copy
        redirect_to user_notifications_path
      else
        render action: 'edit'
      end
    end
  end

  # DELETE /notifications/1
  def destroy
    @notification.destroy
    redirect_to user_notifications_path, notice: 'Notification was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notification
      @notification = Notification.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def notification_params
      params.require(:notification).permit(:customer_id, :message, :ready, :sent,
                                           customer_attributes: [:first_name, :last_name, :phone])
    end
end
