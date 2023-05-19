/** @type {import('tailwindcss').Config} */
export default {
  content: [
    './src/**/*.{html,js,svelte,ts}',
    '../lib/ghr_web/{components,controllers}/**/*.heex'
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}

