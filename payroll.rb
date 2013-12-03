require 'csv'
require 'pry'

# ********************************************************************************************
#                                   CLASSES
# ********************************************************************************************

require_relative 'employee'
require_relative 'sale'

class Company
  attr_reader :monthly_quota, :sales

  def initialize(monthly_quota)
    @monthly_quota = monthly_quota.to_i
    @sales = Sale.gross_sales
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

Employee.parse_employees('employees.csv')
Sale.parse_sales('sales.csv')
puts Sale.gross_sales

binding.pry

# employees.each do |employee|
#   puts "***#{employee.name}***"
#   puts "Gross Salary: $#{gross_salary}"
#   puts "Net Pay: $#{net_pay}"
#   puts "***\n\n"
# end
