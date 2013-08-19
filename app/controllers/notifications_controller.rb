class NotificationsController < ApplicationController
  before_action :set_current_user
  before_action :set_notification, only: [:show, :edit, :update, :destroy]

  # GET /notifications
  def index
    @notifications = current_user.notifications.pending
    render 'empty_index' if @notifications.empty?
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
    @notification = Notification.new(notification_params)

    if @notification.save
      redirect_to user_notifications_path, notice: 'Notification was successfully created.'
    else
      render action: 'new'
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
      params.require(:notification).permit(:customer_id, :message, :ready, :sent)
    end
end
