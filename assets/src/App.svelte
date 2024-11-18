<script lang="ts">
	import { onMount, setContext } from 'svelte';
	import PayrollViews from '$lib/components/PayrollViews.svelte';
	import { model } from './model.svelte';
	import { channel } from './store';

	let view = $state('Default');
	let views = [
		'Default',
		'Attendance',
		'Advance',
		'Bank',
		'Loan',
		'Management',
		'Pvt Loan',
		'SSNIT',
		'PF',
		'GRA',
		'Overtime'
	];

	type ApiGetMonthlyPayroll = {
		type: 'ApiGetMonthlyPayroll';
		data: { year: number; month: number };
	};
	type ApiGotMonthlyPayroll = {
		type: 'ApiGotMonthlyPayroll';
		data: { error: string | undefined; result: { payroll: any; management: any } };
	};

	type Msg = ApiGetMonthlyPayroll | ApiGotMonthlyPayroll;

	// UPDATE LOOP i.e. Take MSG -> Update Model and/or generate side_effect
	setContext('update', { update });
	function update(msg: Msg): void {
		if (msg.type === 'ApiGetMonthlyPayroll') {
			model.status = 'loading';
			const data = msg.data;
			apiGetMonthlyPayroll(data.year, data.month);
		} else if (msg.type === 'ApiGotMonthlyPayroll') {
			const data = msg.data;
			if (data.error) {
				model.status = 'error';
				model.error_msg = data.error;
				return;
			} else {
				const result = data.result;
				model.status = 'loaded';
				model.payroll = result.payroll;
				model.management = result.management;
				return;
			}
		}
	}

	// INIT
	onMount(() => {
		update({
			type: 'ApiGetMonthlyPayroll',
			data: { year: model.year, month: model.month }
		});
	});

	// UI ACTION -> MSG
	const yearChanged = () =>
		update({ type: 'ApiGetMonthlyPayroll', data: { year: model.year, month: model.month } });
	const monthChanged = () =>
		update({ type: 'ApiGetMonthlyPayroll', data: { year: model.year, month: model.month } });

	function apiGetMonthlyPayroll(year: number, month: number) {
		const y = year.toString().substring(2, 4);
		const m = month.toString().length > 1 ? month : '0' + month;
		channel
			.push('payroll:get_month', { month: `${y}${m}M` })
			.receive('ok', (msg) => {
				update({ type: 'ApiGotMonthlyPayroll', data: { result: msg, error: undefined } });
			})
			.receive('error', (msg) =>
				update({
					type: 'ApiGotMonthlyPayroll',
					data: { result: { payroll: [], management: [] }, error: msg }
				})
			)
			.receive('timeout', () =>
				update({
					type: 'ApiGotMonthlyPayroll',
					data: { result: { payroll: [], management: [] }, error: 'timedout' }
				})
			);
	}
</script>

<header class="header">
	<nav class="nav">
		<ul>
			<li><strong>GHR</strong></li>
		</ul>
		<ul><li><a href="/">Logout</a></li></ul>
	</nav>
</header>
<main class="pt-4">
	<!-- <section class="section"> -->
	<!--   <form class="flex gap-2 flex-wrap items-end justify-center"> -->
	<!--     <label for="name" class="flex flex-col grow md:grow-0 basis-32"> -->
	<!--       Name: -->
	<!--       <input id="name" type="text" class="" placeholder="Maria"> -->
	<!--     </label> -->
	<!--     <label for="email" class="flex flex-col grow-[3] md:grow-0 basis-44"> -->
	<!--       Email: -->
	<!--       <input id="email" type="email" class="" placeholder="Maria2591@aol.com"> -->
	<!--     </label> -->
	<!--     <button class="btn grow basis-20 md:grow-0">Submit</button> -->
	<!--   </form> -->
	<!-- </section> -->
	<section class="section mx-auto">
		<div class="flex flex-col sm:flex-row gap-2 items-baseline">
			<div class="select-combo grow">
				<label for="view"> View </label>
				<select id="view" bind:value={view}>
					{#each views as v}
						<option>{v}</option>
					{/each}
				</select>
			</div>
			<button class="btn">{model.status}</button>
			<button class="btn btn-primary">{model.status}</button>
			<button class="btn btn-danger">{model.status}</button>
			<div class="select-combo">
				<label for="month">Month</label>
				<select id="month" bind:value={model.month} onchange={monthChanged} class="mr-2">
					{#each model.months as m}
						<option>{m}</option>
					{/each}
				</select>
				<label class="pl-2" for="year">Year</label>
				<select id="year" bind:value={model.year} onchange={yearChanged}>
					{#each model.years as y}
						<option>{y}</option>
					{/each}
				</select>
			</div>
		</div>
	</section>

	{#if model.payroll.length > 0}
		<PayrollViews {view} />
	{:else}
		<section class="section-full"><p>No Data for this month.</p></section>
	{/if}
</main>
