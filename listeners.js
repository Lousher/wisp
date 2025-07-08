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

