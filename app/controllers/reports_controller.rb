class ReportsController < ApplicationController
  before_action :set_current_user
  before_action :set_report, only: [:show, :edit, :update, :destroy]

  # GET /reports
  def index
    @notifications = current_user.notifications.sent
  end
end
