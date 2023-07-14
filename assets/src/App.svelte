<script lang="ts">
  import { MONTHS, CUR_YEARS, CUR_YEAR, CUR_MONTH } from "$lib/utils";
  import { onMount } from "svelte";
  import PayrollViews from "$lib/components/PayrollViews.svelte";
  import { getPayroll, data } from "./store";

  let year = CUR_YEAR;
  let month = CUR_MONTH;
  let view = "Default";
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

  onMount(() => {
    getPayroll(CUR_YEAR, 5); // CUR_MONTH ); // TODO reset
  });

  const yearChanged = () => getMonthlyPayroll(year, month);
  const monthChanged = () => getMonthlyPayroll(year, month);
  const getMonthlyPayroll = (year: number, month: number) =>
    getPayroll(year, month);
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
<main class="pt-4">
  <section class="section">
    <div class="flex flex-col sm:flex-row gap-2 items-baseline">
      <button>Test</button>
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

  {#if $data.payroll.length > 0}
    <PayrollViews {view} />
  {:else}
    <div>No Data for this month.</div>
  {/if}
</main>
