import { Socket, Presence } from "phoenix"

let socket = new Socket("/socket", { params: { token: window.userToken } })
socket.connect()

export let channel = socket.channel("ghr:lobby", {})
channel.join()
  .receive("ok", (resp: any) => {
    console.log("Joined successfully", resp)
  })
  .receive("error", (resp: any) => { console.log("Unable to join", resp) })

export const presence = new Presence(channel);

export default socket