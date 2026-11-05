// Charla de iniciación a Git y GitHub (AISC x GUL UC3M).
// Compilar con: typst compile --font-path fonts charla-git.typ
#import "plantilla-git.typ": *
#set page(width: 720pt, height: 405pt, margin: 0pt, fill: white)
#set text(lang: "es", hyphenate: false)

// Capítulos de la charla, para las portadillas.
#let capitulos = ("La idea", "Empezar", "Guardar", "Dónde estás", "Traer cambios", "En paralelo")

// ============ Intro ============
#let paso-inicio(n, titulo, detalle) = box(width: 310pt, height: 92pt, {
  en(0, 0, box(width: 26pt, height: 26pt, fill: azul, align(center + horizon, t(str(n), size: 13pt, fill: white, weight: "bold"))))
  en(38, 2, t(titulo, size: 14pt, weight: "semibold"))
  en(38, 24, box(width: 272pt, detalle))
})
#diapo("bienvenida", "Mientras esperas...", [Si lo dejas hecho, empezamos todos a la vez.], grid(columns: 2, column-gutter: 34pt, row-gutter: 20pt,
  paso-inicio(1, "Instala Git", t("git-scm.com/downloads", size: 10pt, font: mono, fill: gris)),
  paso-inicio(2, "Crea tu cuenta", t("github.com/signup", size: 10pt, font: mono, fill: gris)),
  paso-inicio(3, "Prepara VS Code", t([Inicia sesión con GitHub desde el icono de cuentas, abajo a la izquierda.], size: 10pt, fill: gris)),
  paso-inicio(4, "Di quién eres", stack(dir: ttb, spacing: 7pt,
    t(`git config --global user.name "Tu Nombre"`.text, size: 8pt, font: mono, fill: gris),
    t(`git config --global user.email "tu@email"`.text, size: 8pt, font: mono, fill: gris))),
))

#portada-charla("Taller de iniciación", "Git y GitHub", "AISC x GUL UC3M")

#let qr-slides = diapo("slides", "Las diapositivas", [Por si quieres seguirlas desde el portátil.], {
  en(214, 0, image("img/qr-slides.svg", width: 226pt))
  en(0, 240, box(width: ancho-libre * 1pt, align(center, link("https://github.com/guluc3m/charlas-git-2026-27/blob/main/charla-git.pdf", t("github.com/guluc3m/charlas-git-2026-27", size: 11pt, font: mono)))))
})
#qr-slides

#let herramienta(img, nombre, enlace) = box(width: 120pt, height: 150pt, {
  en(25, 0, box(width: 70pt, height: 70pt, align(center + horizon, image(img, height: 70pt))))
  en(0, 84, box(width: 120pt, align(center, t(nombre, size: 13pt, weight: "semibold"))))
  en(0, 106, box(width: 120pt, align(center, t(enlace, size: 8pt, font: mono, fill: gris))))
})
#diapo("formato", "Formato del taller", [Lo básico de Git, y practicando desde el principio.], {
  en(0, 24, grid(columns: 3, column-gutter: 12pt,
    herramienta("img/image11.png", "Git", "git-scm.com"),
    herramienta("img/image10.png", "GitHub", "github.com"),
    herramienta("img/image9.png", "VS Code", "code.visualstudio.com"),
  ))
  bloque(410, 10, 0.8, 200, linea)
  en(450, 24, icono-practica(92))
  en(450, 134, box(width: 200pt, t([Cuando salga este icono, *toca practicar*. Si te pierdes, levanta la mano.], size: 12pt)))
})

// ============ Teoría breve ============
#portada("01", "La idea", capitulos)

#let foto(img, nombre, ancho) = stack(dir: ttb, spacing: 10pt,
  box(stroke: 0.8pt + linea, image(img, height: 222pt, width: ancho * 1pt, fit: "contain")),
  box(width: ancho * 1pt, align(center, t(nombre, size: 12pt, weight: "medium"))))
#diapo("por-que-git", "¿Por qué Git?", [Porque pasarse el código por aquí siempre acaba en lío.], align(center, stack(dir: ltr, spacing: 20pt,
  foto("img/image14.jpg", "WhatsApp", 110),
  foto("img/image56.png", "Drive", 200),
  foto("img/image16.png", "Gmail", 296),
)))

#let sitio(img, nombre, lema, lineas) = box(width: 310pt, height: 170pt, fill: c-lateral, stroke: 0.8pt + linea, {
  en(16, 16, box(width: 44pt, height: 44pt, image(img, height: 44pt)))
  en(72, 20, t(nombre, size: 18pt, weight: "semibold"))
  en(72, 44, t(lema, size: 10pt, fill: azul-texto, weight: "medium"))
  en(16, 80, box(width: 278pt, stack(dir: ttb, spacing: 12pt, ..lineas.map(l => t(l, size: 10.5pt)))))
})
#diapo("git-y-github", "Git no es GitHub", [Van de la mano, pero no son lo mismo.], {
  en(0, 4, sitio("img/image11.png", "Git", "el programa, en tu ordenador", ([Guarda el historial de tu proyecto.], [Funciona sin internet.], [Linus Torvalds lo creó en 2005 para el kernel de Linux.])))
  en(344, 4, sitio("img/image10.png", "GitHub", "la web donde lo subes", ([Guarda una copia en internet.], [Es donde trabajas con los demás.], [Hay alternativas: GitLab, Forgejo, Gitea.])))
  en(0, 190, t([Más de 14.000 personas han tocado el kernel de Linux trabajando así.], size: 10.5pt, fill: gris))
})

