// Plantilla común de las charlas de Git: cada ficha es una ventana de VS Code oscura.
//   Barra lateral = dónde se hace con botones · Editor = qué pasa (diagrama) · Terminal = cómo se escribe.
// Compilar con: typst compile --font-path fonts <charla>.typ

// Colores: VS Code claro + los del cartel del evento (azul degradado, blanco y amarillo).
// Azul = la acción y la rama principal. Amarillo = "mira aquí": lo nuevo, la otra rama, el botón.
// En el cartel el amarillo va sobre azul; sobre blanco no se lee, así que aquí solo rellena o marca.
#let azul = rgb("#2F86E0")
#let azul-texto = rgb("#1460B8")
#let azul-oscuro = rgb("#1A63B8")
#let dorado = rgb("#F2C500")
#let amarillo-fondo = rgb("#FFE44D")
#let amarillo-cartel = rgb("#FFFF18")
#let degradado-cartel = gradient.linear(rgb("#57AEFF"), rgb("#207FD5"), angle: 25deg)
#let azul-gul = azul
#let rojo = rgb("#C93C37")
#let ambar = rgb("#9A6700")
#let verde = rgb("#2E7D32")
#let tinta = rgb("#1F1F1F")
#let gris = rgb("#505050")
#let tenue = rgb("#767676")
#let linea = rgb("#BDBDBD")
#let c-editor = white
#let c-lateral = rgb("#F0F0F0")
#let c-actividad = rgb("#E2E2E2")
#let c-titulo = rgb("#D9D9D9")
#let c-pestanas = rgb("#E9E9E9")
#let c-seccion = rgb("#E2E2E2")
#let c-seleccion = rgb("#CFE6FA")
#let c-boton = azul-gul
#let sans = "Inter"
#let mono = "JetBrains Mono"
#let iconos = "Symbols Nerd Font Mono"

// Retícula (pt).
#let ancho-actividad = 34
#let x-editor = 194
#let x-texto = 210
#let x-fin = 704
#let y-panel = 264
#let y-estado = 386

#let t(body, size: 10pt, fill: tinta, font: sans, weight: "regular") = {
  show raw: set text(font: mono, size: size)
  text(font: font, size: size, fill: fill, weight: weight, top-edge: "cap-height", bottom-edge: "baseline", body)
}
#let ic(cp, size: 10pt, fill: gris) = t(str.from-unicode(cp), size: size, fill: fill, font: iconos)
#let en(x, y, body) = place(dx: x * 1pt, dy: y * 1pt, body)
#let bloque(x, y, w, h, color) = en(x, y, rect(width: w * 1pt, height: h * 1pt, fill: color, stroke: none))

