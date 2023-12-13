// import io from "socket.io-client";
// import axios from "axios";
// import appStore from "../store/appStore";
// import { getSessionId } from "./sessionSetup";
// const { v4: uuidv4 } = require("uuid");

// const SERVER = "https://ulai.in";
// // const SERVER = "http://localhost:8081";

// var socket = null;

// export const connectWithSocketIOServer = () => {
//   socket = io(SERVER, {
//     path: "/agent-live-chat-socket/",
//   });
//   socket.on("connect", () => {
//     appStore.getState().setIsConnected(true);
//     createOrConnectRoom();
//     console.log("Bot Connected with Server");
//   });
//   socket.on("room-id", (data) => {
//     // const { roomId } = data;
//     // console.log(roomId);
//   });

//   socket.on("room-update", (data) => {
//     // const { connectedUsers } = data;
//     // console.log(connectedUsers);
//   });

//   socket.on("conn-prepare", (data) => {
//     console.log("conn-prepare", data);
//   });
//   socket.on("conn-signal", (data) => {
//     console.log("conn-signal", data);
//   });

//   socket.on("conn-init", (data) => {
//     // const { connUserSocketId } = data;
//     // console.log("conn-init", connUserSocketId);
//   });

//   socket.on("user-disconnected", (data) => {
//     // console.log("Data disconnect", data);
//   });

//   socket.on("message-recieved", (data) => {
//     let newMessage = JSON.parse(data);

//     console.log("OnMessageReceived", newMessage.possibleUserResponses);
//     if (newMessage.identity === "BOT" || newMessage.xidentity === "AGENT") {
//       appStore.getState().messageType(newMessage);
//       appStore.getState().setSuggestions(newMessage.possibleUserResponses);
//       appStore.getState().setShowSuggestions(true);
//     }
//   });
//   socket.on("disconnect", function () {
//     appStore.getState().setIsConnected(false);
//     console.log("client socketio disconnect!");
//   });
// };
// export const getRoomExists = async (roomId) => {
//   // const url = "http://localhost:8081";
//   const url = "https://ulai.in/agent-live-chat/";
//   const response = await axios.get(${url}/api/room-exists/${roomId});
//   return response.data;
// };
// export const createOrConnectRoom = async (identity) => {
//   let roomId = getSessionId(sessionStorage.getItem("sessionUUID"));
//   const data = {
//     identity: "USER",
//     defaultConnection: socket.id,
//     roomId: roomId,
//     organization_id: appStore.getState().botDetails.userId,
//   };
//   if (!data.organization_id) return;
//   if (roomId == undefined || roomId == null || roomId == "null") {
//     data.roomId = uuidv4();
//     localStorage.setItem("connectionId", data.roomId);
//   } else {
//     const resp = await getRoomExists(roomId);
//     if (!resp.roomExists) {
//       socket.emit("create-new-room", data);
//     }
//     appStore.getState().setRoomId(data);
//     socket.emit("join-room", data);
//     return;
//   }
//   appStore.getState().setRoomId(data);
//   console.log(data);
//   socket.emit("create-new-room", data);
// };
// export const joinSession = (roomId) => {
//   const data = {
//     identity: "AGENT",
//     roomId: roomId,
//   };
//   socket.emit("join-room", data);
// };
// export const sendDataToConnectedUser = (data) => {
//   appStore.getState().setShowTyping(true);
//   socket.emit("mssg-sent", data);
// };