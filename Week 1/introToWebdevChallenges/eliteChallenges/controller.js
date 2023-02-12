
/* === Solution to Elite Challenge I === */
const myList = [];
let timeout;
let inputBox = document.querySelector("#add-item-group > input");
let addButton = document.querySelector("#add-item-group > button");
let alertButton = document.querySelector("#alert-button");
let toast = document.querySelector("#toast");
let closeToastButton = document.querySelector("#close-toast");
let toastItems = document.querySelector("#toast ul");

closeToastButton.addEventListener("click", clearToast);
alertButton.addEventListener("click", listToast);
addButton.addEventListener("click", () => {
    let userInput = inputBox.value;
    inputBox.value = "";
    addToList(userInput);
});

function addToList(item) {
    myList.push(item);
}

function clearToast() {
    if (timeout) {
        clearTimeout(timeout);
        timeout = undefined;
    }
    toast.classList.remove("show");
    toast.classList.add("hide");
}

function listToast() {
    toastItems.innerHTML = "";
    for (let item of myList) {
        let newListItem = document.createElement("li");
        let itemText = document.createTextNode(item);
        newListItem.appendChild(itemText);
        toastItems.appendChild(newListItem);
    }

    toast.classList.remove("hide");
    toast.classList.add("show");
    timeout = setTimeout(() => {
        toast.classList.remove("show");
        toast.classList.add("hide");
    }, 5000);
}

/* === Solution to Elite Challenge II === */
let trashCanSVG = createCanSVG();
let cartInput = document.querySelector(".inputs > input");
let addCartButton = document.querySelector(".inputs > button");
let itemHolder = document.querySelector("#cart-items");

addCartButton.addEventListener("click", addToCart);

function addToCart() {
    let itemName = cartInput.value;
    cartInput.value = "";
    let newItem = createCartItem(itemName);
    itemHolder.appendChild(newItem);
}

function createCartItem(itemName) {
    let li = document.createElement("li");
    let itemNode = document.createTextNode(itemName);
    let checkbox = document.createElement("input");
    let canSVGCopy = trashCanSVG.cloneNode(true);
    checkbox.setAttribute("type", "checkbox");

    canSVGCopy.addEventListener("click", event => {
        let li = event.currentTarget.parentNode;
        li.parentNode.removeChild(li);
    });

    li.appendChild(checkbox);
    li.appendChild(itemNode);
    li.appendChild(canSVGCopy);

    return li;
}

// You can pretty much ignore this, I just wanted a nice SVG trash can icon
function createCanSVG() {
    let svg = document.createElementNS("http://www.w3.org/2000/svg", "svg");
    svg.setAttribute("width", "24");
    svg.setAttribute("height", "24");
    svg.setAttribute("viewBox", "0 0 24 24");
    let path = document.createElementNS("http://www.w3.org/2000/svg", "path");
    path.setAttribute("d", "M3 6v18h18v-18h-18zm5 14c0 .552-.448 1-1 1s-1-.448-1-1v-10c0-.552.448-1 1-1s1 .448 1 1v10zm5 0c0 .552-.448 1-1 1s-1-.448-1-1v-10c0-.552.448-1 1-1s1 .448 1 1v10zm5 0c0 .552-.448 1-1 1s-1-.448-1-1v-10c0-.552.448-1 1-1s1 .448 1 1v10zm4-18v2h-20v-2h5.711c.9 0 1.631-1.099 1.631-2h5.315c0 .901.73 2 1.631 2h5.712z");
    svg.appendChild(path);
    return svg;
}