// Ventana: barra de título, actividad con logos, pestaña, migas y barra de estado.
#let ventana(pestana, zona, errores: 0, avisos: 0, x-ed: x-editor) = {
  bloque(0, 0, 720, 405, c-editor)
  bloque(0, 0, 720, 22, c-titulo)
  for (i, c) in ("#FF5F57", "#FEBC2E", "#28C840").enumerate() { en(10 + i * 14, 7, circle(radius: 4pt, fill: rgb(c))) }
  en(0, 7.5, box(width: 720pt, align(center, t("taller-git - Visual Studio Code", size: 8pt, fill: gris))))
  // Barra de actividad: control de código activo, logos abajo (donde VS Code pone la cuenta).
  bloque(0, 22, ancho-actividad, y-estado - 22, c-actividad)
  for (i, cp) in (0xEAF0, 0xEA6D, 0xEA68, 0xEB91, 0xEAE6).enumerate() {
    let on = cp == 0xEA68
    if on { bloque(0, 28 + i * 28, 2, 24, tinta) }
    en(0, 34 + i * 28, box(width: ancho-actividad * 1pt, align(center, ic(cp, size: 14pt, fill: if on { tinta } else { tenue }))))
  }
  en(5, 324, image("img/image6.png", width: 24pt))
  en(5, 354, image("img/image5.png", width: 24pt))
  // Pestaña actual.
  let ancho-pestana = 105
  bloque(x-ed, 22, 720 - x-ed, 22, c-pestanas)
  bloque(x-ed, 22, ancho-pestana, 22, c-editor)
  bloque(x-ed, 22, ancho-pestana, 1.5, azul)
  en(x-ed + 10, 30, ic(0xEA68, size: 9pt, fill: azul-texto))
  en(x-ed + 24, 30, t(pestana, size: 8.5pt, font: mono))
  // Migas: dónde actúa el comando.
  let zonas = ("Trabajo", "Stage", "Local", "Remoto")
  if zona != none { en(x-texto, 49, zonas.enumerate().map(((i, z)) => {
    let on = if type(zona) == array { z in zona } else { z == zona }
    t(z, size: 7pt, fill: if on { azul-texto } else { tenue }, weight: if on { "semibold" } else { "regular" })
    if i < 3 { h(3pt); t("›", size: 7pt, fill: tenue); h(3pt) }
  }).join()) }
  // Barra de estado en el azul del GUL.
  bloque(0, y-estado, 720, 19, azul-gul)
  // Contadores de errores y avisos: con algo que contar se ponen en rojo, como en VS Code.
  let contador(cp, n) = box(height: 19pt, fill: if n > 0 { rojo } else { none }, inset: (x: 5pt), align(horizon, { ic(cp, size: 8.5pt, fill: white); h(3pt); t(str(n), size: 8pt, fill: white) }))
  en(8, y-estado, box(height: 19pt, align(horizon, {
    ic(0xEA68, size: 8.5pt, fill: white); h(4pt); t("main", size: 8pt, fill: white); h(4pt); ic(0xEA77, size: 8.5pt, fill: white); h(8pt)
    contador(0xEA87, errores); contador(0xEA6C, avisos); h(10pt)
    t("AISC x GUL UC3M", size: 8pt, fill: white)
  })))
  en(560, y-estado + 6, box(width: 150pt, align(right, t(context [Diapositiva #counter(page).display() / #counter(page).final().first()], size: 8pt, fill: white))))
}

// Barra lateral. Mientras no haya captura se dibuja una imitación: captura: image(...) la sustituye.
#let lateral(titulo, cuerpo) = {
  bloque(ancho-actividad, 22, x-editor - ancho-actividad, y-estado - 22, c-lateral)
  en(ancho-actividad + 12, 32, t(titulo, size: 7.5pt, fill: gris, weight: "medium"))
  en(ancho-actividad, 50, box(width: (x-editor - ancho-actividad) * 1pt, cuerpo))
}

// Grafo de la barra lateral: la historia del repo a lo largo de la charla.
// Filas de la más nueva a la más vieja. Sin padres, cada una cuelga de la siguiente.
#let cg(msg, carril: 0, ramas: (), nuevo: false, padres: none) = (msg: msg, carril: carril, ramas: ramas, nuevo: nuevo, padres: padres)
#let grafo-lateral(historia) = {
  let (x0, y0, alto) = (ancho-actividad, y-panel, 19)
  let color-carril(c) = if c == 0 { azul } else { dorado }
  let color-rama(r) = if r == "main" { azul } else if r == "salto" { dorado } else { tenue }
  let cx(c) = x0 + 15 + c * 11
  let cy(i) = y0 + 30 + i * alto
  bloque(x0, y0, x-editor - x0, 0.8, linea)
  en(x0 + 12, y0 + 8, t("GRAPH", size: 7.5pt, fill: gris, weight: "medium"))
  if type(historia) == str {
    en(x0 + 12, y0 + 26, t(historia, size: 8pt, fill: tenue))
  } else {
    for (i, f) in historia.enumerate() {
      let padres = if f.padres != none { f.padres } else if i + 1 < historia.len() { (i + 1,) } else { () }
      for j in padres {
        let o = historia.at(j)
        en(0, 0, line(start: (cx(f.carril) * 1pt, cy(i) * 1pt), end: (cx(o.carril) * 1pt, cy(j) * 1pt), stroke: 1.2pt + color-carril(calc.max(f.carril, o.carril))))
      }
    }
    for (i, f) in historia.enumerate() {
      en(cx(f.carril) - 3.5, cy(i) - 3.5, circle(radius: 3.5pt, fill: if f.nuevo { dorado } else { color-carril(f.carril) }, stroke: 1pt + c-lateral))
      en(x0 + 32, cy(i) - 3, t(f.msg, size: 7.5pt, weight: if f.nuevo { "semibold" } else { "regular" }))
      en(x-editor - 8 - 70, cy(i) - 5.5, box(width: 70pt, align(right, f.ramas.map(r => box(height: 11pt, fill: color-rama(r), inset: (x: 3pt), align(horizon, t(r, size: 6.5pt, font: mono, weight: "bold", fill: if r == "salto" { tinta } else { white })))).join(h(2pt)))))
    }
  }
}

// Terminal: la sintaxis manda; sus flags van debajo como su ayuda; a la derecha, avisos.
// Sin sintaxis (none), las flags pasan a ser lo principal y las secundarias van debajo, más discretas.
#let terminal(sintaxis, flags, ojo, deshacer, etiqueta: "TERMINAL", secundarias: ()) = {
  bloque(x-editor, y-panel, 720 - x-editor, 0.8, linea)
  en(x-texto, y-panel + 8, t(etiqueta, size: 7.5pt, fill: tenue, weight: "medium"))
  bloque(x-texto, y-panel + 18, 41, 1, tenue)
  // Las flags empiezan justo debajo de "git": cuelgan del comando, no del $.
  let sangria = 15
  if sintaxis != none {
    en(x-texto, y-panel + 32, {
      show regex("<[^>]+>"): set text(fill: azul-texto)
      t("$", size: 15pt, font: mono, fill: tenue)
      h(6pt)
      t(sintaxis, size: 15pt, font: mono, weight: "medium")
    })
    en(x-texto + sangria, y-panel + 60, grid(columns: (auto, auto), column-gutter: 14pt, row-gutter: 9pt,
      ..flags.map(((f, d)) => (t(f, size: 10pt, font: mono, weight: "medium"), t(d, size: 9.5pt, fill: gris))).flatten()))
  } else {
    en(x-texto, y-panel + 30, grid(columns: (100pt, auto), column-gutter: 12pt, row-gutter: 11pt,
      ..flags.map(((f, d)) => (t(f, size: 13pt, font: mono, weight: "medium"), t(d, size: 10pt, fill: gris))).flatten(),
      ..secundarias.map(((f, d)) => (t(f, size: 9pt, font: mono, fill: tenue), t(d, size: 8.5pt, fill: tenue))).flatten()))
  }
  bloque(548, y-panel + 8, 0.8, y-estado - y-panel - 16, linea)
  let aviso(y, icono, color, titulo, body) = en(558, y, box(width: 146pt, {
    set par(leading: 0.55em)
    ic(icono, size: 9pt, fill: color); h(5pt); t(titulo, size: 8.5pt, fill: color, weight: "semibold")
    v(6pt)
    t(body, size: 8.5pt)
  }))
  aviso(y-panel + 10, 0xF071, ambar, "Cuidado", ojo)
  if deshacer != none { aviso(y-panel + 62, 0xF0E2, azul-texto, "Deshacer", deshacer) }
}

// Ficha de un comando (una página por paso).
//   titulo: lo que consigues · paso: "Antes" | ... · texto: qué ocurre en este paso.
#let ficha(pestana, titulo, sintaxis, zona, flags, paso, texto, diagrama, lateral-titulo: "SOURCE CONTROL", captura: none, ojo: [], deshacer: none, errores: 0, avisos: 0, historia: none, etiqueta-panel: "TERMINAL", secundarias: ()) = {
  pagebreak(weak: true)
  set par(leading: 0.5em, spacing: 0pt)
  ventana(pestana, zona, errores: errores, avisos: avisos)
  lateral(lateral-titulo, captura)
  if historia != none { grafo-lateral(historia) }
  en(x-texto, 63, t(titulo, size: 24pt, weight: "semibold"))
  en(x-texto, 88, { t(upper(paso), size: 7.5pt, fill: azul-texto, weight: "bold"); h(7pt); t(texto, size: 9pt, fill: gris) })
  en(x-texto, 107, box(width: (x-fin - x-texto) * 1pt, height: 144pt, diagrama))
  terminal(sintaxis, flags, ojo, deshacer, etiqueta: etiqueta-panel, secundarias: secundarias)
}

