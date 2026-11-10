# Materiales de apoyo — Fundamentos de Git y GitHub

Carpetas con el contenido de los repositorios que se usan en el curso.
**No** son repositorios Git: son el material de referencia para construir el
historial de commits durante la grabación.

## Estructura

| Carpeta | Qué es | Módulos |
|---|---|---|
| `fundamentos-git-github/` | Proyecto principal (Portafolio ASCII) | 4, 7, 8, 10, 12 |
| `proyecto-inicial/` | Dataset con historial rico y rama fusionada | 4, 7, 11 |
| `repositorio-ejemplo/` | Repo público de demostración (`git clone`) | 8.3, 8.4 |
| `proyecto-contaminado/` | Proyecto con archivos que NO deben versionarse | 5.1 |

## Cómo se usa

Durante la grabación, cada carpeta se convierte en un repositorio con `git init`
y se van creando los commits **en el orden indicado abajo**. El contenido de cada
carpeta es el **estado final**; los commits intermedios se arman añadiendo las
secciones paso a paso.

---

## `fundamentos-git-github` — secuencia de commits

| # | Mensaje | Qué añade |
|---|---|---|
| 1 | Crear estructura base del proyecto | `index.html`, `estilos.css`, `.gitignore` |
| 2 | Crear README inicial | `README.md` (título + arte ASCII) |
| 3 | Añadir título y descripción del portafolio | párrafo de bienvenida |
| 4 | Añadir sección de perfil | sección "Sobre mí" |
| 5 | Añadir lista de proyectos | sección "Proyectos" |
| 6 | Añadir datos de contacto | sección "Contacto" + `contacto.md` |

---

## `proyecto-inicial` — secuencia de commits

Dos autores simulados: **Ana** y **Luis**.

| # | Mensaje | Autor | Qué añade |
|---|---|---|---|
| 1 | Commit inicial | Ana | `index.html`, `estilos.css`, `notas.txt` |
| 2 | Añadir estilos base | Ana | estilos de header/footer en `estilos.css` |
| 3 | Crear README inicial | Ana | `README.md` (título) |
| 4 | Añadir título y descripción del portafolio | Luis | párrafo de descripción |
| 5 | Añadir sección de perfil | Luis | sección "Sobre mí" |
| 6 | Añadir lista de proyectos | Ana | sección "Proyectos" |
| 7 | Añadir datos de contacto | Luis | sección "Contacto" |
| 8 | Añadir encabezado a la página | Luis | `<header>` en `index.html` (en rama `feature-header`) |
| 9 | Merge branch 'feature-header' | Luis | fusión a `main` |

> El commit 8 se hace en una rama `feature-header` (creada desde el 7) y luego se
> fusiona a `main` con `git merge --no-ff` para dejar un **merge commit** en el historial.

---

## `repositorio-ejemplo` — secuencia de commits

| # | Mensaje | Qué añade |
|---|---|---|
| 1 | Commit inicial | `app.js` |
| 2 | Añadir README con instrucciones | `README.md` |
| 3 | Añadir LICENSE | `LICENSE` |

---

## `proyecto-contaminado` — sin commits

Esta carpeta **no** es un repositorio. Se entrega al alumno como **ZIP**.
El alumno hace `git init` y crea un `.gitignore` que excluya:

```
node_modules/
dist/
*.log
.env
.DS_Store
```

## Nota

Los hashes de los commits los genera Git en cada máquina, por lo que **no
coinciden** con los que aparecen en el guion (`8f3a9c2`, etc.), que son
ilustrativos. Lo importante es respetar los **mensajes** y el **orden**.
