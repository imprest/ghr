<script lang="ts">
	import { moneyFmt } from '$lib/utils';
	import { model } from '../../../model.svelte';

	type PF = {
		id: string;
		name: string;
		earned_salary: string;
		pf_no: string;
		pf_amount: number;
		pf_emp_contrib: number;
		pf_total: number;
	};

	let payroll = $derived(model.payroll);

	let pf = $derived.by(() => {
		let p: PF[] = [];
		let t_pf_amount = 0;

		payroll.data.forEach((x) => {
			if (x.pf_amount == '0.00') return;
			t_pf_amount = Number.parseFloat(x.pf_amount);
			let pf_emp_contrib = +(Math.round(0.25 * Number.parseFloat(x.pf_amount + 'e+2')) + 'e-2');
			let pf_total = pf_emp_contrib + t_pf_amount;

			p.push({
				pf_emp_contrib: pf_emp_contrib,
				pf_total: pf_total,
				pf_amount: t_pf_amount,
				id: x.id,
				name: x.name,
				pf_no: x.pf_no,
				earned_salary: x.earned_salary
			});
		});

		return p;
	});

	let summary = $derived.by(() => {
		let s = {
			earned_salary: 0,
			pf_amount: 0,
			pf_emp_contrib: 0,
			pf_total: 0
		};
		pf.forEach((x) => {
			s.earned_salary += Number.parseFloat(x.earned_salary);
			s.pf_amount += x.pf_amount;
			s.pf_emp_contrib += x.pf_emp_contrib;
			s.pf_total += x.pf_total;
		});
		return s;
	});
</script>

<table class="table mx-auto is-striped is-hoverable">
	<thead>
		<tr>
			<th>ID</th>
			<th>Fund ID</th>
			<th>Name</th>
			<th>Earned Income</th>
			<th>PF Employee (8%)</th>
			<th>PF Employer (2%)</th>
			<th>Total (10%) </th>
		</tr>
	</thead>
	<tbody>
		{#each pf as p (p.id)}
			<tr>
				<td> {p.id}</td>
				<td> {p.pf_no}</td>
				<td> {p.name}</td>
				<td class="text-right">{moneyFmt(Number.parseFloat(p.earned_salary))}</td>
				<td class="text-right">{moneyFmt(p.pf_amount)}</td>
				<td class="text-right">{moneyFmt(p.pf_emp_contrib)}</td>
				<td class="text-right">{moneyFmt(p.pf_total)}</td>
			</tr>
		{/each}
	</tbody>
	<tfoot>
		<tr>
			<th></th>
			<th></th>
			<th></th>
			<th class="text-right">{moneyFmt(summary.earned_salary)}</th>
			<th class="text-right">{moneyFmt(summary.pf_amount)}</th>
			<th class="text-right">{moneyFmt(summary.pf_emp_contrib)}</th>
			<th class="text-right">{moneyFmt(summary.pf_total)}</th>
		</tr>
	</tfoot>
</table>
