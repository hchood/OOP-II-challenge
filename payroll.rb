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

class Employee
  attr_reader :name, :last_name, :base_salary

  TAX_RATE = 0.30

  def initialize(name, base_salary)
    @name = name
    @last_name = name.split(/ /).last
    @base_salary = base_salary.to_i
  end

  def self.employees
    @@employees
  end

  def self.parse_employees(filename)
    @@employees = []
    CSV.foreach(filename, headers: true) do |row|
      if row["type"] == "1"
        @@employees << Employee.new(row["name"], row["base_salary"])
      elsif row["type"] == "2"
        @@employees << CommissionSalesPerson.new(row["name"], row["base_salary"], row["commission"])
      elsif row["type"] == "3"
        @@employees << QuotaSalesPerson.new(row["name"], row["base_salary"], row["quota_bonus"], row["quota"])
      elsif row["type"] == "4"
        @@employees << Owner.new(row["name"], row["base_salary"], Company.new(row["company_quota"]))
      else
        puts "Error"
      end
    end

  end

  def gross_monthly_salary
    @base_salary / 12
  end

  def net_pay
    self.gross_monthly_salary * (1 - TAX_RATE)
  end
end

class CommissionSalesPerson < Employee
  def initialize(name, base_salary, commission_percentage)
    super(name, base_salary)
    @commission = commission_percentage.to_f
    @sales = 0
  end

  def gross_monthly_salary
    super + (@sales * @commission)
  end
end

class QuotaSalesPerson < Employee
  def initialize(name, base_salary, quota_bonus, monthly_quota)
    super(name, base_salary)
    @quota_bonus = quota_bonus
    @monthly_quota = monthly_quota
    @sales = 0
  end

  def gross_monthly_salary
    if @sales >= @monthly_quota
      super + @quota_bonus
    else
      super
    end
  end
end

class Owner < Employee
  def initialize(name, base_salary, company)
    super(name, base_salary)
    @company = company
  end

  def gross_monthly_salary
    if @company.hit_quota?
      super + 1000
    else
      super
    end
  end
end

    # ************************************************************

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