#diapo("zonas", "Las cuatro zonas", [En Git, casi todo es mover cambios de una a otra.], {
  en(80, 8, box(width: 494pt, height: 144pt, diagrama-zonas((
    Trabajo: filas(fila-archivo("salto.py", estado: "M", color: ambar)),
    Stage: filas(fila-archivo("fuego.py", estado: "A")),
    Local: filas(fila-version("a1b2c3", "Primera versión")),
    Remoto: filas(fila-version("a1b2c3", "Primera versión")),
  ))))
  en(0, 178, box(width: ancho-libre * 1pt, align(center, t([En cada diapositiva, arriba, verás en azul en qué zona actúa el comando:], size: 10.5pt, fill: gris))))
  en(0, 200, box(width: ancho-libre * 1pt, align(center, { t("Trabajo › Stage › ", size: 12pt, fill: tenue); t("Local", size: 12pt, fill: azul-texto, weight: "semibold"); t(" › Remoto", size: 12pt, fill: tenue) })))
})

// ============ Comandos: lo básico ============
#portada("02", "Empezar un repo", capitulos, contenido: "init · clone")

// La historia del repo, igual en toda la charla.
#let h-base = (cg("Primera versión", ramas: ("main", "origin")),)
#let h-commit(nuevo) = (cg("Mario salta", ramas: ("main",), nuevo: nuevo), cg("Primera versión", ramas: ("origin",)))
#let h-subido(nuevo) = (cg("Mario salta", ramas: ("main", "origin"), nuevo: nuevo), cg("Primera versión"))

// ---------- git init ----------
#let ficha-init(paso, texto, diagrama, historia: none) = ficha(
  "git init", "Empezar un repo desde cero", "git init", "Local",
  (("-b <rama>", "elige el nombre de la rama inicial"),),
  paso, texto, diagrama, historia: historia,
  captura: lateral-boton("Initialize Repository", [Te sale en Source Control si la carpeta no tiene repo.]),
  ojo: [No lo hagas dentro de otro repo.],
  deshacer: [Borra la carpeta `.git`. \ Tus archivos no se tocan.],
)
#ficha-init("Antes", [Una carpeta normal. Git ni se entera.], diagrama-zonas((
  Trabajo: filas(fila-archivo("README.md", estado: "?", color: tenue)),
  Stage: en-gris("(no existe)"),
  Local: en-gris("(no existe)"),
  Remoto: en-gris("(no existe)"),
)))
#ficha-init("Después", [Aparece la carpeta oculta `.git`, que es donde se guarda todo.], diagrama-zonas((
  Trabajo: filas(fila-archivo("README.md", estado: "U", color: ambar)),
  Stage: vacio,
  Local: en-gris("(sin commits)"),
  Remoto: en-gris("(no existe)"),
)))

// ---------- git clone ----------
#let ficha-clone(paso, texto, diagrama, historia: none) = ficha(
  "git clone", "Traer un repo de GitHub", "git clone <url>", "Local",
  (("-b <rama>", "te deja ya en esa rama"), ("--depth 1", "se baja solo el último commit")),
  paso, texto, diagrama, historia: historia,
  captura: lateral-boton("Clone Repository", [Te sale en Source Control si no tienes ninguna carpeta abierta.]),
  ojo: [Crea una carpeta nueva. Acuérdate de entrar en ella.],
  deshacer: [Borra la carpeta. \ En GitHub no cambia nada.],
)
#let solo-base = filas(fila-version("a1b2c3", "Primera versión"))
#ficha-clone("Antes", [El proyecto solo está en GitHub.], diagrama-zonas((
  Trabajo: en-gris("(nada)"),
  Stage: en-gris("(nada)"),
  Local: en-gris("(nada)"),
  Remoto: solo-base,
)))
#ficha-clone("Después", [Te bajas los archivos y todo el historial, no solo la última versión.], diagrama-zonas(vuelta: ((3, 0, "clone"),), (
  Trabajo: filas(fila-archivo("README.md")),
  Stage: vacio,
  Local: solo-base,
  Remoto: solo-base,
)))

#portada("03", "Guardar el trabajo", capitulos, contenido: "diff · add · commit · status · log · push")

