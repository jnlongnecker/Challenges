
/* === Solution to Challenge IV === */
const myList = [];

function addToList(item) {
    myList.push(item);
}

/* === Solution to Challenge V === */
function listAlert() {
    alert(myList);
}

/* === Solution to Challenge VI === */
let alertButton = document.querySelector("#alert-button");
alertButton.addEventListener("click", listAlert);

/* === Solution to Challenge VII === */
let inputBox = document.querySelector("#add-item-group > input");
let addButton = document.querySelector("#add-item-group > button");

addButton.addEventListener("click", () => {
    let userInput = inputBox.value;
    inputBox.value = "";
    addToList(userInput);
})