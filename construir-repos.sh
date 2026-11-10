#!/usr/bin/env bash
# =============================================================================
# Material de apoyo — Fundamentos de Git y GitHub
# Genera los repositorios que el alumno clona/descarga durante el curso.
#
# Requisitos : Git instalado (en Windows, ejecutar desde Git Bash).
# Uso        : ./construir-repos.sh [carpeta-de-salida]
#              (por defecto crea ./salida)
#
# Resultado  :
#   salida/fundamentos-git-github/   -> repo con historial preparado (Portafolio ASCII)
#   salida/proyecto-inicial/         -> dataset con historial rico + rama fusionada
#   salida/repositorio-ejemplo/      -> repo público de demostración (para git clone)
#   salida/proyecto-contaminado/     -> carpeta SIN git (el alumno hace git init)
#   salida/proyecto-contaminado.zip  -> ZIP de entrega del contaminado
# =============================================================================
set -euo pipefail

# --- Carpeta de salida (se resuelve a ruta absoluta) -------------------------
SALIDA="${1:-salida}"
mkdir -p "$SALIDA"
SALIDA="$(cd "$SALIDA" && pwd)"

# --- Utilidades --------------------------------------------------------------
# Fecha en días hacia atrás (formato ISO). En macOS usar `date -v-<n>d`.
dia() {
  if fecha=$(date -d "$1 days ago" +"%Y-%m-%dT12:00:00" 2>/dev/null); then
    echo "$fecha"
  else
    date +"%Y-%m-%dT12:00:00"
  fi
}

# commit <repo> <mensaje> <días_atrás> <autor_nombre> <autor_email>
commit() {
  local repo="$1" msg="$2" d="$3" name="$4" email="$5"
  local fecha; fecha="$(dia "$d")"
  GIT_AUTHOR_NAME="$name" GIT_AUTHOR_EMAIL="$email" \
  GIT_COMMITTER_NAME="$name" GIT_COMMITTER_EMAIL="$email" \
  GIT_AUTHOR_DATE="$fecha" GIT_COMMITTER_DATE="$fecha" \
  git -C "$repo" commit -q -m "$msg"
}

# merge --no-ff <repo> <rama> <mensaje> <días_atrás> <autor_nombre> <autor_email>
merge() {
  local repo="$1" rama="$2" msg="$3" d="$4" name="$5" email="$6"
  local fecha; fecha="$(dia "$d")"
  GIT_AUTHOR_NAME="$name" GIT_AUTHOR_EMAIL="$email" \
  GIT_COMMITTER_NAME="$name" GIT_COMMITTER_EMAIL="$email" \
  GIT_AUTHOR_DATE="$fecha" GIT_COMMITTER_DATE="$fecha" \
  git -C "$repo" merge --no-ff -q -m "$msg" "$rama"
}

iniciar() {
  rm -rf "$SALIDA/$1"
  mkdir -p "$SALIDA/$1"
  git -C "$SALIDA/$1" init -q -b main
  git -C "$SALIDA/$1" config core.autocrlf false
}

INSTRUCTOR_NAME="Instructor"
INSTRUCTOR_EMAIL="instructor@curso.local"

# =============================================================================
# 1) fundamentos-git-github — Portafolio ASCII (proyecto principal)
# =============================================================================
R="$SALIDA/fundamentos-git-github"
iniciar "fundamentos-git-github"

# c1 — estructura base: index.html + estilos.css + .gitignore
cat > "$R/index.html" <<'EOF'
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Mi Portafolio</title>
  <link rel="stylesheet" href="estilos.css" />
</head>
<body>
  <header>
    <h1>Mi Portafolio</h1>
  </header>

  <main>
    <section id="perfil">
      <h2>Sobre mí</h2>
      <p>Soy estudiante de desarrollo web. Me interesa el frontend y el control de versiones.</p>
    </section>

    <section id="proyectos">
      <h2>Proyectos</h2>
      <ul>
        <li>Landing page personal</li>
        <li>Lista de tareas</li>
      </ul>
    </section>

    <section id="contacto">
      <h2>Contacto</h2>
      <p>Email: tu@correo.com</p>
    </section>
  </main>

  <footer>
    <p>&copy; 2026 Mi Portafolio</p>
  </footer>