// Flecha recta de (x1, y1) a (x2, y2), en puntos dentro del diagrama.
#let flecha(x1, y1, x2, y2, color: gris, grosor: 1.4pt, dash: "solid") = {
  let a = calc.atan2(x2 - x1, y2 - y1)
  let (l, w) = (7, 3.5)
  let p(dx, dy) = ((x2 + dx * calc.cos(a) - dy * calc.sin(a)) * 1pt, (y2 + dx * calc.sin(a) + dy * calc.cos(a)) * 1pt)
  place(line(start: (x1 * 1pt, y1 * 1pt), end: p(-l, 0), stroke: (paint: color, thickness: grosor, dash: dash)))
  place(polygon(fill: color, p(0, 0), p(-l, -w), p(-l, w)))
}

// Diagrama de zonas: paneles rectos como los de VS Code, con la flecha del comando en azul.
// vuelta: flechas hacia la izquierda, (zona origen, zona destino, etiqueta) con zonas numeradas de 0 a 3.
#let diagrama-zonas(contenido, activa: none, vuelta: ()) = {
  let (w, g, alto) = (98, 34, 144)
  let sub = (Trabajo: "tus archivos", Stage: "lo preparado", Local: "tu historial", Remoto: "GitHub")
  let etiquetas = ("add", "commit", "push")
  for (i, z) in ("Trabajo", "Stage", "Local", "Remoto").enumerate() {
    let x = i * (w + g)
    en(x, 0, box(width: w * 1pt, height: alto * 1pt, fill: c-lateral, stroke: 0.8pt + linea, {
      place(dx: 8pt, dy: 9pt, t(z, size: 10.5pt, weight: "semibold"))
      place(dx: 8pt, dy: 23pt, t(sub.at(z), size: 8pt, fill: gris))
      place(dy: 39pt, box(width: 100%, contenido.at(z, default: [])))
    }))
    if i < 3 {
      let on = etiquetas.at(i) == activa
      let color = if on { azul } else { tenue }
      en(x + w, 60, box(width: g * 1pt, align(center, t(etiquetas.at(i), size: 8pt, font: mono, fill: if on { azul-texto } else { gris }, weight: if on { "bold" } else { "regular" }))))
      flecha(x + w + 4, 74, x + w + g - 4, 74, color: color, grosor: if on { 2pt } else { 1pt })
    }
  }
  for (desde, hasta, etiqueta) in vuelta {
    let (xd, xh) = (desde * (w + g), hasta * (w + g) + w)
    en(xd - g, 106, box(width: g * 1pt, align(center, t(etiqueta, size: 8pt, font: mono, fill: azul-texto, weight: "bold"))))
    flecha(xd - 4, 120, xh + 4, 120, color: azul, grosor: 2pt)
  }
}

