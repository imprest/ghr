<script>
  import { moneyFmt } from '$lib/utils'
  import { model } from '../../../model.svelte';

  let payroll = $derived(model.payroll)
  let summary = $derived.by(() => {
      let summary = {
        overtime_earned: 0,
        overtime_tax: 0
      }
      payroll.forEach(x => {
        summary.overtime_earned += Number.parseFloat(x.overtime_earned)
        summary.overtime_tax    += Number.parseFloat(x.overtime_tax)
      })
    return summary
  })
</script>

<table class="table mx-auto is-striped">
  <thead>
    <tr>
      <th>ID</th>
      <th>Name</th>
      <th>Overtime    </th>
      <th>Overtime Tax</th>
    </tr>
  </thead>
  <tbody>
    {#each payroll as p}
    {#if Number.parseFloat(p.overtime_earned) > 0}
      <tr>
        <td>                   { p.id              }</td>
        <td>                   { p.name            }</td>
        <td class="text-right">{ moneyFmt(p.overtime_earned) }</td>
        <td class="text-right">{ moneyFmt(p.overtime_tax   ) }</td>
      </tr>
    {/if}
    {/each}
  </tbody>
  <tfoot>
    <tr>
      <th></th>
      <th></th>
      <th class="text-right">{ moneyFmt(summary.overtime_earned) }</th>
      <th class="text-right">{ moneyFmt(summary.overtime_tax   ) }</th>
    </tr>
  </tfoot>
</table>
