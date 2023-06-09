<script>
  import { moneyFmt } from '$lib/utils'
  import { data } from '$store'

  let key = 'advance'
  let total = 0

  $: payroll = $data.payroll

  $: if (payroll) {
    total = 0
    payroll.forEach(x => {
      if (x[key] == '0.00') return
      total += Number.parseFloat(x[key])
    })
  }
</script>

<table class="table mx-auto is-striped">
  <thead>
    <tr>
      <th>ID</th>
      <th>Name</th>
      <th class='text-center'>{key.toUpperCase()}</th>
    </tr>
  </thead>
  <tbody>
    {#each payroll as p}
    {#if p[key] > 0}
    <tr>
      <td>{p.id  }</td>
      <td>{p.name}</td>
      <td class='text-right'>{moneyFmt(p[key])}</td>
    </tr>
    {/if}
    {/each}
  </tbody>
  <tfoot>
    <tr>
      <th></th>
      <th></th>
      <th class="text-right">{ moneyFmt(total) }</th>
    </tr>
  </tfoot>
</table>