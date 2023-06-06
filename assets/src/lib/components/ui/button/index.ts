import { cva } from "class-variance-authority";

export { default as Button } from "./Button.svelte";

export const buttonVariants = cva(
	"appearance-none content-center items-center inline-flex mb-1 font-semibold shadow-sm rounded-sm cursor-pointer \
	transition-colors focus-visible:outline-none focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring \
	focus-visible:ring-offset-2 disabled:opacity-50 disabled:pointer-events-none ring-offset-background \
	",
	{
		variants: {
			variant: {
				default:
					"bg-primary text-primary-foreground hover:bg-primary-hover hover:ring-primary-focus \
					focus-visible:ring-primary-focus focus-visible:bg-primary-hover active:bg-primary-active",
				destructive:
					"bg-destructive text-destructive-foreground hover:bg-destructive/90",
				error:
					"bg-error text-error-foreground hover:bg-error/90",
				outline:
					"border border-input hover:bg-accent hover:text-accent-foreground",
				secondary:
					"bg-secondary text-secondary-foreground hover:bg-secondary/80",
				ghost: "hover:bg-accent hover:text-accent-foreground",
				link: "underline-offset-4 hover:underline text-primary"
			},
			size: {
				default: "py-1 px-4",
				sm: "h-9 px-3",
				lg: "h-11 px-8"
			}
		},
		defaultVariants: {
			variant: "default",
			size: "default"
		}
	}
);