// ---------- git diff ----------
#ficha(
  "git diff", "Ver qué has cambiado", "git diff [<archivo>]", "Trabajo",
  (("--staged", "lo que ya tienes en Stage"), ("--stat", "solo un resumen por archivo")),
  "Ejemplo", [En rojo lo que quitas y en verde lo que añades.],
  diagrama-diff("README.md", (
    (" ", "# Mario Bros"),
    ("-", "Un juego de plataformas."),
    ("+", "Un juego de plataformas en Python."),
    ("+", "Para jugar: python mario.py"),
    (" ", "Hecho en el taller de Git."),
  )),
  historia: h-base,
  captura: lateral-lista((("CHANGES", (fila-archivo("README.md", estado: "M", color: ambar, ancho: 160, marcada: true),)),), nota: [Pincha en el archivo y ves los cambios.]),
  ojo: [Lo que ya hayas metido con `add` no sale sin `--staged`.],
)

// ---------- git add ----------
#let ficha-add(paso, texto, diagrama, historia: none) = ficha(
  "git add", "Preparar cambios", "git add <archivo>", "Stage",
  ((".", "todo lo que hay en esta carpeta"), ("-p", "vas eligiendo trozo a trozo")),
  paso, texto, diagrama, historia: historia,
  captura: lateral-lista((("CHANGES", (
    fila-archivo("salto.py", estado: "U", color: ambar, ancho: 160, marcada: true, mas: true),
    fila-archivo("fuego.py", estado: "U", color: ambar, ancho: 160),
    fila-archivo("notas.txt", estado: "U", color: ambar, ancho: 160),
  )),), nota: [El `+` de cada archivo hace lo mismo que `git add`.]),
  ojo: [`git add .` lo mete todo. Mira antes `git status`.],
  deshacer: [`git restore --staged <archivo>` \ lo saca de Stage y no se pierde.],
)
#ficha-add("Antes", [Tres archivos nuevos y ninguno preparado.], historia: h-base, diagrama-zonas(activa: "add", (
  Trabajo: filas(fila-archivo("salto.py", estado: "U", color: ambar), fila-archivo("fuego.py", estado: "U", color: ambar), fila-archivo("notas.txt", estado: "U", color: ambar)),
  Stage: vacio,
  Local: filas(fila-version("a1b2c3", "Primera versión")),
  Remoto: filas(fila-version("a1b2c3", "Primera versión")),
)))
#ficha-add("Después", [Con `git add salto.py fuego.py` eliges qué va en el próximo commit.], historia: h-base, diagrama-zonas(activa: "add", (
  Trabajo: filas(fila-archivo("notas.txt", estado: "U", color: ambar)),
  Stage: filas(fila-archivo("salto.py", estado: "A"), fila-archivo("fuego.py", estado: "A")),
  Local: filas(fila-version("a1b2c3", "Primera versión")),
  Remoto: filas(fila-version("a1b2c3", "Primera versión")),
)))

// ---------- .gitignore ----------
#ficha(
  ".gitignore", "Que Git pase de ciertos archivos", none, "Trabajo",
  ((".venv/", "el entorno virtual de Python"), ("__pycache__/", "la basura que genera Python")),
  "Ejemplo", [Lo que esté en la lista deja de salir como cambio.],
  {
    let linea-ignore(n, patron, secundaria) = box(width: 100%, inset: (x: 8pt), { t(str(n), size: 9pt, font: mono, fill: tenue); h(10pt); t(patron, size: if secundaria { 9pt } else { 10pt }, font: mono, fill: if secundaria { tenue } else { tinta }) })
    en(0, 0, panel(".gitignore", 200, 144, stack(dir: ttb, spacing: 7pt,
      linea-ignore(1, ".venv/", false), linea-ignore(2, "__pycache__/", false), linea-ignore(3, ".vscode/", true), linea-ignore(4, ".idea/", true))))
    flecha(204, 72, 236, 72, color: azul, grosor: 2pt)
    en(240, 0, panel("Tu carpeta", 254, 144, stack(dir: ttb,
      fila-archivo(".gitignore", estado: "U", color: ambar, ancho: 254),
      fila-archivo("notas.txt", estado: "U", color: ambar, ancho: 254),
      fila-archivo(".venv/", estado: "ignorado", color: tenue, ancho: 254, apagada: true),
      fila-archivo("__pycache__/", estado: "ignorado", color: tenue, ancho: 254, apagada: true),
    )))
  },
  captura: lateral-lista((("CHANGES", (fila-archivo(".gitignore", estado: "U", color: ambar, ancho: 160), fila-archivo("notas.txt", estado: "U", color: ambar, ancho: 160))),), nota: [`.venv/` y `__pycache__/` ya no salen en la lista.]),
  historia: h-base,
  etiqueta-panel: "PATRONES",
  secundarias: ((".vscode/", "los ajustes de VS Code"), (".idea/", "los ajustes de PyCharm")),
  ojo: [Lo ya commiteado se queda. Para sacarlo: \ `git rm --cached <archivo>`.],
  deshacer: [Quita la línea de \ `.gitignore`.],
)

