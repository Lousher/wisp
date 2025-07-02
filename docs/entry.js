window.addEventListener('load', function () {
  Scheme.load_main("main.wasm", {
    user_imports: {
      document: {
	body() { return document.body; },
	getElementById: Document.prototype.getElementById.bind(document),
	querySelector: Document.prototype.querySelector.bind(document),
	createElement: Document.prototype.createElement.bind(document),
	createTextNode: Document.prototype.createTextNode.bind(document),
	adoptedStyleSheets: (sheet) => { document.adoptedStyleSheets = [sheet]; },
      },
      element: {
	innerHTML: (e, htmlstr) => e.innerHTML = htmlstr,
	replaceChildren(e, c) { e.replaceChildren(c); },
	setAttribute(e, n, v) { e.setAttribute(n, v); },
	appendChild(parent, child) { return parent.appendChild(child); },
	insertAdjacentHTML(e, type, html) { return e.insertAdjacentHTML(type, html); },
	insertAdjacentElement(e, type,element) { return e.insertAdjacentElement(type, element); },
	textContent: (e, str) => e.textContent = str,
	addEventListener(e, name, f) { e.addEventListener(name,f); }
      },
      console: {
	log: (e) => console.log(e)
      },
      cssom: {
	CSSStyleSheet: (any) => { return new CSSStyleSheet(); },
	insertRule(css, style) { return css.insertRule(style); },
      },
      event: {
	target(ev) { return ev.target; },
      },
      target: {
	value(tr) { return tr.value; },
      }
    }
  })})