// Filas dentro de una zona o de la barra lateral.
#let fila-archivo(nombre, estado: none, color: verde, ancho: 98, marcada: false, mas: false, apagada: false) = box(width: ancho * 1pt, height: 17pt, inset: (x: 8pt), fill: if marcada { c-seleccion } else { none }, stroke: if marcada { 2pt + dorado } else { none }, {
  place(horizon, ic(0xEA7B, size: 9pt, fill: if apagada { tenue } else { gris }))
  place(horizon, dx: 13pt, t(nombre, size: 8.5pt, font: mono, fill: if apagada { tenue } else { tinta }))
  if mas { place(horizon + right, dx: -13pt, t("+", size: 11pt, font: mono, fill: azul-texto, weight: "bold")) }
  if estado != none { place(horizon + right, t(estado, size: 8.5pt, font: mono, fill: color, weight: "bold")) }
})
#let fila-version(id, msg, nuevo: false, borrado: false) = box(width: 98pt, height: 30pt, fill: if nuevo { amarillo-fondo } else { none }, inset: (x: 8pt), {
  let color(c) = if nuevo { tinta } else if borrado { tenue } else { c }
  let marca(x) = if borrado { strike(stroke: 1pt + rojo, x) } else { x }
  place(dy: 7pt, marca(t(id, size: 8.5pt, font: mono, weight: "bold", fill: color(tinta))))
  place(dy: 19pt, marca(t(msg, size: 7.5pt, fill: color(gris))))
})
#let filas(..items) = stack(dir: ttb, ..items)
#let en-gris(texto) = box(width: 100%, inset: (x: 8pt, y: 5pt), t(texto, size: 8pt, fill: tenue))
#let vacio = en-gris("(vacío)")

