require 'csv'
require 'pry'

# NOTE:  My program matches the criteria in Apollo before Johnny updated them, because those
# criteria match the Apollo sample output and make more sense.  Therefore, I have a single
# gross_monthly_salary method in my Employee superclass (which includes only base salary)
# and separate net_pay methods for each employee subclass that add in post-tax commissions or
# bonuses.

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
