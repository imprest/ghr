defmodule Ghr.Data.Import do
  require Logger

  import Ghr.Data.Utils, only: [to_date: 1, to_time: 1, to_decimal: 1, nil?: 1]
  import Ecto.Query

  alias Ghr.Repo
  alias Ghr.Data.Dbase
  alias Decimal, as: D

  @employee_master "/home/hvaria/Documents/backup/HPMG22/H1EMP.DBF"
  @calculated_payroll "/home/hvaria/Documents/backup/HPMG22/H1DETPAY.DBF"
  @zero D.new(0)

  def month(month) do
    Dbase.parse(@employee_master,
      [
        "EMP_NO",
        "EMP_NM",
        "EMP_DOB",
        "EMP_DEPT",
        "EMP_CB",
        "EMP_RATE",
        "EMP_BKDET",
        "EMP_SDEPT",
        "EMP_DESIG",
        "EMP_JOINDT",
        "EMP_DISCDT",
        "EMP_RTBASE",
        "EMP_SSNO",
        "EMP_FNO1",
        "EMP_FNO2",
        "EMP_FNO3",
        "EMP_FNO4",
        "EMP_ROT",
        "EMP_OTHALL",
        "EMP_DED1",
        "EMP_DED2",
        "EMP_SSFYN",
        "EMP_TUCYN",
        "EMP_LMD"
      ],
      fn x ->
        %{
          id: "1_#{x["EMP_NO"]}",
          org_id: 1,
          emp_name: x["EMP_NM"],
          tin: parse_tin(x["EMP_FNO1"], x["EMP_FN04"]),
          position: "junior",
          emp_type: "Resident-Full-Time",
          base_salary: to_decimal(x["EMP_RATE"]),
          days: 27,
          second_job: false,
          dob: parse_date(x["EMP_DOB"]),
          start_date: parse_date(x["EMP_JOINDT"]),
          stop_date: parse_terminated(x["EMP_RTBASE"], x["EMP_DISCDT"], x["EMP_LMD"]),
          paid_via: parse_cash(x["EMP_CB"], String.slice(x["EMP_BKDET"], 0, 3)),
          emp_account: parse_account(x["EMP_BKDET"]),
          dept: parse_dep(x["EMP_DEPT"]),
          sub_dept: parse_sub_dept(x["EMP_SDEPT"]),
          designation: nil?(x["EMP_DESIG"]),
          ssnit_no: nil?(x["EMP_SSNO"]),
          ssnit_t2_no: nil?(x["EMP_FNO2"]), # Enterprise
          ssnit_percent: parse_ssnit_ded(x["EMP_SSFYN"], x["EMP_NO"]),
          pf_no: nil?(x["EMP_FNO3"]),
          pf_percent: to_decimal(x["EMP_DED2"]),
          ded_tuc_percent: parse_tuc_ded(x["EMP_TUCYN"]),
          ded_welfare: to_decimal(x["EMP_DED1"]),
          note: nil?(x["EMP_ROT"]),
          cash_allowance: to_decimal(x["EMP_OTHALL"]),
          accommodation: @zero,
          vehicle: @zero,
          non_cash: @zero,
          inserted_by_id: 1,
          updated_by_id: 1,
          created_at: to_timestamp(x["EMP_LMD"], x["EMP_LMT"]),
          updated_at: to_timestamp(x["EMP_LMD"], x["EMP_LMT"])
        }
      end
    )
    |> Enum.reduce(%{}, fn x, acc ->
      Map.put(acc, x.id, x)
    end)
  end

  defp parse_tin(tin, nil), do: tin
  defp parse_tin(nil, tin), do: tin

  defp parse_dep("M001"), do: "Administration"
  defp parse_dep("M002"), do: "Factory"

  defp parse_sub_dept("S001"), do: "Drivers"
  defp parse_sub_dept("S002"), do: "Marketing"
  defp parse_sub_dept("S003"), do: "Security"
  defp parse_sub_dept("S004"), do: "Stores"
  defp parse_sub_dept("S005"), do: "Workers"
  defp parse_sub_dept("S006"), do: "Quality Control"
  defp parse_sub_dept("S007"), do: "Maintenance"
  defp parse_sub_dept("S008"), do: "Others"
  defp parse_sub_dept(_), do: "Others"

  defp parse_cash("C", _), do: "CASH"
  defp parse_cash("B", "MBG"), do: "UMB"
  defp parse_cash("B", "BBG"), do: "ABSA"
  defp parse_cash("B", _), do: "UMB"

  defp parse_account(details) do
    account = String.split(details, "-", parts: 2) |> Enum.at(1)
    case account do
      :nil -> "CASH"
      a -> a
    end
  end

  defp parse_ssnit_ded(_, "E0053"), do: D.new(5)
  defp parse_ssnit_ded("5.50", _), do: D.new("5.5")
  defp parse_ssnit_ded("0.00", _), do: D.new(0)
  defp parse_ssnit_ded("N", _), do: D.new(0)
  defp parse_ssnit_ded("Y", "E0053"), do: D.new(5)
  defp parse_ssnit_ded("Y", _), do: D.new("5.5")

  defp parse_tuc_ded("2.00"), do: Decimal.new(2)
  defp parse_tuc_ded("0.00"), do: Decimal.new(0)
  defp parse_tuc_ded("Y"), do: Decimal.new(2)
  defp parse_tuc_ded("N"), do: Decimal.new(0)

  defp parse_terminated("M", _, _), do: nil
  defp parse_terminated("X", date, lmd), do: parse_terminated(date, lmd)
  defp parse_terminated("D", date, lmd), do: parse_terminated(date, lmd)
  defp parse_terminated("", lmd), do: to_date(lmd)
  defp parse_terminated(date, _), do: to_date(date)
  defp parse_terminated(nil, lmd), do: to_date(lmd)

  defp parse_date(""), do: nil
  defp parse_date(date), do: to_date(date)

  defp to_timestamp(lmd, lmt), do: DateTime.new!(to_date(lmd), to_time(lmt))
end
