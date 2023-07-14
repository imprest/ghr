defmodule Ghr.Payroll.Emp do
  use Ghr.Schema
  import Ecto.Changeset

  @required [:emp_id, :tin, :emp_name, :dob, :start_date, :base_salary]
  @fields @required

  @primary_key {:id, :string, autogenerate: false}
  schema "emps" do
    belongs_to :org, Ghr.Accounts.Org
    field :emp_id, :string
    field :tin, :string
    field :emp_name, :string
    field :dob, :date, default: ~D[1970-01-01]
    field :start_date, :date
    field :stop_date, :date
    # Paid via: CASH, UMB, ABSA, MOMO etc CASH is special
    field :paid_via, :string, default: "CASH"
    field :emp_account, :string, default: "CASH"
    # position: EXPATRIATE, MANAGEMENT, SENIOR, JUNIOR, OTHER
    field :position, Ecto.Enum, default: :"JUNIOR", values: [:"EXPATRIATE", :"MANAGEMENT", :"SENIOR", :"JUNIOR"]
    field :emp_type, Ecto.Enum, default: :"Resident-Full-Time", values: [:"Resident-Full-Time", :"Non-Resident", :"Resident-Part-Time", :"Resident-Casual"]
    field :base_salary, :decimal, default: 0
    field :days, :decimal, default: Decimal.new("27.00")
    field :second_job, :boolean, default: false
    field :ssnit_percent, :decimal, default: 0.00
    field :ssnit_no, :string
    field :ssnit_t2_no, :string
    field :pf_percent, :decimal, default: 0.00
    field :pf_no, :string
    field :ded_tuc_percent, :decimal, default: 0.00
    field :ded_welfare, :decimal, default: 0.00
    field :cash_allowance, :decimal, default: 0.00
    # Accommodation element: ~ 10% of basic salary for fully furnished or staying alone
    # 2.5% of basic salary for shared accommodation
    field :accommodation, :decimal, default: 0.00
    # Driver w/ vehicle w/ fuel: 12.5% to max 1500
    # Vehicle w/ fuel: 10% to max 1250
    # Vehicle OR Fuel only: 5% to max 625
    field :vehicle, :decimal, default: 0.00
    # Utilities etc. add monthly electricity and water consumption
    field :non_cash, :decimal, default: 0.00
    field :dept, :string, default: "Administration" # ADMIN, FACTORY, SALES, BSV
    field :sub_dept, :string, default: "Worker" # MR, DRIVER, MECHANIC, CEO, MANAGER etc
    field :designation, :string
    field :note, :string
    belongs_to :inserted_by, Ghr.Accounts.User
    belongs_to :updated_by, Ghr.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(emp, attrs) do
    emp
    |> cast(attrs, @fields)
    |> validate_required(@required)
  end
end
