const dec = document.createElement("button");
dec.setAttribute("id","dec")
dec.textContent = "Minus";

const inc = document.createElement("button");
inc.setAttribute("id","inc")
inc.textContent = "Plus";

const count = document.createElement("h1");
count.setAttribute("id", "count")

document.body.appendChild(dec);
document.body.appendChild(count);
document.body.appendChild(inc);
