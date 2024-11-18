// import { writable } from "svelte/store";
import { Socket, Presence } from 'phoenix';

let socket = new Socket('/socket', { params: { token: window.userToken } });
socket.connect();

export let channel = socket.channel('ghr:lobby', {});
channel
	.join()
	.receive('ok', (resp: any) => {
		console.log('Joined successfully', resp);
	})
	.receive('error', (resp: any) => {
		console.log('Unable to join', resp);
	});

export const presence = new Presence(channel);

// PAYROLL DATA
// export const data = writable({ payroll: [], management: [] });

// export function getPayroll(year: number, month: number) {
//   const y = year.toString().substring(2, 4);
//   const m = month.toString().length > 1 ? month : "0" + month;
//   channel
//     .push("payroll:get_month", { month: `${y}${m}M` })
//     .receive("ok", (msg) => {
//       console.log(msg);
//       data.set(msg);
//     })
//     .receive("error", (msg) => console.log(msg))
//     .receive("timeout", () => console.log("timeout"));
// }

export default socket;
