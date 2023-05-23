<script lang="ts">
  import Counter from './lib/Counter.svelte'
</script>

<main class="container">
  <hgroup>
    <h1>Heading 2</h1>
    <h2>Subtitle for heading 2</h2>
  </hgroup>
  <progress></progress>
  <h1>Heading 1</h1>
  <h2>Heading 2</h2>
  <h3>Heading 3</h3>
  <h4>Heading 4</h4>
  <h5>Heading 5</h5>
  <h6>Heading 6</h6>

  <div class="card">
    <Counter />
  </div>

</main>

<style lang="postcss">
  :global(html) {
    background-color: theme(colors.gray.50);
  }
</style>