// Grafo con carriles de color, como las extensiones de historial de VS Code.
// nodos: id -> (x, y, color, relleno?). aristas: (de, a, color). ramas: (texto, x, y, color).
#let diagrama-grafo(nodos, aristas, ramas: (), extra: none) = {
  let r = 11
  for (a, b, color) in aristas {
    let (p, q) = (nodos.at(a), nodos.at(b))
    place(line(start: (p.at(0) * 1pt, p.at(1) * 1pt), end: (q.at(0) * 1pt, q.at(1) * 1pt), stroke: 2pt + color))
  }
  if extra != none { extra }
  for (id, n) in nodos {
    let lleno = n.len() > 3 and n.at(3)
    en(n.at(0) - r, n.at(1) - r, circle(radius: r * 1pt, fill: if lleno { n.at(2) } else { c-editor }, stroke: 2pt + n.at(2),
      align(center + horizon, t(id, size: 9pt, font: mono, weight: "bold", fill: if lleno and n.at(2) != dorado { white } else { tinta }))))
  }
  for (nombre, x, y, color) in ramas {
    en(x, y, box(height: 16pt, fill: color, inset: (x: 6pt), align(horizon, t(nombre, size: 8.5pt, font: mono, fill: if color == dorado { tinta } else { white }, weight: "bold"))))
  }
}

// Imitaciones de la barra lateral de control de código.
#let seccion(titulo, n: none) = box(width: 100%, height: 18pt, fill: c-seccion, inset: (x: 8pt), {
  place(horizon, t(titulo, size: 7pt, weight: "semibold"))
  if n != none { place(horizon + right, t(str(n), size: 7.5pt, fill: gris)) }
})
#let lateral-commit = stack(dir: ttb, spacing: 8pt,
  box(inset: (x: 10pt), width: 100%, stack(dir: ttb, spacing: 6pt,
    box(width: 100%, height: 24pt, fill: white, stroke: 0.8pt + linea, inset: (x: 7pt), align(horizon, t("Mario salta", size: 8.5pt))),
    box(width: 100%, height: 24pt, fill: c-boton, stroke: 2pt + dorado, align(center + horizon, { ic(0xEAB2, size: 9pt, fill: white); h(4pt); t("Commit", size: 8.5pt, fill: white, weight: "semibold") })),
  )),
  stack(dir: ttb,
    seccion("STAGED CHANGES", n: 2),
    fila-archivo("salto.py", estado: "A", ancho: 160),
    fila-archivo("fuego.py", estado: "A", ancho: 160),
    v(6pt),
    seccion("CHANGES", n: 1),
    fila-archivo("notas.txt", estado: "U", color: ambar, ancho: 160),
  ),
)
// Para lo que no tiene botón a la vista: pasos reales con la paleta de comandos.
#let tecla(k) = box(height: 15pt, fill: white, stroke: 0.8pt + linea, inset: (x: 4pt), align(horizon, t(k, size: 7.5pt, font: mono, weight: "medium")))
#let paso-lateral(n, texto) = box(width: 100%, inset: (x: 12pt), { t(str(n), size: 8.5pt, fill: azul-texto, weight: "bold"); h(6pt); t(texto, size: 8.5pt, weight: "medium") })
#let lateral-paleta(comando, titulo-opciones, opciones, marcada, alternativa) = {
  let bloques = (
    paso-lateral(1, "Abre la paleta"),
    box(width: 100%, inset: (x: 12pt), { tecla("Ctrl"); h(3pt); tecla("Shift"); h(3pt); tecla("P") }),
    v(10pt),
    paso-lateral(2, "Escribe el comando"),
    box(width: 100%, inset: (x: 12pt), box(width: 100%, height: 22pt, fill: white, stroke: 0.8pt + linea, inset: (x: 6pt), align(horizon, t(">" + comando, size: 8pt, font: mono)))),
    v(10pt),
  )
  if opciones.len() > 0 {
    bloques += (
      paso-lateral(3, titulo-opciones),
      box(width: 100%, inset: (x: 12pt), stack(dir: ttb, ..opciones.map(o => {
        let on = o == marcada
        box(width: 100%, height: 20pt, inset: (x: 6pt), fill: if on { c-seleccion } else { none }, stroke: if on { 2pt + dorado } else { none }, align(horizon, t(o, size: 8.5pt, font: mono, weight: if on { "semibold" } else { "regular" })))
      }))),
      v(10pt),
    )
  }
  bloques.push(box(width: 100%, inset: (x: 12pt), { set par(leading: 0.55em); t(alternativa, size: 7.5pt, fill: gris) }))
  stack(dir: ttb, spacing: 8pt, ..bloques)
}

