# employees = [
#   {name: "Johnny Smith", base_salary: 80000},
#   {name: "Jimmy McMahon", base_salary: 85000},
#   {name: "Bob Lob", base_salary: 50000, commission: 0.005},
#   {name: "Ricky Bobby", base_salary: 40000, commission: 0.015},
#   {name: "Edna Krabappel", base_salary: 87000},
#   {name: "Willie Groundskeeper", base_salary: 75000, quota_bonus: 5000 if 60k gross monthly sales},
#   {name: "Clancy Wiggum", base_salary: 80000, quota_bonus: 10000 if 80k gross monthly sales},
#   {name: "Charles Burns", base_salary: 500000}
# ]

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
  attr_reader :name, :base_salary

  @@employees = []

  def initialize(name, base_salary)
    @name = name
    @base_salary = base_salary.to_i
    @@employees << self
  end

  def gross_monthly_salary
    @base_salary / 12
  end
end

class CommissionSalesPerson < Employee
  def initialize(commission_percentage)
    super +
    @commission = commission_percentage.to_f
    @sales = 0
  end

  def gross_monthly_salary
    super + (@sales * @commission)
  end
end

class QuotaSalesPerson < Employee
  def initialize(quota_bonus, monthly_quota)
    super +
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
  def initialize(company)
    super +
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

# ********************************************************************************************

class PayCalculator
  TAX_RATE = 0.30

  def initialize(employees, company)
    @employees = employees
    @company = company
  end

end

class Sale

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

company = Company.new(250000)

employees.each do |employee|
  puts "***#{employee.name}***"
  puts "Gross Salary: $#{gross_salary}"
  puts "Net Pay: $#{net_pay}"
  puts "***\n\n"
end

