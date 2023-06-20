defmodule Ghr.Repo.Migrations.CreatePayroll do
  use Ecto.Migration

  def change do
    create table(:orgs) do
      add :org, :text, null: false
      timestamps()
  end

  create unique_index(:orgs, [:name])

  create table(:emp_master) do
    add :org_id, references(:orgs, on_delete: :nothing), null: false
    add :emp_id, :text, null: false
    add :tin, :text, null: false
    add :emp_name, :text, null: false
    add :dob, :date, null: false
    add :joined_date, :date, null: false
    add :stop_date, :date, null: false
    # Paid via: CASH, UMB, ABSA, MOMO etc CASH is special
    add :paid_via, :string, null: false, default: "CASH"
    add :emp_account, :string, null: false, default: "CASH"
    # position: EXPATRIATE, MANAGEMENT, SENIOR, JUNIOR, OTHER
    add :position, :text, null: false
    # Resident-Full-Time, Non-Resident, Resident-Part-Time, Resident-Casual
    add :emp_type, :text, null: false, default: "Resident-Full-Time"
    add :base_salary, :decimal, null: false, default: 0.00, precision: 20, scale: 2
    add :days, :decimal, null: false, default: 27.00, precision: 20, scale: 2
    add :second_job, :boolean, null: false, default: false
    add :ssnit_percent, decimal, null: false, default: 0.00, precision: 20, scale: 2
    add :ssnit_id, :string
    # pf
    add :third_tier_percent, decimal, null: false, default: 0.00, precision: 20, scale: 2
    add :third_tier_id, :string
    add :cash_allowance, :decimal, null: false, default: 0.00, precision: 20, scale: 2
    # Accommodation element: ~ 10% of basic salary for fully furnished or staying alone2
    # 2.5% of basic salary for shared accommodation
    add :accommodation, :decimal, null: false, default: 0.00
    # Driver w/ vehicle w/ fuel: 12.5% to max 1500
    # Vehicle w/ fuel: 10% to max 1250
    # Vehicle OR Fuel only: 5% to max 625
    add :vehicle, :decimal, null: false, default: 0.00, precision: 20, scale: 2
    # Utilities etc. add monthly electricity and water consumption
    add :non-cash, :decimal, null: false, default: 0.00, precision: 20, scale: 2
    add :group, :text, null: false, default: "ADMIN" # ADMIN, FACTORY, SALES, BSV
    add :sub_group, :text, null: false, default: "WORKER" # MR, DRIVER, MECHANIC, CEO, MANAGER etc
    add :inserted_by_id, references(:users, on_delete: :nothing)
    add :updated_by_id, references(:users, on_delete: :nothing)
    timestamps()
  end

  create unique_index(:emp_master, [:org_id, :emp_id])
  create index(:emp_master, [:org_id])

  create_table(:month) do
    add :id, :text, primary: true # org_id_YYYYMM
    add :org_id, references(:orgs, on_delete: :nothing), null: false
    add :month, :date, null: false
    add :start_date, :date, null: false
    add :end_date, :date, null: false
    add :locked, :binary, null: false, default: false
    # income tax rates i.e. will be an elixir term or map with income tax table
    # Non-Resident = 25%, Resident-Part-Time = 10%, Resident-Casual = 5%,
    # Resident-Full-Time = Tax table
    add :income_tax, :binary, null: false
    # Up to 15% of the emp annual basic salary and subject to a concessionary tax rate
    add :bonus_tax, :decimal, null: false, default: 5.00, precision: 20, scale: 2
    # Also embedded overtime tax rates only for Resident JUNIOR employee
    # if overtime is <= 50% of basic/earned salary than 5% and anything > 50% is taxed at 10%
    # Annual income for Junior should not be more than 18,000 GHS
    # Non-Resident tax on bonus or overtime is 20%
    add :overtime_tax, :decimal, null: false, default: 5.00, precision: 20, scale: 2
    add :overtime_tax_excess, :decimal, null: false, default: 10.00, precision: 20, scale: 2
    add :inserted_by_id, references(:users, on_delete: :nothing)
    add :updated_by_id, references(:users, on_delete: :nothing)
    timestamps()
  end

  # create unidex to make sure start_date and end_date don't overlap for other months
  create unique_index(:month, [:org_id, :month])
  create index(:month, [:org_id])

  create table(:month_payroll) do
    add :id, :text, primary: true # org_id_YYYYMM_emp_id
    add :month_id, references(:month, on_delete: :nothing), null: false
    add :emp_id, :text, null: false
    add :days, :decimal, null: false, default: 27.00, precision: 20, scale: 2
    add :earned_salary, :decimal, null: false, default: 0.00, precision: 20, scale: 2
    add :ssnit, :decimal, null: false, default: 0.00, precision: 20, scale: 2
    add :third_tier, :decimal, null: false, default: 0.00, precision: 20, scale: 2
    add :cash_allowance, :decimal, null: false, default: 0.00, precision: 20, scale: 2
    # Up to 15% of the emp annual basic salary and subject to a concessionary tax rate
    add :bonus, :decimal, null: false, default: 0.00, precision: 20, scale: 2
    # 5% tax on bonux that is <= 15% of emp annual basic salary
    add :bonus_final_tax, :decimal, null: false, default: 0.00, precision: 20, scale: 2
    # Bonus more than 15% of the emp annual basic salary
    add :excess_bonus, :decimal, null: false, default: 0.00, precision: 20, scale: 2
    add :total_cash, :decimal, null: false, default: 0.00, precision: 20, scale: 2
    add :accommodation, :decimal, null: false, default: 0.00
    add :vehicle, :decimal, null: false, default: 0.00, precision: 20, scale: 2
    add :non-cash, :decimal, null: false, default: 0.00, precision: 20, scale: 2
    add :total_assessible_income, :decimal, null: false, default: 0.00, precision: 20, scale: 2
    add :ded_reliefs, :decimal, null: false, default: 0.00, precision: 20, scale: 2
    add :total_reliefs, :decimal, null: false, default: 0.00, precision: 20, scale: 2
    add :taxable_income, :decimal, null: false, default: 0.00, precision: 20, scale: 2
    add :tax_ded, :decimal, null: false, default: 0.00, precision: 20, scale: 2
    add :overtime, :decimal, null: false, default: 0.00, precision: 20, scale: 2
    # if overtime is <= 50% of basic/earned salary than 5% and anything > 50% is taxed at 10%
    add :overtime_tax, :decimal, null: false, default: 0.00, precision: 20, scale: 2
    # Amount for let go etc. This amount is exempt from tax
    add :total_tax, :decimal, null: false, default: 0.00, precision: 20, scale: 2
    add :severance, :decimal, null: false, default: 0.00, precision: 20, scale: 2
    add :net_pay, :decimal, null: false, default: 0.00, precision: 20, scale: 2
    add :remarks, :text
    add :inserted_by_id, references(:users, on_delete: :nothing)
    add :updated_by_id, references(:users, on_delete: :nothing)
    timestamps()
  end

  create unique_index(:month_payroll, [:month_id, :emp_id])
  create index(:month_payroll, [:month_id])

  create_table(:overtime) do
    add :id, :text, primary: true # org_id_YYYYMM_emp_id
    add :month_id, references(:month, on_delete: :nothing), null: false
    add :emp_id, :text, null: false
    # enforce date falls in the month_id range
    add :date, :date, null: false, default: now()
    add :hours, :integer, null: false, default: 0 # enforce 0 to 24
    add :mins, :integer, null: false, default: 0 # enforce 0 to 60
    add :rate, :decimal, null: false, default: 1.50, precision: 20, scale: 2 # 1.5 for normal | 2 for holidays
    add :inserted_by_id, references(:users, on_delete: :nothing)
    add :updated_by_id, references(:users, on_delete: :nothing)
    timestamps()
  end
  create unique_index(:overtime, [:month_id, :emp_id])
  create index(:overtime, [:month_id])
end
