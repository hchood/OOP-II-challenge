require_relative 'employee'

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
