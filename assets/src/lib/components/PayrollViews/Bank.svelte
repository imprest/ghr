<script lang="ts">
  import { moneyFmt } from '$lib/utils'
  import { model } from '../../../model.svelte'

  type Bank = {
    count: number,
    id: string,
    name: string,
    account: string,
    amount: string,
    net_pay: string
  }

  let umb = $derived.by(() => {
    let u : Bank[] = []
    let count  = 0;
    model.payroll.forEach(x => {
      if (x.bank.startsWith('MBG')) {
        u.push({count: count += 1, id: x.id, name: x.name, account: x.bank.substring(11), amount: moneyFmt(Number.parseFloat(x.net_pay)), net_pay: x.net_pay});
      }
    })
    return u;
  })

  let absa = $derived.by(() => {
    let a : Bank[] = []
    let count  = 0;
    model.payroll.forEach(x => {
      if (x.bank.startsWith('BBG')) {
        a.push({count: count += 1, id: x.id, name: x.name, account: x.bank.substring(11), amount: moneyFmt(Number.parseFloat(x.net_pay)), net_pay: x.net_pay});
      }
    })
    return a;
  })

  const sum = (acc: number, x: {net_pay: string}) => acc + Number.parseFloat(x.net_pay);
  let absa_total = $derived.by(() => absa.reduce(sum, 0))
  let umb_total = $derived.by(() => umb.reduce(sum, 0))

</script>

<section class="section">
  <div class="flex flex-col gap-8 lg:flex-row">
    <div class="overflow-x-auto">
      <table class="table mx-auto is-striped">
        <thead>
          <tr>
            <th>ID</th>
            <th>#</th>
            <th>Name</th>
            <th>UMB Account</th>
            <th>Amount GHS</th>
          </tr>
        </thead>
        <tbody>
          {#each umb as p (p.id)}
            <tr>
              <td>                   { p.id      }</td>
              <td class="text-right">{ p.count   }</td>
              <td>                   { p.name    }</td>
              <td class="text-right">{ p.account }</td>
              <td class="text-right">{ p.amount  }</td>
            </tr>
          {/each}
        </tbody>
        <tfoot>
          <tr>
            <th></th>
            <th></th>
            <th></th>
            <th class="text-right">Total: </th>
            <th class="text-right">{ moneyFmt(umb_total) }</th>
          </tr>
        </tfoot>
      </table>
    </div>
    <div>
      <table class="table mx-auto is-striped">
        <thead>
          <tr>
            <th>ID</th>
            <th>#</th>
            <th>Name</th>
            <th>ABSA Account</th>
            <th>Amount GHS</th>
          </tr>
        </thead>
        <tbody>
          {#each absa as p (p.id)}
            <tr>
              <td>                   { p.id      }</td>
              <td class="text-right">{ p.count   }</td>
              <td>                   { p.name    }</td>
              <td class="text-right">{ p.account }</td>
              <td class="text-right">{ p.amount  }</td>
            </tr>
          {/each}
        </tbody>
        <tfoot>
          <tr>
            <th></th>
            <th></th>
            <th></th>
            <th class="text-right">Total: </th>
            <th class="text-right">{ moneyFmt(absa_total) }</th>
          </tr>
        </tfoot>
      </table>
    </div>
  </div>
</section>
