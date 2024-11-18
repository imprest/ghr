<script lang="ts">
	import { moneyFmt } from '$lib/utils';
	import { model } from '../../../model.svelte';

	interface Props {
		key: string;
	}

	let { key = 'advance' }: Props = $props();

	let header = $derived(key.charAt(0).toUpperCase() + key.slice(1));
	let payroll = $derived(model.payroll);

	let total = $derived.by(() => {
		if (payroll) {
			let t = 0;
			payroll.forEach((x: any) => {
				if (x[key] == '0.00') return;
				t += Number.parseFloat(x[key]);
			});
			return t;
		} else return 0;
	});
</script>

<table class="table mx-auto is-striped">
	<thead>
		<tr>
			<th>ID</th>
			<th>Name</th>
			<th class="text-right">{header}</th>
		</tr>
	</thead>
	<tbody>
		{#each payroll as p}
			{#if Number.parseFloat(p[key]) > 0}
				<tr>
					<td>{p.id}</td>
					<td>{p.name}</td>
					<td class="text-right">{moneyFmt(p[key])}</td>
				</tr>
			{/if}
		{/each}
	</tbody>
	<tfoot>
		<tr>
			<th></th>
			<th></th>
			<th class="text-right">{moneyFmt(total)}</th>
		</tr>
	</tfoot>
</table>