</body>
</html>
EOF

cat > "$R/estilos.css" <<'EOF'
:root {
  --fondo: #0d1117;
  --texto: #c9d1d9;
  --acento: #58a6ff;
  --borde: #30363d;
}

body {
  margin: 0;
  font-family: system-ui, -apple-system, sans-serif;
  background: var(--fondo);
  color: var(--texto);
  line-height: 1.6;
}

header, footer {
  text-align: center;
  padding: 1.25rem;
}

header { border-bottom: 1px solid var(--borde); }
footer { border-top: 1px solid var(--borde); }

main {
  max-width: 640px;
  margin: 2rem auto;
  padding: 0 1rem;
}

h1, h2 { color: var(--acento); }

a { color: var(--acento); }
EOF

cat > "$R/.gitignore" <<'EOF'
# Sistema operativo
.DS_Store
Thumbs.db

# Editor de código
.vscode/
.idea/
EOF

git -C "$R" add -A
commit "$R" "Crear estructura base del proyecto" 30 "$INSTRUCTOR_NAME" "$INSTRUCTOR_EMAIL"

# c2 — README inicial (título + arte ASCII)
cat > "$R/README.md" <<'EOF'
# Mi Portafolio

```
        *
       ***
      *****
     *******
      *****
       ***
        *
```
EOF

git -C "$R" add -A
commit "$R" "Crear README inicial" 26 "$INSTRUCTOR_NAME" "$INSTRUCTOR_EMAIL"

# c3 — título y descripción del portafolio
cat >> "$R/README.md" <<'EOF'

Bienvenido a mi portafolio personal. Aquí encontrarás mi perfil, mis proyectos y mis datos de contacto.
EOF

git -C "$R" add -A
commit "$R" "Añadir título y descripción del portafolio" 22 "$INSTRUCTOR_NAME" "$INSTRUCTOR_EMAIL"

# c4 — sección de perfil
cat >> "$R/README.md" <<'EOF'

## Sobre mí

Soy estudiante de desarrollo web. Me interesa el frontend, el diseño de interfaces y el control de versiones con Git.
EOF

git -C "$R" add -A
commit "$R" "Añadir sección de perfil" 18 "$INSTRUCTOR_NAME" "$INSTRUCTOR_EMAIL"

# c5 — lista de proyectos
cat >> "$R/README.md" <<'EOF'

## Proyectos

- **Landing page personal** — una página sencilla con HTML y CSS.
- **Lista de tareas** — una app pequeña para practicar JavaScript.
EOF

git -C "$R" add -A
commit "$R" "Añadir lista de proyectos" 12 "$INSTRUCTOR_NAME" "$INSTRUCTOR_EMAIL"

# c6 — datos de contacto (+ contacto.md)
cat >> "$R/README.md" <<'EOF'

## Contacto

- Email: tu@correo.com
- GitHub: https://github.com/tu-usuario
EOF

cat > "$R/contacto.md" <<'EOF'
# Contacto

- Email: tu@correo.com
- GitHub: https://github.com/tu-usuario
- LinkedIn: https://linkedin.com/in/tu-usuario
EOF

git -C "$R" add -A
commit "$R" "Añadir datos de contacto" 6 "$INSTRUCTOR_NAME" "$INSTRUCTOR_EMAIL"

echo "[OK] fundamentos-git-github"
echo "------------------------------------------------------------"

# =============================================================================
# 2) proyecto-inicial — dataset con historial rico + rama fusionada
#    (dos autores simulados: Ana y Luis)
# =============================================================================
R="$SALIDA/proyecto-inicial"
iniciar "proyecto-inicial"

ANA="Ana"
ANA_EMAIL="ana@curso.local"
LUIS="Luis"
LUIS_EMAIL="luis@curso.local"

# c1 — commit inicial
cat > "$R/index.html" <<'EOF'
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <title>Proyecto de práctica</title>
  <link rel="stylesheet" href="estilos.css" />
</head>
<body>
  <main>
    <section>
      <h2>Sobre mí</h2>
      <p>Texto de ejemplo.</p>
    </section>
    <section>
      <h2>Proyectos</h2>
      <ul>
        <li>Proyecto de ejemplo</li>
      </ul>
    </section>
  </main>
