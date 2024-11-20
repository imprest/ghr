<script lang="ts">
	import { moneyFmt, compareValues } from '$lib/utils';
	import { model } from '../../../model.svelte';
	import SortIcon from '../sort-icon.svelte';

	let summary = $derived.by(() => {
		let s: any = {
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
		// For each payroll item, aggregate the data into summary object
		model.payroll.data.forEach((x: any) => {
			Object.keys(s).forEach((k) => {
				s[k] += Number.parseFloat(x[k]);
			});
		});
		return s;
	});

	let key = $derived(model.payroll.sortBy);
	let sort = $derived(model.payroll.sortOrder);

	let sortedPayroll = $derived.by(() => {
		return model.payroll.data.toSorted(compareValues(key, sort));
	});

	function sortBy(key: string) {
		model.payroll.sortBy = key;
		model.payroll.sortOrder = sort === 'asc' ? 'desc' : 'asc';
	}

	let offsetWidth = $state(0);

	$effect(() => {
		const width = document.getElementsByTagName('td')[0];
		offsetWidth = width?.offsetWidth || 40;
	});
</script>

<table class="table is-striped is-bordered is-hoverable is-sticky">
	<thead>
		<tr>
			<th class="text-center" onclick={() => sortBy('id')}
				><div>
					ID{#if key === 'id'}<SortIcon {sort} />{/if}
				</div></th
			>
			<th style="inset-inline-start: {offsetWidth}px" onclick={() => sortBy('name')}
				><div>
					Name{#if key === 'name'}<SortIcon {sort} />{/if}
				</div></th
			>
			<th class="text-center" onclick={() => sortBy('days_worked')}
				><div>
					Days{#if key === 'days_worked'}<SortIcon {sort} />{/if}
				</div></th
			>
			<th class="text-center"><div>Basic Salary</div></th>
			<th class="text-center"><div>Earned Salary</div></th>
			<th class="text-center"><div>SSNIT</div></th>
			<th class="text-center"><div>PF</div></th>
			<th class="text-center"><div>Cash Allow.</div></th>
			<th class="text-center"><div>Total Income</div></th>
			<th class="text-center"><div>Total Relief</div></th>
			<th class="text-center"><div>Taxable Income</div></th>
			<th class="text-center"><div>Tax Ded.</div></th>
			<th class="text-center"><div>Overtime</div></th>
			<th class="text-center"><div>Overtime Tax</div></th>
			<th class="text-center"><div>Total Tax</div></th>
			<th class="text-center"><div>TUC Ded.</div></th>
			<th class="text-center"><div>Advance</div></th>
			<th class="text-center"><div>Loan</div></th>
			<th class="text-center"><div>Welfare Ded.</div></th>
			<th class="text-center"><div>Pvt Loan</div></th>
			<th class="text-center"><div>Total Ded.</div></th>
			<th class="text-center"><div>Total Pay</div></th>
			<th class="text-center"><div>Net Pay</div></th>
		</tr>
	</thead>
	<tbody>
		{#each sortedPayroll as p, i}
			<tr class="group/item {p.net_pay != p.total_pay ? 'text-danger font-semibold' : ''}">
				<td
					class="group-hover/item:bg-highlight text-center {i % 2 == 0
						? 'bg-white'
						: 'bg-even-row'}">{p.id}</td
				>
				<td
					style="inset-inline-start: {offsetWidth}px"
					class="group-hover/item:bg-highlight {i % 2 == 0 ? 'bg-white' : 'bg-even-row'}"
					>{p.name}</td
				>
				<td class="text-center">{moneyFmt(p.days_worked)}</td>
				<td class="text-right"> {moneyFmt(p.base_salary)}</td>
				<td class="text-right"> {moneyFmt(p.earned_salary)}</td>
				<td class="text-right"> {moneyFmt(p.ssnit_amount)}</td>
				<td class="text-right"> {moneyFmt(p.pf_amount)}</td>
				<td class="text-right"> {moneyFmt(p.cash_allowance)}</td>
				<td class="text-right"> {moneyFmt(p.total_cash)}</td>
				<td class="text-right"> {moneyFmt(p.total_relief)}</td>
				<td class="text-right"> {moneyFmt(p.taxable_income)}</td>
				<td class="text-right"> {moneyFmt(p.tax_ded)}</td>
				<td class="text-right"> {moneyFmt(p.overtime_earned)}</td>
				<td class="text-right"> {moneyFmt(p.overtime_tax)}</td>
				<td class="text-right"> {moneyFmt(p.total_tax)}</td>
				<td class="text-right"> {moneyFmt(p.tuc_amount)}</td>
				<td class="text-right"> {moneyFmt(p.advance)}</td>
				<td class="text-right"> {moneyFmt(p.loan)}</td>
				<td class="text-right"> {moneyFmt(p.staff_welfare_ded)}</td>
				<td class="text-right"> {moneyFmt(p.pvt_loan)}</td>
				<td class="text-right"> {moneyFmt(p.total_ded)}</td>
				<td class="text-right"> {moneyFmt(p.total_pay)}</td>
				<td class="text-right"> {moneyFmt(p.net_pay)}</td>
			</tr>
		{/each}
	</tbody>
	<tfoot>
		<tr>
			<th></th>
			<th class="text-right">Total:</th>
			<th class="text-center">{moneyFmt(summary.days_worked)}</th>
			<th class="text-right"> {moneyFmt(summary.base_salary)}</th>
			<th class="text-right"> {moneyFmt(summary.earned_salary)}</th>
			<th class="text-right"> {moneyFmt(summary.ssnit_amount)}</th>
			<th class="text-right"> {moneyFmt(summary.pf_amount)}</th>
			<th class="text-right"> {moneyFmt(summary.cash_allowance)}</th>
			<th class="text-right"> {moneyFmt(summary.total_cash)}</th>
			<th class="text-right"> {moneyFmt(summary.total_relief)}</th>
			<th class="text-right"> {moneyFmt(summary.taxable_income)}</th>
			<th class="text-right"> {moneyFmt(summary.tax_ded)}</th>
			<th class="text-right"> {moneyFmt(summary.overtime_earned)}</th>
			<th class="text-right"> {moneyFmt(summary.overtime_tax)}</th>
			<th class="text-right"> {moneyFmt(summary.total_tax)}</th>
			<th class="text-right"> {moneyFmt(summary.tuc_amount)}</th>
			<th class="text-right"> {moneyFmt(summary.advance)}</th>
			<th class="text-right"> {moneyFmt(summary.loan)}</th>
			<th class="text-right"> {moneyFmt(summary.staff_welfare_ded)}</th>
			<th class="text-right"> {moneyFmt(summary.pvt_loan)}</th>
			<th class="text-right"> {moneyFmt(summary.total_ded)}</th>
			<th class="text-right"> {moneyFmt(summary.total_pay)}</th>
			<th></th>
		</tr>
	</tfoot>
</table>