// Barra lateral: botón principal real de VS Code y una nota de cuándo aparece.
#let nota-lateral(body) = box(width: 100%, inset: (x: 12pt), { set par(leading: 0.55em); t(body, size: 8pt, fill: gris) })
#let lateral-boton(texto, nota) = stack(dir: ttb, spacing: 10pt,
  box(inset: (x: 10pt), width: 100%, box(width: 100%, height: 24pt, fill: c-boton, stroke: 2pt + dorado, align(center + horizon, t(texto, size: 8.5pt, fill: white, weight: "semibold")))),
  nota-lateral(nota),
)
// Barra lateral: lista de cambios por secciones y nota debajo.
#let lateral-lista(secciones, nota: none) = stack(dir: ttb, spacing: 8pt, stack(dir: ttb, spacing: 4pt, ..secciones.map(((titulo, filas)) => stack(dir: ttb, seccion(titulo, n: filas.len()), ..filas))), if nota != none { nota-lateral(nota) })
// Barra lateral: vista de historial.
#let fila-historia(msg, etiqueta: none, color: azul) = box(width: 100%, height: 19pt, inset: (x: 10pt), {
  place(horizon, circle(radius: 3pt, fill: color))
  place(horizon, dx: 12pt, t(msg, size: 8pt))
  if etiqueta != none { place(horizon + right, box(height: 12pt, fill: color, inset: (x: 3pt), align(horizon, t(etiqueta, size: 6.5pt, font: mono, weight: "bold", fill: white)))) }
})

// Panel recto con título, para diagramas que no son zonas ni grafo.
#let panel(titulo, ancho, alto, cuerpo) = box(width: ancho * 1pt, height: alto * 1pt, fill: c-lateral, stroke: 0.8pt + linea, {
  place(dx: 8pt, dy: 8pt, t(titulo, size: 8.5pt, font: mono, weight: "semibold"))
  place(dy: 24pt, box(width: 100%, cuerpo))
})
// Salida de terminal anotada. lineas: (texto, color, nota). Solo se anotan las que importan.
#let diagrama-terminal(lineas, alto-fila: 18) = box(width: 494pt, height: 144pt, fill: c-lateral, stroke: 0.8pt + linea, {
  for (i, (texto, color, nota)) in lineas.enumerate() {
    let y = 12 + i * alto-fila
    en(12, y, t(texto, size: 9pt, font: mono, fill: color))
    if nota != none {
      en(268, y + 4, line(length: 12pt, stroke: 1pt + azul))
      en(286, y, t(nota, size: 9pt, weight: "medium"))
    }
  }
})
// Cambios de un archivo con el rojo y verde de VS Code. lineas: (tipo, texto) con tipo "+", "-" o " ".
#let diagrama-diff(archivo, lineas) = panel(archivo, 494, 144, stack(dir: ttb, ..lineas.map(((tipo, texto)) => {
  let fondo = if tipo == "+" { rgb("#D3F0D6") } else if tipo == "-" { rgb("#F9D6D5") } else { none }
  let color = if tipo == "+" { verde } else if tipo == "-" { rojo } else { tenue }
  box(width: 100%, height: 20pt, fill: fondo, inset: (x: 8pt), {
    place(horizon, t(tipo, size: 10pt, font: mono, fill: color, weight: "bold"))
    place(horizon, dx: 16pt, t(texto, size: 10pt, font: mono))
  })
})))

// Barra lateral: la rama actual en la barra de estado, que también sirve para cambiar de rama.
#let lateral-barra(rama, nota) = stack(dir: ttb, spacing: 10pt,
  box(inset: (x: 10pt), width: 100%, box(width: 100%, height: 22pt, fill: azul-gul, stroke: 2pt + dorado, inset: (x: 8pt), align(left + horizon, { ic(0xEA68, size: 9pt, fill: white); h(5pt); t(rama, size: 9pt, fill: white, font: mono, weight: "medium") }))),
  nota-lateral(nota),
)
// Texto de marcas bajo un nodo del grafo.
#let bajo-nodo(x, y, texto) = en(x - 30, y, box(width: 60pt, align(center, t(texto, size: 8pt, font: mono, fill: gris))))
// Código con fondos por línea. lineas: (color de fondo o none, color de texto, texto).
#let lineas-codigo(lineas) = stack(dir: ttb, ..lineas.map(((fondo, color, texto)) => box(width: 100%, height: 17pt, fill: fondo, inset: (x: 8pt), align(left + horizon, t(texto, size: 9.5pt, font: mono, fill: color)))))

