require 'csv'
require 'pry'

# ********************************************************************************************
#                                   CLASSES
# ********************************************************************************************

require_relative 'employee'
require_relative 'sale'
require_relative 'company'

# ********************************************************************************************
#                                   PROGRAM
# ********************************************************************************************

Employee.parse_employees('employees.csv')
Sale.parse_sales('sales.csv')

employees = Employee.employees

employees.each do |employee|
  puts "***#{employee.name}***"
  puts "Gross Salary: $#{sprintf('%.2f', employee.gross_monthly_salary)}"
  puts "Commission: $#{sprintf('%.2f', employee.commission)}" if employee.class == CommissionSalesPerson
  puts "Bonus: $#{sprintf('%.2f', employee.bonus)}" if employee.class == QuotaSalesPerson || employee.class == Owner
  puts "Net Pay: $#{sprintf('%.2f', employee.net_pay)}"
  puts "***\n\n"
end
