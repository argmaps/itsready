class ReportsController < ApplicationController
  before_action :set_current_user
  before_action :set_report, only: [:show, :edit, :update, :destroy]

  # GET /reports
  def index
    @data = Array.new.tap do |r|
      current_user.customers.each do |customer|
        r << customer.notifications.sent.group_by {|n| n.sent_at.to_date}.map do |k,v|
          {
            date: k,
            name: customer.full_name,
            count: v.length,
            country_code: customer.country_code,
            phone: customer.phone
          }
        end
      end
    end.flatten!
  end
end
