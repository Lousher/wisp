var num = 0;

const c = document.getElementById("count");


c.textContent = 0;

const incFun = () => { num += 1; c.textContent = num; };
const decFun = () => { num -= 1; c.textContent = num; };

const d = document.getElementById("dec");
const i = document.getElementById("inc");

d.addEventListener("click", decFun);
i.addEventListener("click", incFun);

