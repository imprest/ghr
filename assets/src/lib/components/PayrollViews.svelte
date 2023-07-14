<script lang="ts">
  import { onMount } from "svelte";
  import Default from "./PayrollViews/Default.svelte";
  import Attendance from "./PayrollViews/Attendance.svelte";
  import Filter from "./PayrollViews/Filter.svelte";
  import Bank from "./PayrollViews/Bank.svelte";
  import Management from "./PayrollViews/Management.svelte";
  import Overtime from "./PayrollViews/Overtime.svelte";
  import PF from "./PayrollViews/PF.svelte";
  import SSNIT from "./PayrollViews/SSNIT.svelte";
  import GRA from "./PayrollViews/GRA.svelte";

  export let view = "Default";

  let h = 0;
  let headerHeight = 0;
  let sectionHeight = 0;

  onMount(() => {
    headerHeight = document.getElementsByClassName("header")[0].clientHeight;
    sectionHeight = document.getElementsByClassName("section")[0].clientHeight;
  });

  $: tableHeight = `${h - headerHeight - sectionHeight - 40}px`;
</script>

<svelte:window bind:innerHeight={h} />
<section class="section-full">
  <div
    style:height={tableHeight}
    class="overflow-x-auto print:overflow-visible"
  >
    {#if view === "Attendance"}
      <Attendance />
    {:else if view === "Advance"}
      <Filter key={"advance"} />
    {:else if view === "Bank"}
      <Bank />
    {:else if view === "Loan"}
      <Filter key={"loan"} />
    {:else if view === "GRA"}
      <GRA />
    {:else if view === "Management"}
      <Management />
    {:else if view === "Pvt Loan"}
      <Filter key={"pvt_loan"} />
    {:else if view === "Overtime"}
      <Overtime />
    {:else if view === "PF"}
      <PF />
    {:else if view === "SSNIT"}
      <SSNIT />
    {:else}
      <Default />
    {/if}
  </div>
</section>
