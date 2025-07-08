const [num, setNum] = signal(0);

const dec = document.createElement("button");
dec.textContent = "Minus";
const decFun = () => { setNum(num() - 1); };
dec.addEventListener("click", decFun);

const inc = document.createElement("button");
inc.textContent = "Plus";
const incFun = () => { setNum(num() + 1); };
inc.addEventListener("click", incFun);

const count = document.createElement("h1");
count.textContent = num();
effect(() => count.textContent= num());

document.body.appendChild(dec);
document.body.appendChild(count);
document.body.appendChild(inc);