// ---------- git commit ----------
#let ficha-commit(paso, texto, diagrama, historia: none) = ficha(
  "git commit", "Guardar una versión", `git commit -m "<mensaje>"`.text, "Local",
  (("-a", "añade lo modificado (no lo nuevo)"), ("--amend", "corrige el último commit")),
  paso, texto, diagrama, historia: historia,
  captura: lateral-commit,
  ojo: ["fix" no dice nada. Pon qué has cambiado.],
  deshacer: [`git reset --soft HEAD~1` \ y no pierdes los cambios.],
)
#ficha-commit("Antes", [Tienes dos archivos preparados en Stage.], historia: h-base, diagrama-zonas(activa: "commit", (
  Trabajo: filas(fila-archivo("notas.txt", estado: "U", color: ambar)),
  Stage: filas(fila-archivo("salto.py", estado: "A"), fila-archivo("fuego.py", estado: "A")),
  Local: filas(fila-version("a1b2c3", "Primera versión")),
  Remoto: filas(fila-version("a1b2c3", "Primera versión")),
)))
#ficha-commit("Después", [Lo que había en Stage pasa a ser una versión nueva. `notas.txt` se queda fuera.], historia: h-commit(true), diagrama-zonas(activa: "commit", (
  Trabajo: filas(fila-archivo("notas.txt", estado: "U", color: ambar)),
  Stage: vacio,
  Local: filas(fila-version("d4e5f6", "Mario salta", nuevo: true), fila-version("a1b2c3", "Primera versión")),
  Remoto: filas(fila-version("a1b2c3", "Primera versión")),
)))

// ---------- git status ----------
#ficha(
  "git status", "Ver cómo va todo", "git status", ("Trabajo", "Stage"),
  (("-s", "versión corta"), ("-sb", "corta y con la rama")),
  "Ejemplo", [Es lo que te sale, quitando las líneas de ayuda.],
  diagrama-terminal((
    ("On branch main", tinta, "Tu rama"),
    ("Changes to be committed:", tinta, none),
    ("    new file:   .gitignore", verde, "En Stage: va en el próximo commit"),
    ("Changes not staged for commit:", tinta, none),
    ("    modified:   README.md", rojo, "Cambiado, pero sin preparar"),
    ("Untracked files:", tinta, none),
    ("    notas.txt", rojo, "Archivo nuevo: Git aún no lo sigue"),
  )),
  captura: lateral-lista((
    ("STAGED CHANGES", (fila-archivo(".gitignore", estado: "A", ancho: 160),)),
    ("CHANGES", (fila-archivo("README.md", estado: "M", color: ambar, ancho: 160), fila-archivo("notas.txt", estado: "U", color: ambar, ancho: 160))),
  ), nota: [Este panel es básicamente `git status`, siempre a la vista.]),
  historia: h-commit(false),
  ojo: [¿No sale lo que esperabas? \ Mira si estás en la carpeta buena.],
)

// ---------- git log ----------
#ficha(
  "git log", "Ver el historial", "git log", "Local",
  (("--oneline", "una línea por commit"), ("--graph", "dibuja las ramas"), ("-p", "con los cambios de cada commit")),
  "Ejemplo", [Esto es `git log --oneline`, con lo más nuevo arriba.],
  diagrama-terminal(alto-fila: 34, (
    ("d4e5f6a (HEAD -> main) Mario salta", tinta, "Estás aquí, en tu último commit"),
    ("a1b2c3d (origin/main) Primera versión", tinta, "GitHub llega hasta aquí"),
  )),
  lateral-titulo: "SOURCE CONTROL GRAPH",
  captura: stack(dir: ttb, fila-historia("Mario salta", etiqueta: "main"), fila-historia("Primera versión", etiqueta: "origin", color: gris)),
  ojo: [Si es largo se queda abierto. \ Para salir, pulsa `q`.],
)

// ---------- git push ----------
#let ficha-push(paso, texto, diagrama, errores: 0, historia: none) = ficha(
  "git push", "Subir los commits", "git push origin <rama>", "Remoto",
  (("-u", "recuerda el remoto de esta rama"), ("--force", "machaca lo de GitHub con lo tuyo"), ("--force-with-lease", "igual, pero solo si nadie ha subido nada")),
  paso, texto, diagrama, errores: errores, historia: historia,
  captura: lateral-boton("Sync Changes", [Hace `pull` y luego `push`. \ La primera vez sale Publish Branch.]),
  ojo: [`--force` se puede cargar el \ trabajo de los demás.],
  deshacer: [`git revert <commit>` y `push`. \ Crea un commit que lo deshace.],
)
#ficha-push("Antes", [Tu commit todavía está solo en tu ordenador.], historia: h-commit(false), diagrama-zonas(activa: "push", (
  Trabajo: en-gris("(sin cambios)"),
  Stage: vacio,
  Local: filas(fila-version("d4e5f6", "Mario salta"), fila-version("a1b2c3", "Primera versión")),
  Remoto: filas(fila-version("a1b2c3", "Primera versión")),
)))
#ficha-push("Después", [Ya está en GitHub y los demás se lo pueden bajar.], historia: h-subido(true), diagrama-zonas(activa: "push", (
  Trabajo: en-gris("(sin cambios)"),
  Stage: vacio,
  Local: filas(fila-version("d4e5f6", "Mario salta"), fila-version("a1b2c3", "Primera versión")),
  Remoto: filas(fila-version("d4e5f6", "Mario salta", nuevo: true), fila-version("a1b2c3", "Primera versión")),
)))
#ficha-push("--force", [GitHub tenía un commit que tú no tenías, y `--force` se lo carga.], errores: 1, diagrama-zonas(activa: "push", (
  Trabajo: en-gris("(sin cambios)"),
  Stage: vacio,
  Local: filas(fila-version("f9e8d7", "Bola de fuego"), fila-version("a1b2c3", "Primera versión")),
  Remoto: filas(fila-version("f9e8d7", "Bola de fuego", nuevo: true), fila-version("c0d1e2", "De un compañero", borrado: true), fila-version("a1b2c3", "Primera versión")),
)))