</body>
</html>
EOF

cat > "$R/estilos.css" <<'EOF'
body {
  font-family: sans-serif;
  max-width: 640px;
  margin: 2rem auto;
  padding: 0 1rem;
}

h2 {
  color: #0366d6;
}
EOF

cat > "$R/notas.txt" <<'EOF'
Notas de práctica del curso.

- Este archivo sirve para practicar git add y git commit.
- Bórralo o cámbialo sin miedo: es material desechable.
EOF

git -C "$R" add -A
commit "$R" "Commit inicial" 40 "$ANA" "$ANA_EMAIL"

# c2 — estilos base
cat >> "$R/estilos.css" <<'EOF'

header, footer {
  text-align: center;
  padding: 1rem;
  border-bottom: 1px solid #ddd;
}

footer {
  border-bottom: none;
  border-top: 1px solid #ddd;
}
EOF

git -C "$R" add -A
commit "$R" "Añadir estilos base" 36 "$ANA" "$ANA_EMAIL"

# c3 — README inicial
cat > "$R/README.md" <<'EOF'
# Proyecto de práctica

```
    _      _
   / \    (_)_ __
  / _ \   | | '_ \
 / ___ \  | | | | |
/_/   \_\ |_|_| |_|
```
EOF

git -C "$R" add -A
commit "$R" "Crear README inicial" 32 "$ANA" "$ANA_EMAIL"

# c4 — título y descripción
cat >> "$R/README.md" <<'EOF'

Proyecto de práctica del curso de Git. Sirve para experimentar con historial, ramas y recuperación.
EOF

git -C "$R" add -A
commit "$R" "Añadir título y descripción del portafolio" 28 "$LUIS" "$LUIS_EMAIL"

# c5 — sección de perfil
cat >> "$R/README.md" <<'EOF'

## Sobre mí

Texto de ejemplo para practicar commits.
EOF

git -C "$R" add -A
commit "$R" "Añadir sección de perfil" 24 "$LUIS" "$LUIS_EMAIL"

# c6 — lista de proyectos
cat >> "$R/README.md" <<'EOF'

## Proyectos

- Proyecto de ejemplo 1
- Proyecto de ejemplo 2
EOF

git -C "$R" add -A
commit "$R" "Añadir lista de proyectos" 18 "$ANA" "$ANA_EMAIL"

# c7 — datos de contacto
cat >> "$R/README.md" <<'EOF'

## Contacto

- Email: ejemplo@curso.local
EOF

git -C "$R" add -A
commit "$R" "Añadir datos de contacto" 12 "$LUIS" "$LUIS_EMAIL"

# rama feature-header -> se agrega encabezado y se fusiona (merge commit)
git -C "$R" switch -q -c feature-header

cat > "$R/index.html" <<'EOF'
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <title>Proyecto de práctica</title>
  <link rel="stylesheet" href="estilos.css" />
</head>
<body>
  <header>
    <h1>Proyecto de práctica</h1>
  </header>

  <main>
    <section>
      <h2>Sobre mí</h2>
      <p>Texto de ejemplo.</p>
    </section>
    <section>
      <h2>Proyectos</h2>
      <ul>
        <li>Proyecto de ejemplo</li>
      </ul>
    </section>
  </main>
</body>
</html>
EOF

git -C "$R" add -A
commit "$R" "Añadir encabezado a la página" 8 "$LUIS" "$LUIS_EMAIL"

git -C "$R" switch -q main
merge "$R" "feature-header" "Merge branch 'feature-header'" 7 "$LUIS" "$LUIS_EMAIL"
git -C "$R" branch -q -d feature-header

echo "[OK] proyecto-inicial"
echo "------------------------------------------------------------"

# =============================================================================
# 3) repositorio-ejemplo — demo de clonación (Módulos 8.3 y 8.4)
# =============================================================================
R="$SALIDA/repositorio-ejemplo"
iniciar "repositorio-ejemplo"

cat > "$R/app.js" <<'EOF'
// Archivo de ejemplo para el curso de Git.
console.log("Hola desde el repositorio de ejemplo");
EOF

git -C "$R" add -A
commit "$R" "Commit inicial" 20 "$INSTRUCTOR_NAME" "$INSTRUCTOR_EMAIL"

