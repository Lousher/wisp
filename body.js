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

// copy from listeners.js
const [num, setNum] = signal(0);

const c = document.getElementById("count");

c.textContent = num();

effect(() => c.textContent= num());
const incFun = () => { setNum(num() + 1); };
const decFun = () => { setNum(num() - 1); };

const d = document.getElementById("dec");
const i = document.getElementById("inc");

d.addEventListener("click", decFun);
i.addEventListener("click", incFun);