#portada("04", "Saber dónde estás", capitulos, contenido: "HEAD · origin")

// ---------- HEAD ----------
#let lateral-head = lateral-barra("main", [Abajo a la izquierda siempre ves en qué rama estás. Ahí apunta `HEAD`.])
#let ficha-head(paso, texto, diagrama, historia: none) = ficha(
  "HEAD", "HEAD: dónde estás ahora", "git show HEAD~<n>", "Local",
  (("HEAD", "tu commit actual"), ("HEAD~1", "el anterior"), ("HEAD~2", "dos más atrás")),
  paso, texto, diagrama, historia: historia,
  lateral-titulo: "EN VS CODE", captura: lateral-head,
  ojo: [Si te sale "detached HEAD", vuelve con `git switch main`.],
)
#let nodos-head = (A: (60, 62, azul), B: (170, 62, azul), C: (280, 62, azul))
#ficha-head("Ahora", [`HEAD` apunta a tu rama, y tu rama a su último commit.], {
  diagrama-grafo(nodos-head, (("A", "B", azul), ("B", "C", azul)), ramas: (("main", 262, 28, azul), ("HEAD", 302, 28, tinta)))
  bajo-nodo(60, 84, "HEAD~2")
  bajo-nodo(170, 84, "HEAD~1")
  bajo-nodo(280, 84, "HEAD")
})
#ficha-head("Tras un commit", [El commit nuevo mueve `main`, y `HEAD` se va con ella.], {
  diagrama-grafo(nodos-head + (D: (390, 62, dorado, true)), (("A", "B", azul), ("B", "C", azul), ("C", "D", dorado)), ramas: (("main", 372, 28, azul), ("HEAD", 412, 28, tinta)))
  bajo-nodo(170, 84, "HEAD~2")
  bajo-nodo(280, 84, "HEAD~1")
  bajo-nodo(390, 84, "HEAD")
})

// ---------- origin ----------
#let ficha-origin(paso, texto, diagrama, historia: none) = ficha(
  "origin", "origin: el mote de tu remoto", "git remote add origin <url>", "Remoto",
  (("-v", "con git remote -v, ves tus remotos"), ("origin/main", "main en GitHub, la última vez que miraste")),
  paso, texto, diagrama, historia: historia,
  lateral-titulo: "EN VS CODE",
  captura: lateral-paleta("Git: Add Remote...", "", (), none, [`git clone` ya te crea `origin`. \ Solo hace falta tras `git init`.]),
  ojo: [`origin/main` no se actualiza solo. \ Hace falta `fetch`, `pull` o `push`.],
  deshacer: [`git remote remove origin` \ solo borra el mote.],
)
#let dos-sitios(izquierda, derecha) = {
  en(0, 0, panel("Tu ordenador", 300, 144, []))
  en(0, 0, box(width: 300pt, height: 144pt, izquierda))
  flecha(304, 80, 322, 80, color: tenue)
  en(326, 0, panel("origin = github.com/usuario/mario", 168, 144, []))
  en(326, 0, box(width: 168pt, height: 144pt, derecha))
}
#let remoto-ab = diagrama-grafo((A: (35, 90, azul), B: (115, 90, azul)), (("A", "B", azul),), ramas: ((("main", 96, 58, azul),)))
#ficha-origin("Al día", [`origin` es un mote para esa URL. `origin/main` es por dónde iba GitHub.], dos-sitios(
  diagrama-grafo((A: (45, 90, azul), B: (135, 90, azul)), (("A", "B", azul),), ramas: (("main", 90, 58, azul), ("origin/main", 132, 58, tenue))),
  remoto-ab,
))
#ficha-origin("Tras un commit", [Tu `main` avanza y `origin/main` se queda: GitHub aún no se ha enterado.], dos-sitios(
  diagrama-grafo((A: (45, 90, azul), B: (135, 90, azul), C: (235, 90, dorado, true)), (("A", "B", azul), ("B", "C", dorado)), ramas: (("origin/main", 100, 58, tenue), ("main", 216, 58, azul))),
  remoto-ab,
))

#portada("05", "Traer cambios", capitulos, contenido: "fetch · pull")

