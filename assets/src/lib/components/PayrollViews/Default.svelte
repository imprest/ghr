<script>
  import { moneyFmt } from "$lib/utils";
  import { data } from "$store";

  let summary = {};
  const keys = [
    "days_worked", "base_salary", "earned_salary", "ssnit_amount", "pf_amount", "cash_allowance",
    "total_cash", "total_relief", "taxable_income", "tax_ded", "overtime_earned", "overtime_tax",
    "total_tax", "tuc_amount", "advance", "loan", "staff_welfare_ded", "pvt_loan",
    "total_ded", "total_pay"
  ]

  $: if ($data.payroll) {
    // New payroll data do initialise summary object to zeros
    keys.forEach((k) => summary[k] = 0)
    // For each payroll item, aggregate the data into summary object
    $data.payroll.forEach((x) => {
      keys.forEach((k) => {
        summary[k] += Number.parseFloat(x[k])
      })
    });
  }
</script>

<table class="table is-striped is-bordered">
  <thead>
    <tr>
      <th class="text-center"><div>ID</div></th>
      <th><div>Name</div></th>
      <th class="text-center"><div>Days</div></th>
      <th class="text-center"><div>Basic Salary</div></th>
      <th class="text-center"><div>Earned Salary</div></th>
      <th class="text-center"><div>SSNIT</div></th>
      <th class="text-center"><div>PF</div></th>
      <th class="text-center"><div>Cash Allow.</div></th>
      <th class="text-center"><div>Total Income</div></th>
      <th class="text-center"><div>Total Relief</div></th>
      <th class="text-center"><div>Taxable Income</div></th>
      <th class="text-center"><div>Tax Ded.</div></th>
      <th class="text-center"><div>Overtime</div></th>
      <th class="text-center"><div>Overtime Tax</div></th>
      <th class="text-center"><div>Total Tax</div></th>
      <th class="text-center"><div>TUC Ded.</div></th>
      <th class="text-center"><div>Advance</div></th>
      <th class="text-center"><div>Loan</div></th>
      <th class="text-center"><div>Welfare Ded.</div></th>
      <th class="text-center"><div>Pvt Loan</div></th>
      <th class="text-center"><div>Total Ded.</div></th>
      <th class="text-center"><div>Total Pay</div></th>
      <th class="text-center"><div>Net Pay</div></th>
    </tr>
  </thead>
  <tbody>
    {#each $data.payroll as p, i}
      <tr class={p.net_pay != p.total_pay ? "text-red-700 font-semibold" : ""}>
        <td class="text-center">
          <div class={i%2===0 ? "bg-white" : "yellow"}>
            {p.id}
          </div>
        </td>
        <td>
          <div class={i%2===0 ? "bg-white" : "yellow"}>
            {p.name}
          </div>
        </td>
        <td class="text-center">{moneyFmt(p.days_worked)}</td>
        <td class="text-right"> {moneyFmt(p.base_salary)}</td>
        <td class="text-right"> {moneyFmt(p.earned_salary)}</td>
        <td class="text-right"> {moneyFmt(p.ssnit_amount)}</td>
        <td class="text-right"> {moneyFmt(p.pf_amount)}</td>
        <td class="text-right"> {moneyFmt(p.cash_allowance)}</td>
        <td class="text-right"> {moneyFmt(p.total_cash)}</td>
        <td class="text-right"> {moneyFmt(p.total_relief)}</td>
        <td class="text-right"> {moneyFmt(p.taxable_income)}</td>
        <td class="text-right"> {moneyFmt(p.tax_ded)}</td>
        <td class="text-right"> {moneyFmt(p.overtime_earned)}</td>
        <td class="text-right"> {moneyFmt(p.overtime_tax)}</td>
        <td class="text-right"> {moneyFmt(p.total_tax)}</td>
        <td class="text-right"> {moneyFmt(p.tuc_amount)}</td>
        <td class="text-right"> {moneyFmt(p.advance)}</td>
        <td class="text-right"> {moneyFmt(p.loan)}</td>
        <td class="text-right"> {moneyFmt(p.staff_welfare_ded)}</td>
        <td class="text-right"> {moneyFmt(p.pvt_loan)}</td>
        <td class="text-right"> {moneyFmt(p.total_ded)}</td>
        <td class="text-right"> {moneyFmt(p.total_pay)}</td>
        <td class="text-right"> {moneyFmt(p.net_pay)}</td>
      </tr>
    {/each}
  </tbody>
  <tfoot>
    <tr>
      <th />
      <th class="text-right">Total:</th>
      <th class="text-center">{moneyFmt(summary.days_worked)}</th>
      <th class="text-right"> {moneyFmt(summary.base_salary)}</th>
      <th class="text-right"> {moneyFmt(summary.earned_salary)}</th>
      <th class="text-right"> {moneyFmt(summary.ssnit_amount)}</th>
      <th class="text-right"> {moneyFmt(summary.pf_amount)}</th>
      <th class="text-right"> {moneyFmt(summary.cash_allowance)}</th>
      <th class="text-right"> {moneyFmt(summary.total_cash)}</th>
      <th class="text-right"> {moneyFmt(summary.total_relief)}</th>
      <th class="text-right"> {moneyFmt(summary.taxable_income)}</th>
      <th class="text-right"> {moneyFmt(summary.tax_ded)}</th>
      <th class="text-right"> {moneyFmt(summary.overtime_earned)}</th>
      <th class="text-right"> {moneyFmt(summary.overtime_tax)}</th>
      <th class="text-right"> {moneyFmt(summary.total_tax)}</th>
      <th class="text-right"> {moneyFmt(summary.tuc_amount)}</th>
      <th class="text-right"> {moneyFmt(summary.advance)}</th>
      <th class="text-right"> {moneyFmt(summary.loan)}</th>
      <th class="text-right"> {moneyFmt(summary.staff_welfare_ded)}</th>
      <th class="text-right"> {moneyFmt(summary.pvt_loan)}</th>
      <th class="text-right"> {moneyFmt(summary.total_ded)}</th>
      <th class="text-right"> {moneyFmt(summary.total_pay)}</th>
      <th />
    </tr>
  </tfoot>
</table>

<style lang="postcss">
  thead tr th,
  tfoot tr th {
    @apply sticky z-20;
  }

  thead tr th {
    @apply top-0 h-px bg-white border-b-0;
  }
  thead th:first-child { @apply sticky left-0 z-30; }
  thead th:nth-child(2) { @apply sticky left-14 z-30; }
  thead th > div { @apply bg-white inline-block h-full w-full px-2 py-1; }

  tfoot tr th {
    @apply bottom-0 bg-white;
  }

  tbody tr td:first-child {
    @apply p-0 sticky left-0 z-10 h-full;
  }

  tbody tr td:nth-child(2) {
    @apply p-0 sticky left-[60px] z-10 h-full;
  }

  tbody tr td > div {
    @apply px-2 py-1 block h-full z-40;
  }

  tbody tr:hover td > div { background-color: var(--table-hover); }

  .yellow { background-color: lightgoldenrodyellow; }
</style>
