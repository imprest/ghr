<script lang="ts">
  import Default from "./PayrollViews/Default.svelte";
  import Advance from "./PayrollViews/Advance.svelte";
  import Attendance from "./PayrollViews/Attendance.svelte";
  import { onMount } from "svelte";

  export let view = "Default";

  let h = 0;
  let headerHeight = 0;
  let sectionHeight = 0;

  onMount(() => {
    headerHeight = document.getElementsByClassName('header')[0].clientHeight;
    sectionHeight = document.getElementsByClassName('section')[0].clientHeight;
  })

  $: tableHeight = `${(h - headerHeight - sectionHeight - 40)}px`;
</script>

<svelte:window bind:innerHeight={h}/>
<section class="section-full">
  <div style:height={tableHeight} class="overflow-x-auto print:overflow-visible">
  {#if view === "Attendance"}
    <Attendance />
  {:else if view === "Advance"}
    <Advance />
  {:else}
    <Default />
  {/if}
  </div>
</section>