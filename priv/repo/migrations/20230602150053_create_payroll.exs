defmodule Ghr.Repo.Migrations.CreatePayroll do
  use Ecto.Migration

  def change do
    create table(:orgs) do
      add :org, :text, null: false
      timestamps()
  end

  create unique_index(:orgs, [:name])


  create table(income_tax_rates) do
    add :org_id, references(:orgs, on_delete: :nothing), null: false
    # effective date of income tax rates i.e. will be an elixir term or map with income tax table
    add :date, :binary, null: false
    timestamps()
  end
  create index(:income_tax_rates, [:org_id])

  create table(:emp_master) do
    add :org_id, references(:orgs, on_delete: :nothing), null: false
    add :emp_id, :text, null: false
    add :tin, :text, null: false
    add :emp_name, :text, null: false
    add :dob, :date, null: false
    # Paid via: CASH, UMB, ABSA, MOMO etc CASH is special
    add :paid_via, :string, null: false, default: "CASH"
    add :payment_account, :string, null: false, default: "CASH"
    # position: EXPATRIATE, MANAGEMENT, SENIOR, JUNIOR, OTHER
    add :position, :text, null: false
    # Resident-Full-Time, Non-Resident, Resident-Part-Time, Resident-Casual
    add :emp_type, :text, null: false, default: "Resident-Full-Time"
    add :base_salary, :decimal, null: false, default: 0.00, precision: 20, scale: 2
    add :secondary_emp, :boolean, null: false, default: false
    add :ssnit_percent, decimal, null: false, default: 0.00, precision: 20, scale: 2
    add :ssnit_id, :string
    # pf
    add :third_tier_percent, decimal, null: false, default: 0.00, precision: 20, scale: 2
    add :third_tier, :string
    # Accommodation element:
    add :accommodation, :decimal, null: false, default: 0.00
    # Driver w/ vehicle w/ fuel: 12.5% to max 1500
    # Vehicle w/ fuel: 10% to max 1250
    # Vehicle OR Fuel only: 5% to max 625
    add :vehicle, :decimal, null: false, default: 0.00, precision: 20, scale: 2
    # Utilities etc. add monthly electricity and water consumption
    add :non-cash, :decimal, null: false, default: 0.00, precision: 20, scale: 2
    add :cash_allowance, :decimal, null: false, default: 0.00, precision: 20, scale: 2
    timestamps()
  end

  create unique_index(:emp_master, [:org_id, :emp_id])
  create index(:emp_master, [:org_id])

  create table(:month_payroll) do
    add :month, :date, null: false
    add :start_date, :date, null: false
    add :end_date, :date, null: false
    add :org_id, references(:orgs, on_delete: :nothing), null: false
    add :emp_id, :text, null: false
    add :bonus, :decimal, null: false, default: 0.00, precision: 20, scale: 2
    add :bonus_final_tax, :decimal, null: false, default: 0.00, precision: 20, scale: 2
    add :excess_bonus, :decimal, null: false, default: 0.00, precision: 20, scale: 2
    add :total_assessable_income, :decimal, null: false, default: 0.00, precision: 20, scale: 2
    add :ded_reliefs, :decimal, null: false, default: 0.00, precision: 20, scale: 2
    add :total_reliefs, :decimal, null: false, default: 0.00, precision: 20, scale: 2
    add :chargeable_income, :decimal, null: false, default: 0.00, precision: 20, scale: 2
    add :tax_ded, :decimal, null: false, default: 0.00, precision: 20, scale: 2
    add :overtime_income, :decimal, null: false, default: 0.00, precision: 20, scale: 2
    add :overtime_tax, :decimal, null: false, default: 0.00, precision: 20, scale: 2
    add :severance_pay, :decimal, null: false, default: 0.00, precision: 20, scale: 2
    timestamps()
  end

  create unique_index(:month_payroll, [:month, :org_id, :emp_id])
  create index(:month_payroll, [:org_id])
end