// ---------- git fetch ----------
#let ficha-fetch(paso, texto, diagrama, historia: none) = ficha(
  "git fetch", "Mirar qué hay nuevo en GitHub", "git fetch [<remoto>]", "Local",
  (("--all", "de todos los remotos"), ("--prune", "olvida las ramas borradas en GitHub")),
  paso, texto, diagrama, historia: historia,
  lateral-titulo: "EN VS CODE",
  captura: lateral-paleta("Git: Fetch", "", (), none, [También en Source Control: \ ··· › Pull, Push › Fetch]),
  ojo: [No te cambia los archivos. \ Para eso está `pull`.],
)
#let v-enemigos = fila-version("b7c8d9", "Añade enemigos")
#let v-salta = fila-version("d4e5f6", "Mario salta")
#let v-base = fila-version("a1b2c3", "Primera versión")
#ficha-fetch("Antes", [Un compañero ha subido un commit que tú no tienes.], historia: h-subido(false), diagrama-zonas((
  Trabajo: filas(fila-archivo("README.md"), fila-archivo("salto.py")),
  Stage: vacio,
  Local: filas(v-salta, v-base),
  Remoto: filas(v-enemigos, v-salta, v-base),
)))
#ficha-fetch("Después", [Ya tienes el commit en `origin/main`, pero tus archivos siguen igual.], historia: (cg("Añade enemigos", ramas: ("origin",), nuevo: true), cg("Mario salta", ramas: ("main",)), cg("Primera versión")), diagrama-zonas(vuelta: ((3, 2, "fetch"),), (
  Trabajo: filas(fila-archivo("README.md"), fila-archivo("salto.py")),
  Stage: vacio,
  Local: filas(fila-version("b7c8d9", "en origin/main", nuevo: true), v-salta, v-base),
  Remoto: filas(v-enemigos, v-salta, v-base),
)))

// ---------- git pull ----------
#let ficha-pull(paso, texto, diagrama, historia: none) = ficha(
  "git pull", "Traer los cambios de GitHub", "git pull", "Trabajo",
  (("--rebase", "pone tus commits encima, sin merge"), ("--ff-only", "falla si hay que hacer merge")),
  paso, texto, diagrama, historia: historia,
  captura: lateral-boton("Sync Changes", [Hace `pull` y luego `push`. \ Solo traer: ··· › Pull, Push › Pull]),
  ojo: [Haz commit antes. Si tienes cambios sin guardar, igual no te deja.],
  deshacer: [`git reset --hard ORIG_HEAD` \ borra lo no commiteado.],
)
#ficha-pull("Antes", [Tu carpeta se ha quedado por detrás de GitHub.], historia: h-subido(false), diagrama-zonas((
  Trabajo: filas(fila-archivo("README.md"), fila-archivo("salto.py")),
  Stage: vacio,
  Local: filas(v-salta, v-base),
  Remoto: filas(v-enemigos, v-salta, v-base),
)))
#ficha-pull("Después", [`pull` es un `fetch` y luego un `merge`, así que ahora sí cambian tus archivos.], historia: (cg("Añade enemigos", ramas: ("main", "origin"), nuevo: true), cg("Mario salta"), cg("Primera versión")), diagrama-zonas(vuelta: ((3, 2, "fetch"), (2, 0, "merge")), (
  Trabajo: filas(fila-archivo("README.md"), fila-archivo("salto.py"), fila-archivo("enemigos.py", estado: "+", color: azul-texto)),
  Stage: vacio,
  Local: filas(fila-version("b7c8d9", "Añade enemigos", nuevo: true), v-salta, v-base),
  Remoto: filas(v-enemigos, v-salta, v-base),
)))

// ============ Ejercicio 1 ============
#ejercicio("ejercicio-1", "Ejercicio 1: tu primer repo", [Unos 10 minutos, a tu ritmo.], (
  ([Crea un repo en GitHub con README y clónalo], `git clone <url>`.text),
  ([Crea `hola.txt` con una línea y mira qué pasa], "git status"),
  ([Prepáralo y guárdalo], `git add hola.txt; git commit -m "Añade hola"`.text),
  ([Súbelo y míralo en la web], "git push"),
  ([Cambia la línea, mira el cambio y súbelo], `git diff; git commit -am "Cambia hola"; git push`.text),
  ([Edita el README en la web y bájatelo], "git pull"),
), [En `git log --oneline` y en GitHub salen los mismos commits.])

// ============ Comandos: ramas ============
#portada("06", "Trabajar en paralelo", capitulos, contenido: "branch · switch · merge · conflictos")

// ---------- git branch ----------
#let ficha-branch(paso, texto, diagrama, historia: none) = ficha(
  "git branch", "Crear una rama", "git branch <rama>", "Local",
  (("-a", "lista todas, también las remotas"), ("-d <rama>", "borra una rama ya mergeada"), ("-m <nombre>", "renombra la rama actual")),
  paso, texto, diagrama, historia: historia,
  lateral-titulo: "EN VS CODE",
  captura: lateral-paleta("Git: Create Branch...", "Ponle nombre", ("salto",), "salto", [Ojo: aquí además te cambia a la rama nueva.]),
  ojo: [Crea la rama, pero no te mueve a ella. Falta el `switch`.],
  deshacer: [`git branch -d <rama>` \ la borra, y los commits se quedan.],
)
#let nodos-rama = (A: (70, 75, azul), B: (190, 75, azul))
#ficha-branch("Antes", [Solo existe `main`.], diagrama-grafo(nodos-rama, (("A", "B", azul),), ramas: (("main", 172, 41, azul), ("HEAD", 212, 41, tinta))))
#ficha-branch("Después", [Una rama no es más que una etiqueta sobre un commit. Sigues en `main`.], diagrama-grafo(nodos-rama, (("A", "B", azul),), ramas: (("main", 172, 41, azul), ("HEAD", 212, 41, tinta), ("salto", 172, 96, dorado))))

