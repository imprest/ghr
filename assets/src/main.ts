import "./app.css";
import "phoenix_html";
import App from "./App.svelte";

const app = new App({
  target: document.getElementById("app"),
});

export default app;
