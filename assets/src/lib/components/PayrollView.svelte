<script>
  import { moneyFmt } from "$lib/utils";
  import { onMount } from "svelte";

  let summary = {};
  const keys = [
    "days_worked", "base_salary", "earned_salary", "ssnit_amount", "pf_amount", "cash_allowance",
    "total_cash", "total_relief", "taxable_income", "tax_ded", "overtime_earned", "overtime_tax",
    "total_tax", "tuc_amount", "advance", "loan", "staff_welfare_ded", "pvt_loan",
    "total_ded", "total_pay"
  ]

  export let payroll = [];

  let h = 0;
  let headerHeight = 0;
  let sectionHeight = 0;
  onMount(() => {
    headerHeight = document.getElementsByClassName('header')[0].clientHeight;
    sectionHeight = document.getElementsByClassName('section')[0].clientHeight;
  })

  $: if (payroll) {
    // New payroll data do initialise summary object to zeros
    keys.forEach((k) => summary[k] = 0)
    // For each payroll item, aggregate the data into summary object
    payroll.forEach((x) => {
      keys.forEach((k) => {
        summary[k] += Number.parseFloat(x[k])
      })
    });
  }
</script>

<svelte:window bind:innerHeight={h}/>

<section class="section-full">
  <div class="overflow-x-auto" style:height="{h-headerHeight-sectionHeight-40}px">
    <table class="table is-striped is-bordered">
      <thead>
        <tr>
          <th class="text-center"><div>ID</div></th>
          <th><div>Name</div></th>
          <th class="text-center">Days</th>
          <th class="text-center">Basic Salary</th>
          <th class="text-center">Earned Salary</th>
          <th class="text-center">SSNIT</th>
          <th class="text-center">PF</th>
          <th class="text-center">Cash Allow.</th>
          <th class="text-center">Total Income</th>
          <th class="text-center">Total Relief</th>
          <th class="text-center">Taxable Income</th>
          <th class="text-center">Tax Ded.</th>
          <th class="text-center">Overtime</th>
          <th class="text-center">Overtime Tax</th>
          <th class="text-center">Total Tax</th>
          <th class="text-center">TUC Ded.</th>
          <th class="text-center">Advance</th>
          <th class="text-center">Loan</th>
          <th class="text-center">Welfare Ded.</th>
          <th class="text-center">Pvt Loan</th>
          <th class="text-center">Total Ded.</th>
          <th class="text-center">Total Pay</th>
          <th class="text-center">Net Pay</th>
        </tr>
      </thead>
      <tbody>
        {#each payroll as p, i}
          <tr class={p.net_pay != p.total_pay ? "red" : ""}>
            <td class="text-center">
              <span class={i%2===0 ? "bg-white" : "yellow"}>
                {p.id}
              </span>
            </td>
            <td>
              <span class={i%2===0 ? "bg-white" : "yellow"}>
                {p.name}
              </span>
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
  </div>
</section>

<style lang="postcss">
  thead tr th,
  tfoot tr th {
    @apply sticky z-20;
  }

  thead tr th {
    @apply top-0 h-px;
  }
  thead th:first-child { @apply sticky left-0 z-30; }
  thead th:nth-child(2) { @apply sticky left-14 z-30; }
  thead th > div { @apply bg-white inline-table h-full w-full; }

  tfoot tr th {
    @apply bottom-0 bg-white;
  }

  tbody tr td:first-child {
    @apply p-0 sticky left-0 z-10 h-full;
  }

  tbody tr td:nth-child(2) {
    @apply p-0 sticky left-[60px] z-10 h-full;
  }

  tbody tr td > span {
    @apply px-2 py-1 block h-full z-40;
  }

  .red { @apply bg-red-500; }
  .yellow { background-color: lightgoldenrodyellow; }
</style>
