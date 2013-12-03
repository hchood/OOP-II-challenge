class QuotaSalesPerson < Employee
  def initialize(name, base_salary, quota_bonus, quota)
    super(name, base_salary)
    @quota_bonus = quota_bonus
    @quota = quota
    @sales = 0
  end

  def hit_quota?
    @sales >= @quota
  end

  def gross_monthly_salary
    if self.hit_quota?
      super + @quota_bonus
    else
      super
    end
  end
end
