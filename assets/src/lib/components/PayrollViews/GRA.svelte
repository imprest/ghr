<script>
  import { moneyFmt } from '$lib/utils'
  import { data } from '$store';

  let summary = {}
  let msummary = {}

  $: payroll = $data.payroll
  $: management = $data.management

  $: if (payroll) {
    summary = {
      days_worked: 0,
      base_salary: 0,
      earned_salary: 0,
      ssnit_amount: 0,
      pf_amount: 0,
      cash_allowance: 0,
      total_cash: 0,
      total_relief: 0,
      taxable_income: 0,
      tax_ded: 0,
      overtime_earned: 0,
      overtime_tax: 0,
      total_tax: 0,
      tuc_amount: 0,
      advance: 0,
      loan: 0,
      staff_welfare_ded: 0,
      pvt_loan: 0,
      total_ded: 0,
      total_pay: 0
    };
    payroll.forEach(x => {
      summary.days_worked += Number.parseFloat(x.days_worked);
      summary.base_salary += Number.parseFloat(x.base_salary);
      summary.earned_salary += Number.parseFloat(x.earned_salary);
      summary.ssnit_amount += Number.parseFloat(x.ssnit_amount);
      summary.pf_amount += Number.parseFloat(x.pf_amount);
      summary.cash_allowance += Number.parseFloat(x.cash_allowance);
      summary.total_cash += Number.parseFloat(x.total_cash);
      summary.total_relief += Number.parseFloat(x.total_relief);
      summary.taxable_income += Number.parseFloat(x.taxable_income);
      summary.tax_ded += Number.parseFloat(x.tax_ded);
      summary.overtime_earned += Number.parseFloat(x.overtime_earned);
      summary.overtime_tax += Number.parseFloat(x.overtime_tax);
      summary.total_tax += Number.parseFloat(x.total_tax);
    })
  }

  $: if (management) {
    msummary = {
      earned_salary: 0,
      ssnit_amount: 0,
      pf_amount: 0,
      cash_allowance: 0,
      total_cash: 0,
      living: 0,
      vehicle: 0,
      non_cash: 0,
      total_gra_income: 0,
      total_relief: 0,
      taxable_income: 0,
      tax_ded: 0,
      overtime_earned: 0,
      overtime_tax: 0,
      total_tax: 0,
      tuc_amount: 0,
      advance: 0,
      loan: 0,
      staff_welfare_ded: 0,
      pvt_loan: 0,
      total_ded: 0,
      total_pay: 0
    };
    management.forEach(x => {
      msummary.earned_salary += Number.parseFloat(x.earned_salary);
      msummary.ssnit_amount += Number.parseFloat(x.ssnit_amount);
      msummary.cash_allowance += Number.parseFloat(x.cash_allowance);
      msummary.total_cash += Number.parseFloat(x.total_cash);
      msummary.living += Number.parseFloat(x.living);
      msummary.vehicle += Number.parseFloat(x.vehicle);
      msummary.non_cash += Number.parseFloat(x.non_cash);
      msummary.total_gra_income += Number.parseFloat(x.total_gra_income);
      msummary.total_relief += Number.parseFloat(x.total_relief);
      msummary.taxable_income += Number.parseFloat(x.taxable_income);
      msummary.tax_ded += Number.parseFloat(x.tax_ded);
      msummary.overtime_earned += Number.parseFloat(x.overtime_earned);
      msummary.overtime_tax += Number.parseFloat(x.overtime_tax);
      msummary.total_tax += Number.parseFloat(x.total_tax);
    })
  }

</script>
<p class="section">
  Management Income: {moneyFmt(msummary.taxable_income)} | Tax: {moneyFmt(msummary.total_tax)}
  <br>
  Employee Income: {moneyFmt(summary.taxable_income)} | Tax: {moneyFmt(summary.total_tax)}
  <br>
  Total Income: {moneyFmt(summary.taxable_income+msummary.taxable_income)} |
  Tax: {moneyFmt(summary.total_tax+msummary.total_tax)}
