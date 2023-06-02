<script lang="ts">
  import { MONTHS, CUR_YEARS, CUR_YEAR, CUR_MONTH } from "./utils.js";
  import { onMount } from "svelte";
  import PayrollView from "./lib/PayrollView.svelte";
  import PayrollFilterView from "./lib/PayrollFilterView.svelte";
  import AttendanceView from "./lib/AttendanceView.svelte";
  import SSNITView from "./lib/SSNITView.svelte";
  import PFView from "./lib/PFView.svelte";
  import OvertimeView from "./lib/OvertimeView.svelte";
  import BankView from "./lib/BankView.svelte";
  import ManagementView from "./lib/ManagementView.svelte";
  import GRAView from "./lib/GRAView.svelte";
  import { getPayroll, data } from "./store.js";

  let year = CUR_YEAR;
  let month = CUR_MONTH;
  let views = [
    "Default",
    "Attendance",
    "Advance",
    "Bank",
    "Loan",
    "Management",
    "Pvt Loan",
    "SSNIT",
    "PF",
    "GRA",
    "Overtime",
  ];
  let view = "Default";

  $: payroll = $data.payroll;
  $: management = $data.management;

  onMount(() => {
    getPayroll(CUR_YEAR, CUR_MONTH);
  });

  const yearChanged = () => getMonthlyPayroll(year, month);
  const monthChanged = () => getMonthlyPayroll(year, month);
  const getMonthlyPayroll = (year: number, month: number) => getPayroll(year, month);
</script>

<!-- <header class="border-gray-300 border-b h-10"> -->
<header class="header">
  <nav class="nav">
    <ul>
      <li><strong>GHR</strong></li>
    </ul>
    <ul><li><a href="/">Logout</a></li></ul>
  </nav>
</header>
<main class="container-full pt-4">
  <section class="section">
    <div class="flex flex-col sm:flex-row gap-2 items-baseline">
      <div class="select-combo flex-grow">
        <label for="view"> View </label>
        <select id="view" bind:value={view}>
          {#each views as v}
            <option>{v}</option>
          {/each}
        </select>
      </div>
      <div class="select-combo">
        <label for="month">Month</label>
        <select
          id="month"
          bind:value={month}
          on:change={monthChanged}
          class="mr-2"
        >
          {#each MONTHS as m}
            <option>{m}</option>
          {/each}
        </select>
        <label class="pl-2" for="year">Year</label>
        <select id="year" bind:value={year} on:change={yearChanged}>
          {#each CUR_YEARS as y}
            <option>{y}</option>
          {/each}
        </select>
      </div>
    </div>
  </section>

  {#if payroll.length > 0}
    {#if view === "Attendance"}
      <AttendanceView {payroll} />
    {:else if view === "Advance"}
      <PayrollFilterView {payroll} key={"advance"} header={"Advance"} />
    {:else if view === "Loan"}
      <PayrollFilterView {payroll} key={"loan"} header={"Loan"} />
    {:else if view === "Pvt Loan"}
      <PayrollFilterView {payroll} key={"pvt_loan"} header={"Pvt Loan"} />
    {:else if view === "SSNIT"}
      <SSNITView {payroll} {management} />
    {:else if view === "PF"}
      <PFView {payroll} />
    {:else if view === "Overtime"}
      <OvertimeView {payroll} />
    {:else if view === "Bank"}
      <BankView {payroll} />
    {:else if view === "Management"}
      <ManagementView {management} />
    {:else if view === "GRA"}
      <GRAView {payroll} {management} />
    {:else}
      <PayrollView {payroll} />
    {/if}
  {/if}
</main>

<style lang="postcss">
  :global(html) {
    @apply bg-white;
  }
</style>
