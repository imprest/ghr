// Ensure this is treated as a module
export = {};
declare global {
  interface Window {
    userToken?: any;
  }
  interface document {}
}

declare module "phoenix";
