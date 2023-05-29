defmodule GhrWeb.PayrollHandler do
  use ChannelHandler.Handler 

  alias Ghr.Data.ImportPayroll, as: Payroll

  def get_month(%{"month"=> month}, _bindings, socket) do
    {:reply,
      {:ok,
        %{payroll: Payroll.import_month(month),
          management: Payroll.get_management_payroll(month) }
      },
     socket
    }
  end
end