// ---------- git switch ----------
#let ficha-switch(paso, texto, diagrama, historia: none) = ficha(
  "git switch", "Cambiar de rama", "git switch <rama>", "Trabajo",
  (("-c <rama>", "la crea y te mueve a ella"), ("-", "vuelve a la rama anterior")),
  paso, texto, diagrama, historia: historia,
  lateral-titulo: "EN VS CODE",
  captura: lateral-barra("main", [Pincha en tu rama, en la barra de abajo, y elige otra. \ Por internet verás `git checkout`, que también vale.]),
  ojo: [Si tienes cambios sin guardar, igual no te deja. Haz commit antes.],
  deshacer: [`git switch -` \ te devuelve a donde estabas.],
)
#let nodos-sw = (A: (50, 50, azul), B: (150, 50, azul), C: (270, 50, azul), D: (270, 112, dorado))
#let aristas-sw = (("A", "B", azul), ("B", "C", azul), ("B", "D", dorado))
#ficha-switch("Antes", [Estás en `main`, así que ves los archivos de `C`.], diagrama-grafo(nodos-sw, aristas-sw, ramas: (("main", 290, 42, azul), ("HEAD", 330, 42, tinta), ("salto", 290, 104, dorado))))
#ficha-switch("Después", [`HEAD` se mueve a `salto` y ahora ves los archivos de `D`.], diagrama-grafo(nodos-sw, aristas-sw, ramas: (("main", 290, 42, azul), ("salto", 290, 104, dorado), ("HEAD", 333, 104, tinta))))

// ---------- git merge ----------
#let ficha-merge(paso, texto, diagrama, historia: none) = ficha(
  "git merge", "Unir dos ramas", `git merge <rama>`.text, "Local",
  (("--no-ff", "crea siempre un commit de merge"), ("--abort", "cancela un merge con conflictos")),
  paso, texto, diagrama, historia: historia,
  lateral-titulo: "EN VS CODE",
  captura: lateral-paleta("Git: Merge...", "Elige la rama", ("salto", "origin/main"), "salto", [También en Source Control: \ ··· › Branch › Merge...]),
  ojo: [Trae los cambios a la rama en la que estés. Muévete antes.],
  deshacer: [`git reset --hard ORIG_HEAD` \ borra lo no commiteado.],
)
#let nodos = (A: (40, 48, azul), B: (120, 48, azul), C: (230, 48, azul), D: (180, 112, dorado), E: (280, 112, dorado))
#let aristas = (("A", "B", azul), ("B", "C", azul), ("B", "D", dorado), ("D", "E", dorado))
#let ramas-antes = (("main", 212, 14, azul), ("HEAD", 252, 14, tinta), ("salto", 298, 105, dorado))
#ficha-merge("Antes", [Las dos ramas han avanzado por separado. Estás en `main`.], diagrama-grafo(nodos, aristas, ramas: ramas-antes))
#ficha-merge("Merge", [`git merge salto` junta lo de `salto` con lo de `main`.], diagrama-grafo(nodos, aristas, ramas: ramas-antes,
  extra: {
    flecha(245, 48, 366, 48, color: azul, dash: "dashed")
    flecha(293, 102, 372, 58, color: dorado, dash: "dashed")
    en(367, 37, circle(radius: 11pt, stroke: (paint: tinta, thickness: 1.5pt, dash: "dashed")))
  }))
#ficha-merge("Después", [Ahora `main` lo tiene todo, y `salto` sigue donde estaba.], diagrama-grafo(nodos + (M: (378, 48, azul, true)), aristas + (("C", "M", azul), ("E", "M", dorado)),
  ramas: (("main", 360, 14, azul), ("HEAD", 400, 14, tinta), ("salto", 298, 105, dorado))))

