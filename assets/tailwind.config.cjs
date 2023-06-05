const colors = require('tailwindcss/colors');
const { fontFamily } = require("tailwindcss/defaultTheme");

/** @type {import('tailwindcss').Config} */
module.exports = {
  darkMode: ["class"],
  content: [
    './src/**/*.{html,js,svelte,ts}',
    '../lib/ghr_web/{components,controllers}/**/*.{heex,ex}'
  ],
  theme: {
    container: {
      center: true,
      padding: "2rem",
      screens:{
        "2xl": "1400px"
      }
    },
    extend: {
      colors: {
        border: "hsl(var(--border))",
        input: "hsl(var(--input))",
        ring: "hsl(var(--ring))",
        background: "hsl(var(--background))",
        foreground: "hsl(var(--foreground))",
        transparent: 'transparent',
        current: 'currentColor',
        primary: {
          DEFAULT: "hsl(var(--primary))",
          foreground: "hsl(var(--primary-foreground))",
          hover: 'hsl(var(--primary-hover))',
          focus: 'hsl(var(--primary-focus))',
          active: 'hsl(var(--primary-active))',
          inverse: 'hsl(var(--primary-inverse))'
        },
        secondary: {
          DEFAULT: "hsl(var(--secondary))",
          foreground: "hsl(var(--secondary-foreground))",
          hover: 'hsl(var(--secondary-hover))',
          focus: 'hsl(var(--secondary-focus))',
          active: 'hsl(var(--secondary-active))',
          inverse: 'hsl(var(--secondary-inverse))'
        },
        destructive: {
          DEFAULT: "hsl(var(--destructive))",
          foreground: "hsl(var(--destructive-foreground))"
        },
        muted: {
          DEFAULT: "hsl(var(--muted))",
          foreground: "hsl(var(--muted-foreground))"
        },
        accent: {
          DEFAULT: "hsl(var(--accent))",
          foreground: "hsl(var(--accent-foreground))"
        },
        popover: {
          DEFAULT: "hsl(var(--popover))",
          foreground: "hsl(var(--popover-foreground))"
        },
        card: {
          DEFAULT: "hsl(var(--card))",
          foreground: "hsl(var(--card-foreground))"
        }
      },
      borderRadius: {
        lg: "var(--radius)",
        md: "calc(var(--radius) - 2px)",
        sm: "calc(var(--radius) - 4px)"
      },
      fontFamily: {
        sans: ["Inter", "Roboto", "Droid Sans",...fontFamily.sans]
      }
    },
  },
  plugins: [require("tailwindcss-animate")],
};
