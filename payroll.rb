require 'csv'
require 'pry'

# sales_data = [
# last_name, gross_sale_value
# Bobby, 25000
# Groundskeeper, 20000
# Bobby, 20000
# Bobby, 40000
# Wiggum, 25000
# Wiggum, 10000
# Lob, 10000
# Lob, 10000
# Groundskeeper, 15000
# Bobby, 80000
# Lob, 5000
# Groundskeeper, 30000
# ]


# ********************************************************************************************
#                                   CLASSES
# ********************************************************************************************

require_relative 'employee'
require_relative 'commission_sales_person'
require_relative 'quota_sales_person'
require_relative 'owner'

class Sale
  def self.sales
    sales = []
    CSV.foreach('sales.csv', headers: true) do |row|
      sales << row.to_hash
    end
  end
end

class Company
  attr_reader :monthly_quota, :sales

  def initialize(monthly_quota)
    @monthly_quota = monthly_quota.to_i
    @sales = 0
  end

  def hit_quota?
    @sales >= @monthly_quota
  end

  def add_sale(amount)
    @sales += amount
  end
end

# ********************************************************************************************
#                                   PROGRAM
# ********************************************************************************************

# Your job is to write a program that calculates everyone's net pay.
#Assume that payroll is disbursed monthly, so you can divide annual salaries by twelve to determine gross base pay.
#Trailing decimals are rounded down to the lowest penny.

# So that the system is easy to update, we recommend you create a CSV of each employee so it is easy to add and remove employees from the system.

# company = Company.new(250000)

# employees.each do |employee|
#   puts "***#{employee.name}***"
#   puts "Gross Salary: $#{gross_salary}"
#   puts "Net Pay: $#{net_pay}"
#   puts "***\n\n"
# end

Employee.parse_employees('employees.csv')

binding.pry

