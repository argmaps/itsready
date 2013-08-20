class ReportsController < ApplicationController
  before_action :set_current_user
  before_action :set_report, only: [:show, :edit, :update, :destroy]

  # GET /reports
  def index
    @data = Array.new.tap do |r|
      current_user.customers.each do |customer|
        dates_to_counts = customer.notifications.sent.group("date(sent_at)").count
        dates_to_counts.each do |date,count|
          r << {
            date: date.to_datetime,
            name: customer.full_name,
            daily_total: count,
            country_code: customer.country_code,
            phone: customer.phone
          }
        end
      end
    end

    @data.sort_by! {|h| h[:date]}.reverse!
  end
end
