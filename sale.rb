
class Sale
  attr_reader :last_name, :amount

  @@sales = []

  def initialize(last_name, amount)
    @last_name = last_name
    @amount = amount
  end

  def self.list_of_sales
    @@sales
  end

  def self.gross_sales
    amounts = @@sales.map {|sale| sale.amount}
    amounts.reduce(:+)
  end

  def self.parse_sales(filename)
    CSV.foreach(filename, headers: true) do |row|
      sale = Sale.new(row["last_name"], row["gross_sale_value"].to_i)
      @@sales << sale
      sales_person = Employee.employees.select { |employee| employee.last_name == sale.last_name }.first
      sales_person.add_sale(sale.amount)
    end
  end
end
