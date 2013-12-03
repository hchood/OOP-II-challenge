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
    @sales = 0
  end

  def import_sales
    @sales = Sale.gross_sales
  end

  def hit_quota?
    @sales >= @monthly_quota
  end
end

# ********************************************************************************************
#                                   PROGRAM
# ********************************************************************************************

# Your job is to write a program that calculates everyone's net pay.
#Assume that payroll is disbursed monthly, so you can divide annual salaries by twelve to determine gross base pay.
#Trailing decimals are rounded down to the lowest penny.

# So that the system is easy to update, we recommend you create a CSV of each employee so it is easy to add and remove employees from the system.


Employee.parse_employees('employees.csv')
Sale.parse_sales('sales.csv')

# binding.pry
employees = Employee.employees

employees.each do |employee|
  puts "***#{employee.name}***"
  puts "Gross Salary: $#{sprintf('%.2f', employee.gross_monthly_salary)}"
  puts "Commission: $#{sprintf('%.2f', employee.commission)}" unless employee.class == Employee
  puts "Net Pay: $#{sprintf('%.2f', employee.net_pay)}"
  puts "***\n\n"
end
