import { defineConfig } from "vite";
import angular from "@analogjs/vite-plugin-angular";
import { dependencies } from "./package.json";

// npm install vite @analogjs/vite-plugin-angular --save-dev

// Este plugin reemplaza un marcador de posición en index.html con un script que contiene las variables de entorno.
const replacePlugin = (mode) => {
    return {
      name: 'html-inject-env',
      transformIndexHtml: (html) => {
        if (mode === 'production') {
          return html.replace(
            '<!-- ANGULAR_ENV -->',
            '<script src="./config/front.env.js"></script>'
          );
        }
        return null;
      },
    };
  };

// Esta función se puede utilizar para cargar las variables de entorno.
// Puedes especificar un prefijo o dejarlo vacío para cargar todas las variables.
function loadEnvironmentVariables(mode, prefix = '') {
  return loadEnv(mode, process.cwd(), prefix);
}

// Función para generar chunks basados en las dependencias
function renderChunks(deps) {
  let chunks = {};
  Object.keys(deps).forEach((key) => {
    if (["angular"].includes(key)) return; // Excluir 'angular' como ejemplo
    chunks[key] = [key];
  });
  return chunks;
}

export default defineConfig(({ mode }) => {
  // Carga las variables de entorno utilizando la función anterior.
  const env = loadEnvironmentVariables(mode);

  return {
    resolve: {
      mainFields: ["module"],
    },
    plugins: [
        angular(),
        replacePlugin(mode),
    ],
    /*server: {
      port: 4200,
    },*/
    test: {
      globals: true,
      environment: "jsdom",
      setupFiles: ["src/test-setup.ts"],
      include: ["**/*.spec.ts"],
      reporters: ["default"],
      coverage: {
        provider: "v8",
      },
    },
    define: {
      // Define las variables globales aquí.
      "import.meta.vitest": mode !== "production",
      // Utiliza las variables de entorno cargadas.
      __APP_ENV__: JSON.stringify(env.APP_ENV),
    },
    build: {
      sourcemap: false,
      rollupOptions: {
        output: {
          manualChunks: {
            vendor: [],
            ...renderChunks(dependencies),
          },
        },
      },
    },
  };
});
