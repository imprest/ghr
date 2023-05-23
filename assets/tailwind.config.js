/** @type {import('tailwindcss').Config} */
const colors = require('tailwindcss/colors')

export default {
  darkMode: 'class',
  content: [
    './src/**/*.{html,js,svelte,ts}',
    '../lib/ghr_web/{components,controllers}/**/*.{heex,ex}'
  ],
  theme: {
    fontFamily: {
      sans: 'Inter, Roboto, Droid Sans, ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Helvetica, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji'
    },
    colors: {
      primary: {
        DEFAULT: 'hsl(200 98% 39%)',
        hover: 'hsl(201 96% 32%)',
        focus: 'hsl(200 98% 39%)',
        active: 'hsl(201 90% 27%)',
        inverse: colors.white
      },
      secondary: {
        DEFAULT: 'hsl(200 98% 39%)',
        hover: 'hsl(201 96% 32%)',
        focus: 'hsl(200 98% 39%)',
        active: 'hsl(201 90% 27%)',
        inverse: colors.white
      },
      transparent: 'transparent',
      current: 'currentColor',
      black: colors.black,
      white: colors.white,
      gray: colors.gray,
      red: colors.red,
      blue: colors.blue,
      emerald: colors.emerald,
      indigo: colors.indigo,
      yellow: colors.yellow,
    },
  },
  plugins: [],
}