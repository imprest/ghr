import tailwindcss from '@tailwindcss/vite';
import { defineConfig } from 'vite';
import { svelte } from '@sveltejs/vite-plugin-svelte';
import path from 'path';

// https://vitejs.dev/config/
export default defineConfig(({ command }: any) => {
	const isDev = command !== 'build';
	if (isDev) {
		// Terminate the watcher when phx quits
		process.stdin.on('close', () => {
			process.exit(0);
		});
		process.stdin.resume();
	}

	return {
		resolve: {
			alias: {
				$model: path.resolve(__dirname, './src/model.svelte'),
				$store: path.resolve(__dirname, './src/store'),
				$lib: path.resolve(__dirname, './src/lib'),
				'$lib/*': path.resolve(__dirname, './src/lib/*'),
				$components: path.resolve(__dirname, './src/lib/components'),
				'$components/*': path.resolve(__dirname, './src/lib/components/*'),
				$ui: path.resolve(__dirname, './src/lib/components/ui'),
				'$ui/*': path.resolve(__dirname, './src/lib/components/ui/*')
			}
		},
		plugins: [tailwindcss(), svelte()],
		build: {
			target: 'esnext',
			minify: true,
			outDir: '../priv/static/assets',
			emptyOutDir: true,
			assetsInlineLimit: 0,
			manifest: false,
			rollupOptions: {
				input: ['src/main.ts', 'src/app.js'],
				output: {
					entryFileNames: '[name].js',
					chunkFileNames: '[name].js',
					assetFileNames: '[name][extname]'
				}
			}
		}
	};
});