cat > "$R/README.md" <<'EOF'
# Repositorio de ejemplo

Este es un repositorio de demostración para practicar `git clone`, ramas y sincronización.

## Contenido

- `app.js` — archivo JavaScript de ejemplo.
- `LICENSE` — licencia MIT.
EOF

git -C "$R" add -A
commit "$R" "Añadir README con instrucciones" 15 "$INSTRUCTOR_NAME" "$INSTRUCTOR_EMAIL"

cat > "$R/LICENSE" <<'EOF'
MIT License

Copyright (c) 2026 Curso Fundamentos de Git y GitHub

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF

git -C "$R" add -A
commit "$R" "Añadir LICENSE" 10 "$INSTRUCTOR_NAME" "$INSTRUCTOR_EMAIL"

echo "[OK] repositorio-ejemplo"
echo "------------------------------------------------------------"

# =============================================================================
# 4) proyecto-contaminado — SIN git (el alumno hace git init en el Módulo 5)
# =============================================================================
C="$SALIDA/proyecto-contaminado"
rm -rf "$C"
mkdir -p "$C/node_modules/lodash" "$C/dist"

cat > "$C/package.json" <<'EOF'
{
  "name": "proyecto-contaminado",
  "version": "1.0.0",
  "description": "Proyecto de práctica con archivos que NO deben versionarse",
  "scripts": {
    "build": "node build.js"
  },
  "dependencies": {
    "lodash": "^4.17.21"
  }
}
EOF

cat > "$C/index.js" <<'EOF'
const _ = require("lodash");

console.log("Proyecto de práctica para .gitignore");
EOF

cat > "$C/README.md" <<'EOF'
# Proyecto de práctica (contaminado)

Este proyecto contiene archivos que **no** deberían versionarse.

Tu tarea: crear un archivo `.gitignore` que los excluya.
EOF

cat > "$C/node_modules/lodash/index.js" <<'EOF'
// Simulación de una dependencia instalada.
// NO se debe versionar node_modules.
module.exports = {};
EOF

cat > "$C/dist/bundle.js" <<'EOF'
// Build generado automáticamente.
// NO se debe versionar la carpeta dist.
console.log("bundle");
EOF

cat > "$C/app.log" <<'EOF'
2026-01-01 10:00:00 INFO  Aplicación iniciada
2026-01-01 10:00:01 DEBUG Procesando petición
2026-01-01 10:00:02 INFO  Petición completada
EOF

cat > "$C/debug.log" <<'EOF'
[DEBUG] 2026-01-01 10:00:00 - conectando a la base de datos...
[DEBUG] 2026-01-01 10:00:02 - consulta ejecutada
EOF

cat > "$C/.env" <<'EOF'
# Datos FALSOS, solo para la práctica. Nunca subir un .env real.
API_KEY=fake-api-key-123456
DB_PASSWORD=contrasena-falsa-para-practica
SECRET_TOKEN=token-falso-no-real
EOF

touch "$C/.DS_Store"

echo "[OK] proyecto-contaminado"

# --- Intentar crear el ZIP del contaminado (entregable al alumno) ------------
if command -v zip >/dev/null 2>&1; then
  (cd "$SALIDA" && zip -rq "proyecto-contaminado.zip" "proyecto-contaminado")
  echo "[OK] proyecto-contaminado.zip"
elif command -v powershell.exe >/dev/null 2>&1 && command -v cygpath >/dev/null 2>&1; then
  W="$(cygpath -w "$SALIDA")"
  powershell.exe -NoProfile -Command "Compress-Archive -Path '$W\proyecto-contaminado' -DestinationPath '$W\proyecto-contaminado.zip' -Force"
  echo "[OK] proyecto-contaminado.zip (via PowerShell)"
else
  echo "[AVISO] No se pudo crear el ZIP. Comprime manualmente la carpeta:"
  echo "        $SALIDA/proyecto-contaminado"
fi
echo "------------------------------------------------------------"

# =============================================================================
# Resumen
# =============================================================================
echo ""
echo "Generado en: $SALIDA"
echo ""
for r in fundamentos-git-github proyecto-inicial repositorio-ejemplo; do
  echo "=== $r ==="
  git -C "$SALIDA/$r" log --oneline --graph --all
  echo ""
done
