class Condition < ActiveRecord::Base
  self.primary_key = "date"

  validates_presence_of :date,
                        :mean_temperature_f,
                        :max_temperature_f,
                        :min_temperature_f,
                        :mean_humidity,
                        :mean_visibility_miles,
                        :mean_wind_speed_mph,
                        :precipitation_inches

  validates :date, uniqueness: true

  has_many  :trips, :foreign_key => :start_date

  def self.days_within_high_temp(range)
    where(max_temperature_f: [range..range+9])
  end

  def self.days_within_precipitation(range)
    where(precipitation_inches: [range..range+0.49])
  end

  def self.days_within_wind(range)
    where(mean_wind_speed_mph: [range..range+4])
  end

  def self.days_within_visibility(range)
    where(mean_visibility_miles: [range..range+4])
  end

  def self.rides_per_day
    joins(:trips).group(:start_date).order("count_start_date desc").count(:start_date)
  end

  def self.min_rides_temp(range)
    days_within_high_temp(range).rides_per_day.reverse.first[1]
  end

  def self.average_rides_temp
  end

  def self.max_rides_temp
  end

  def self.min_rides_precip
  end

  def self.average_rides_precip
  end

  def self.max_rides_precip
  end

  def self.min_rides_wind
  end

  def self.average_rides_wind
  end

  def self.max_rides_wind
  end

  def self.min_rides_visibility
  end

  def self.average_rides_visibility
  end

  def self.max_rides_visibility
  end

  def self.all_rides_within_wind_speed
  end

  def self.all_rides_within_visibility_range
  end

  def self.all_rides_within_temp_range
  end

  def self.weather_on_day_with_highest_rides
  end

end