// Diapositiva sin comando (intro, teoría, ejercicios, cierre): solo editor a todo el ancho.
#let x-libre = 50
#let ancho-libre = 654
#let diapo(pestana, titulo, texto, cuerpo) = {
  pagebreak(weak: true)
  set par(leading: 0.5em, spacing: 0pt)
  ventana(pestana, none, x-ed: ancho-actividad)
  if titulo != none { en(x-libre, 58, t(titulo, size: 24pt, weight: "semibold")) }
  if texto != none { en(x-libre, 83, t(texto, size: 10pt, fill: gris)) }
  en(x-libre, 106, box(width: ancho-libre * 1pt, height: 268pt, cuerpo))
}
// Icono de "toca practicar": la silueta de GitHub en blanco sobre azul, como en el cartel.
#let icono-practica(lado) = box(width: lado * 1pt, height: lado * 1pt, fill: azul, align(center + horizon, t(str.from-unicode(0xF09B), size: lado * 0.66pt, fill: white, font: iconos)))
// Ejercicio: pasos con su comando y qué debes ver al final.
#let ejercicio(pestana, titulo, texto, pasos, resultado) = diapo(pestana, titulo, texto, {
  en(ancho-libre - 46, -58, icono-practica(46))
  for (i, (descripcion, comando)) in pasos.enumerate() {
    let y = i * 33
    bloque(0, y, ancho-libre, 28, if calc.even(i) { c-lateral } else { white })
    en(10, y + 10, t(str(i + 1), size: 11pt, fill: azul-texto, weight: "bold"))
    en(28, y + 10, t(descripcion, size: 10pt))
    if comando != none { en(310, y + 10, { show regex("<[^>]+>"): set text(fill: azul-texto); t(comando, size: 9.5pt, font: mono, weight: "medium") }) }
  }
  let y = pasos.len() * 33 + 6
  en(0, y, box(width: ancho-libre * 1pt, height: 30pt, stroke: (left: 2.5pt + azul), inset: (left: 12pt), align(left + horizon, { t("Al terminar  ", size: 9pt, fill: azul-texto, weight: "bold"); t(resultado, size: 10pt) })))
})

// Portadas: bloque azul arriba y franja blanca abajo, donde los logos se ven limpios.
#let y-franja = 300
#let logos-franja = {
  en(622, y-franja + 35, image("img/image6.png", height: 34pt))
  bloque(663, y-franja + 39, 0.8, 26, linea)
  en(671, y-franja + 34, image("img/image5.png", height: 36pt))
}
// Tramo curvo de grafo, con el aire de las líneas de un historial.
#let tramo(x1, y1, x2, y2, color, grosor: 2.5pt) = {
  let medio = (x1 + x2) / 2
  place(curve(stroke: (paint: color, thickness: grosor, cap: "round"),
    curve.move((x1 * 1pt, y1 * 1pt)),
    curve.cubic((medio * 1pt, y1 * 1pt), (medio * 1pt, y2 * 1pt), (x2 * 1pt, y2 * 1pt))))
}
#let recta(x1, y1, x2, y2, color, grosor: 2.5pt) = place(line(start: (x1 * 1pt, y1 * 1pt), end: (x2 * 1pt, y2 * 1pt), stroke: (paint: color, thickness: grosor, cap: "round")))
#let nudo(x, y, r, relleno, borde: none, grosor: 2.5pt) = en(x - r, y - r, circle(radius: r * 1pt, fill: relleno, stroke: if borde == none { none } else { grosor + borde }))

