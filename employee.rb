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

  def add_sale(amount)
    @sales += amount
  end

  def gross_monthly_salary
    super + (@sales * @commission)
  end
end

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

  def add_sale(amount)
    @sales += amount
  end

  def gross_monthly_salary
    if self.hit_quota?
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