</p>
<table class="table is-striped is-bordered">
  <thead>
    <tr>
      <th><div class="text-center">1<br>No.</div></th>
      <th><div>2<br>TIN / Ghana Card</div></th>
      <th class="text-center"><div>3<br>Name</div></th>
      <th class="text-center"><div>4<br>Position</div></th>
      <th class="text-center"><div>5<br>Residency etc.</div></th>
      <th class="text-center"><div>6<br>Basic Salary</div></th>
      <th class="text-center"><div>7<br>2nd Job</div></th>
      <th class="text-center"><div>8<br>Paid SSNIT</div></th>
      <th class="text-center"><div>9<br>SSNIT Fund</div></th>
      <th class="text-center"><div>10<br>3<sup>rd</sup> Tier</div></th>
      <th class="text-center"><div>11<br>Cash Allow.</div></th>
      <th class="text-center"><div>12<br>Bonus &le; 15% Annual</div></th>
      <th class="text-center"><div>13<br>Bonus Final Tax</div></th>
      <th class="text-center"><div>14<br>Excess Bonus</div></th>
      <th class="text-center"><div>15<br>Total Cash (6+11+14)</div></th>
      <th class="text-center"><div>16<br>Acc. Elem.</div></th>
      <th class="text-center"><div>17<br>Veh. Elem.</div></th>
      <th class="text-center"><div>18<br>Non-Cash Ben.</div></th>
      <th class="text-center"><div>19<br>Total Assesible Income (15+16+17+18)</div></th>
      <th class="text-center"><div>20<br>Ded. Reliefs</div></th>
      <th class="text-center"><div>21<br>Total Reliefs (9+10+20)</div></th>
      <th class="text-center"><div>22<br>Taxable Income (19-21)</div></th>
      <th class="text-center"><div>23<br>Tax Ded.</div></th>
      <th class="text-center"><div>24<br>Overtime</div></th>
      <th class="text-center"><div>25<br>Overtime Tax (13+23+25)</div></th>
      <th class="text-center"><div>26<br>Total Tax</div></th>
      <th class="text-center"><div>27<br>Severance</div></th>
      <th class="text-center"><div>28<br>Remarks</div></th>
    </tr>
  </thead>
  <tbody>
    {#each payroll as p, i }
      <tr>
        <td><div class="{ i % 2 == 0 ? 'bg-white text-right' : 'yellow text-right'}">{ i+1 }</div></td>
        <td><div class="{ i % 2 == 0 ? 'bg-white' : 'yellow'}">{ p.tin_no }</div></td>
        <td>{ p.name }</td>
        <td class="text-center">{ p.gra_category        }</td>
        <td class="text-center">N</td>
        <td class="text-right"> { moneyFmt(p.earned_salary     ) }</td>
        <td class="text-center">N</td>
        <td class="text-center">{#if p.ssnit_amount > 0}Y{:else}N{/if}</td>
        <td class="text-right"> { moneyFmt(p.ssnit_amount      ) }</td>
        <td class="text-right"> { moneyFmt(p.pf_amount         ) }</td>
        <td class="text-right"> { moneyFmt(p.cash_allowance    ) }</td>
        <td></td>
        <td></td>
        <td></td>
        <td class="text-right"> { moneyFmt(p.total_cash        ) }</td>
        <td></td>
        <td></td>
        <td></td>
        <td class="text-right"> { moneyFmt(p.total_cash        ) }</td>
        <td></td>
        <td class="text-right"> { moneyFmt(p.total_relief      ) }</td>
        <td class="text-right"> { moneyFmt(p.taxable_income    ) }</td>
        <td class="text-right"> { moneyFmt(p.tax_ded           ) }</td>
        <td class="text-right"> { moneyFmt(p.overtime_earned   ) }</td>
        <td class="text-right"> { moneyFmt(p.overtime_tax      ) }</td>
        <td class="text-right"> { moneyFmt(p.total_tax         ) }</td>
        <td></td>
        <td></td>
      </tr>
    {/each}
    {#each management as p, i }
      <tr>
        <td><div class="{ i % 2 == 0 ? 'bg-white text-right' : 'yellow text-right'}">{ payroll.length+i+1 }</div></td>
        <td><div class="{ i % 2 == 0 ? 'bg-white' : 'yellow'}">{ p.tin_no }</div></td>
        <td>{ p.name }</td>
        <td class="text-center">{ p.gra_category        }</td>
        <td class="text-center">N</td>
        <td class="text-right"> { moneyFmt(p.earned_salary     ) }</td>
        <td class="text-center">N</td>
        <td class="text-center">{#if p.ssnit_amount > 0}Y{:else}N{/if}</td>
        <td class="text-right"> { moneyFmt(p.ssnit_amount      ) }</td>
        <td class="text-right"> { moneyFmt(p.pf_amount         ) }</td>
        <td class="text-right"> 0.00 </td>
        <td></td>
        <td></td>
        <td></td>
        <td class="text-right"> { moneyFmt(p.earned_salary     ) }</td>
        <td class="text-right"> { moneyFmt(p.living        ) }</td>
        <td class="text-right"> { moneyFmt(p.vehicle        ) }</td>
        <td class="text-right"> { moneyFmt(p.non_cash        ) }</td>
        <td class="text-right"> { moneyFmt(p.total_gra_income ) }</td>
        <td></td>
        <td class="text-right"> { moneyFmt(p.ssnit_amount      ) }</td>
        <td class="text-right"> { moneyFmt(p.taxable_income    ) }</td>
        <td class="text-right"> { moneyFmt(p.tax_ded           ) }</td>
        <td class="text-right"> 0.00 </td>
        <td class="text-right"> 0.00 </td>
        <td class="text-right"> { moneyFmt(p.tax_ded         ) }</td>
        <td></td>
        <td></td>
      </tr>
    {/each}
  </tbody>
  <tfoot>
    <tr>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th class="text-right"> { moneyFmt(summary.earned_salary + msummary.earned_salary ) }</th>
      <th></th>
      <th></th>
      <th class="text-right"> { moneyFmt(summary.ssnit_amount + msummary.ssnit_amount ) }</th>
      <th class="text-right"> { moneyFmt(summary.pf_amount + msummary.pf_amount       ) }</th>
      <th class="text-right"> { moneyFmt(summary.cash_allowance + msummary.cash_allowance  ) }</th>
      <th></th>
      <th></th>
      <th></th>
      <th class="text-right"> { moneyFmt(summary.total_cash + msummary.total_cash ) }</th>
      <th class="text-right"> { moneyFmt(msummary.living ) }</th>
      <th class="text-right"> { moneyFmt(msummary.vehicle ) }</th>
      <th class="text-right"> { moneyFmt(msummary.non_cash ) }</th>
      <th class="text-right"> { moneyFmt(summary.total_cash + msummary.total_gra_income ) }</th>
      <th></th>
      <th class="text-right"> { moneyFmt(summary.total_relief + msummary.total_relief ) }</th>
      <th class="text-right"> { moneyFmt(summary.taxable_income + msummary.taxable_income ) }</th>
      <th class="text-right"> { moneyFmt(summary.tax_ded + msummary.tax_ded) }</th>
      <th class="text-right"> { moneyFmt(summary.overtime_earned) }</th>
      <th class="text-right"> { moneyFmt(summary.overtime_tax) }</th>
      <th class="text-right"> { moneyFmt(summary.total_tax + msummary.total_tax) }</th>
      <th></th>
      <th></th>
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