// Portada de la charla: el grafo como ilustración, saliendo por la derecha.
#let portada-charla(antetitulo, titulo, pie) = {
  pagebreak(weak: true)
  set par(leading: 0.5em, spacing: 0pt)
  set text(tracking: -0.015em)
  bloque(0, 0, 720, 405, white)
  bloque(0, 0, 720, y-franja, degradado-cartel)
  // Rama principal en blanco y dos ramas que se abren sin cruzarse.
  let (g, y1, y2, y3, r) = (7pt, 78, 166, 254, 14)
  let oscuro = azul-oscuro
  tramo(486, y1, 576, y3, oscuro, grosor: g)
  recta(576, y3, 720, y3, oscuro, grosor: g)
  tramo(566, y1, 646, y2, amarillo-cartel, grosor: g)
  recta(646, y2, 720, y2, amarillo-cartel, grosor: g)
  recta(486, y1, 720, y1, white, grosor: g)
  for x in (486, 566, 646) { nudo(x, y1, r, white) }
  nudo(646, y2, r, amarillo-cartel)
  for x in (606, 686) { nudo(x, y3, r, oscuro) }
  en(56, 134, t(antetitulo, size: 20pt, fill: amarillo-cartel, weight: "semibold"))
  en(56, 170, t(titulo, size: 66pt, fill: white, weight: "bold"))
  en(56, y-franja + 44, t(pie, size: 14pt, weight: "semibold"))
  logos-franja
}

// Portadilla de capítulo. nombres: los capítulos de la charla, para dibujar el recorrido.
// abre: tras qué capítulo se abre el recorrido en dos carriles (por defecto, antes del último; none, nunca).
#let portada(numero, titulo, nombres, contenido: none, abre: auto) = {
  pagebreak(weak: true)
  set par(leading: 0.5em, spacing: 0pt)
  set text(tracking: -0.015em)
  let actual = int(numero) - 1
  bloque(0, 0, 720, 405, white)
  bloque(0, 0, 720, y-franja, degradado-cartel)
  // Número enorme, tono sobre tono y recortado por el bloque.
  en(0, 0, box(width: 720pt, height: y-franja * 1pt, clip: true, place(right + bottom, dx: -20pt, dy: 34pt, text(font: sans, size: 290pt, weight: "bold", fill: rgb(255, 255, 255, 38), tracking: -0.04em, top-edge: "cap-height", bottom-edge: "baseline", numero))))
  en(56, 168, t(titulo, size: 50pt, fill: white, weight: "bold"))
  if contenido != none { en(56, 236, { set text(tracking: 0pt); t(contenido, size: 12pt, font: mono, fill: amarillo-cartel, weight: "medium") }) }
  // Recorrido de la charla.
  let (x0, paso, y) = (64, 490 / (nombres.len() - 1), y-franja + 44)
  let bifurca = if abre == auto { nombres.len() - 2 } else { abre }
  let px(i) = x0 + i * paso
  let hecho = azul
  let falta = rgb("#CFCFCF")
  for i in range(nombres.len() - 1) {
    let color = if i < actual { hecho } else { falta }
    if i == bifurca {
      tramo(px(i), y, px(i) + paso / 2, y - 13, color)
      tramo(px(i), y, px(i) + paso / 2, y + 13, color)
      tramo(px(i) + paso / 2, y - 13, px(i + 1), y, color)
      tramo(px(i) + paso / 2, y + 13, px(i + 1), y, color)
    } else {
      recta(px(i), y, px(i + 1), y, color)
    }
  }
  for (i, nombre) in nombres.enumerate() {
    if i == actual {
      nudo(px(i), y, 11, white, borde: azul, grosor: 2.5pt)
      nudo(px(i), y, 6, azul)
    } else if i < actual {
      nudo(px(i), y, 5.5, azul)
    } else {
      nudo(px(i), y, 5.5, white, borde: falta, grosor: 2pt)
    }
    en(px(i) - 45, y + 19, box(width: 90pt, align(center, { set text(tracking: 0pt); t(nombre, size: 8pt, fill: if i == actual { tinta } else if i < actual { gris } else { tenue }, weight: if i == actual { "bold" } else { "regular" }) })))
  }
  logos-franja
}

// Barra lateral para lo que solo se hace escribiendo: abre la terminal integrada.
#let lateral-terminal(nota) = stack(dir: ttb, spacing: 12pt,
  paso-lateral(1, "Abre la terminal"),
  box(width: 100%, inset: (x: 12pt), t("Terminal › New Terminal", size: 8.5pt, font: mono)),
  v(8pt),
  nota-lateral(nota),
)
