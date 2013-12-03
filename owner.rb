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
