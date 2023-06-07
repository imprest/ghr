<script>
  import { onMount } from "svelte";

  export let payroll = []

  let h = 0;
  let headerHeight = 0;
  let sectionHeight = 0;
  onMount(() => {
    headerHeight = document.getElementsByClassName('header')[0].clientHeight;
    sectionHeight = document.getElementsByClassName('section')[0].clientHeight;
  })
</script>

<svelte:window bind:innerHeight={h}/>
<section class="section">
  <div style="height: {h-headerHeight-sectionHeight-40}px" class="overflow-x-auto print:overflow-visible">
    <table class="table mx-auto is-striped">
      <thead>
        <tr>
          <th>ID</th>
          <th>Name</th>
          <th class='text-center'>Days</th>
        </tr>
      </thead>
      <tbody>
        {#each payroll as p}
        {#if p.days_worked != 27}
        <tr>
          <td>{p.id  }</td>
          <td>{p.name}</td>
          <td class='text-right'>{p.days_worked}</td>
        </tr>
        {/if}
        {/each}
      </tbody>
    </table>
  </div>
</section>