<script>
	import { model } from '../../../model.svelte';
</script>

<table class="table mx-auto is-striped">
	<thead>
		<tr>
			<th>ID</th>
			<th>Name</th>
			<th class="text-center">Days</th>
		</tr>
	</thead>
	<tbody>
		{#each model.payroll as p}
			{#if Number.parseFloat(p.days_worked) !== 27}
				<tr>
					<td>{p.id}</td>
					<td>{p.name}</td>
					<td class="text-right">{p.days_worked}</td>
				</tr>
			{/if}
		{/each}
	</tbody>
</table>
