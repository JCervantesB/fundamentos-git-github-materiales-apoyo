# Material de apoyo para el alumno — Fundamentos de Git y GitHub

Este material genera los repositorios que el alumno **clona o descarga** durante el
curso, según el `guion.md`.

## Qué hay aquí

| Archivo | Descripción |
|---|---|
| `construir-repos.sh` | Script que crea los repositorios con su historial de commits. **Fuente única de verdad** del contenido. |
| `.gitignore` | Ignora `salida/` (los repos generados se publican aparte). |
| `salida/` | Carpeta generada al ejecutar el script (ignorada por git, no se sube). |

## Repositorios que se generan

| Repositorio | Entrega al alumno | Módulos |
|---|---|---|
| `fundamentos-git-github` | `git clone` | 4, 7, 8, 10, 12 |
| `proyecto-inicial` | `git clone` | 4, 7, 11 (reflog/reset) |
| `repositorio-ejemplo` | `git clone` | 8.3, 8.4 |
| `proyecto-contaminado.zip` | **ZIP (sin git)** | 5.1 |

## Cómo generar los repositorios

1. Abre **Git Bash** en esta carpeta.
2. Ejecuta:
   ```bash
   ./construir-repos.sh
   ```
   Esto crea `salida/` con los tres repos Git y la carpeta `proyecto-contaminado`
   (además intenta crear el ZIP si tienes `zip` instalado).
3. Para elegir otra carpeta de salida:
   ```bash
   ./construir-repos.sh C:/ruta/a/mi/salida
   ```

## Cómo publicar en GitHub

Hay **dos niveles** de publicación:

### 1. Este repositorio (materiales de apoyo)

Lleva solo la "fuente": `construir-repos.sh`, `README.md` y `.gitignore`.
La carpeta `salida/` está **ignorada** (se regenera con el script) y **no** se sube.

```bash
git init -b main
git add construir-repos.sh README.md .gitignore
git commit -m "Añadir material de apoyo del curso"
git remote add origin https://github.com/JCervantesB/fundamentos-git-github-materiales-apoyo.git
git push -u origin main
```

### 2. Cada repositorio generado, en su propio repo de GitHub

Para `fundamentos-git-github`, `proyecto-inicial` y `repositorio-ejemplo`:

1. Crea el repo vacío en GitHub **sin** marcar "Add a README".
2. Añade el remoto y sube:
   ```bash
   cd salida/fundamentos-git-github
   git remote add origin https://github.com/<org>/fundamentos-git-github.git
   git push -u origin main
   ```

El `proyecto-contaminado` **no** se publica como repo: se entrega como ZIP.
Adjunta `salida/proyecto-contaminado.zip` como **asset de un Release** en este
repositorio (o enlázalo desde el README del curso).

## Nota sobre los hashes

Los hashes de los commits los genera Git en cada construcción, por lo que **no
coinciden** con los que aparecen en el guion (`8f3a9c2`, `b5d4e1f`, etc.), que son
ilustrativos. Lo que sí se respeta exactamente son los **mensajes de commit** y el
**orden** de los cambios.

## Personalización rápida

- **Nombre/autor de los commits:** edita `INSTRUCTOR_NAME` / `INSTRUCTOR_EMAIL`
  al inicio del script.
- **Autores del dataset:** edita `ANA` / `LUIS` y sus correos.
- **Fechas:** el script usa `date -d "N days ago"`. En macOS, sustituye la función
  `dia()` por `date -v-Nd`.