// ---------- Conflictos ----------
#let ficha-conflicto(paso, texto, captura, diagrama, errores: 0, historia: none) = ficha(
  "conflicto", "Resolver un conflicto", "git add <archivo>", "Trabajo",
  (("git commit --no-edit", "termina el merge con su mensaje"), ("git status", "lista los archivos en conflicto"), ("git merge --abort", "cancelas y vuelves a como estabas")),
  paso, texto, diagrama, errores: errores, captura: captura, historia: historia,
  ojo: [Borra las marcas `<<<<<<<`. \ Si se quedan, el código peta.],
  deshacer: [`git merge --abort` \ mientras no hayas hecho commit.],
)
#let h-conflicto = (
  cg("Salto medio", ramas: ("main",), padres: (2,)),
  cg("Salto alto", carril: 1, ramas: ("salto",), padres: (2,)),
  cg("Añade enemigos"),
)
#let lat-conflicto = lateral-lista((("MERGE CHANGES", (fila-archivo("salto.py", estado: "!", color: rojo, ancho: 160, marcada: true),)),), nota: [El `!` es el conflicto. Pincha en el archivo para abrirlo.])
#let verde-c = rgb("#D3F0D6")
#let azul-c = rgb("#D6E8F7")
#ficha-conflicto("Aparece", [Las dos ramas han cambiado la misma línea y Git no va a elegir por ti.], errores: 1, historia: h-conflicto, lat-conflicto, diagrama-terminal(alto-fila: 22, (
  ("$ git merge salto", tenue, none),
  ("Auto-merging salto.py", tinta, none),
  ("CONFLICT (content): Merge conflict in salto.py", rojo, none),
  ("Automatic merge failed; fix conflicts and then", tinta, none),
  ("commit the result.", tinta, none),
)))
#ficha-conflicto("En el archivo", [Arriba lo tuyo y abajo lo que llega. VS Code te pone botones para elegir.], errores: 1, historia: h-conflicto, lat-conflicto, panel("salto.py", 494, 144, stack(dir: ttb,
  lineas-codigo(((none, tenue, "def saltar():"),)),
  box(width: 100%, height: 15pt, inset: (x: 8pt), align(horizon, t("Accept Current Change | Accept Incoming Change | Accept Both Changes | Compare Changes", size: 7pt, fill: azul-texto, weight: "medium"))),
  lineas-codigo((
    (verde-c, verde, "<<<<<<< HEAD  (lo tuyo)"),
    (verde-c, tinta, "    altura = 12"),
    (none, tenue, "======="),
    (azul-c, tinta, "    altura = 15"),
    (azul-c, azul-gul, ">>>>>>> salto  (lo que llega)"),
  )),
)))
#ficha-conflicto("Resuelto", [Deja el archivo como quieras, haz `add` y termina el merge.], historia: (cg("Merge salto", ramas: ("main",), nuevo: true, padres: (1, 2)), cg("Salto medio", padres: (3,)), cg("Salto alto", carril: 1, ramas: ("salto",), padres: (3,)), cg("Añade enemigos")), lateral-boton("Continue", [Dale al `+` del archivo y este botón termina el merge.]), panel("salto.py", 494, 144, lineas-codigo((
  (none, tenue, "def saltar():"),
  (verde-c, tinta, "    altura = 15"),
  (none, tenue, "    return altura"),
))))

// ============ Ejercicio 2 ============
#ejercicio("ejercicio-2", "Ejercicio 2: ramas y conflicto", [Unos 10 minutos, en el mismo repo. Vas a liarla a propósito.], (
  ([Crea una rama], "git switch -c experimento"),
  ([Cambia la línea 1 de `hola.txt` y guarda], `git commit -am "Versión A"`.text),
  ([Vuelve a `main`], "git switch main"),
  ([Cambia la misma línea, con otro texto, y guarda], `git commit -am "Versión B"`.text),
  ([Haz el merge y te saltará el conflicto], "git merge experimento"),
  ([Resuélvelo en VS Code, termina el merge y súbelo], "git add hola.txt; git commit --no-edit; git push"),
), [Con `git log --oneline --graph` ves cómo se juntan las dos ramas.])

// ============ Cierre ============
#qr-slides

#let col(titulo, cuerpo, pie) = box(width: 200pt, height: 225pt, {
  en(0, 0, box(width: 200pt, align(center, t(titulo, size: 13pt, weight: "semibold"))))
  en(35, 24, box(width: 130pt, height: 130pt, cuerpo))
  en(0, 166, box(width: 200pt, align(center, t(pie, size: 9.5pt, fill: gris))))
})
#diapo("gracias", "¡Gracias!", [Esto es lo siguiente que tenemos.], {
  en(0, 10, grid(columns: 3, column-gutter: 27pt,
    col("Nuevo taller de Git",
      rect(width: 100%, height: 100%, stroke: 1.5pt + azul, align(center + horizon, t("PRÓXIMAMENTE", size: 11pt, fill: azul-texto, weight: "bold"))),
      [¡Estad atentos!]),
    col("AISC x Google",
      image("img/qr-evento50.svg", width: 100%),
      [Inside Google: Ciberseguridad y Datos \ 10/11 · 14:15 · Aula 2.3.A03]),
    col("Telegram del GUL",
      image("img/qr-telegram-gul.svg", width: 100%),
      link("https://t.me/+nOvlp5l8yFU0MDA0", t("t.me/+nOvlp5l8yFU0MDA0", size: 9.5pt, font: mono, fill: gris))),
  ))
  en(0, 228, box(width: ancho-libre * 1pt, align(center, { link("https://aiscmadrid.com", t("aiscmadrid.com", size: 11pt, font: mono)); h(30pt); link("https://gul.uc3m.es", t("gul.uc3m.es", size: 11pt, font: mono)) })))
})
