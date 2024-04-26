declare global {
  interface Window {
    _env_ : {
      [key: string]: any;
    }
  }
}

export const URL_BACKEND =
  import.meta.env.URL_BACKEND ??
  window._env_.URL_BACKEND ?? "http://localhost:8080";

