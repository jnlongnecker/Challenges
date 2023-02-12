
/* === Solution to Elite Challenge I === */
let fetchButton = document.querySelector("#fetch-section > button");
let pokeInput = document.querySelector("#fetch-section > input");
let h1 = document.querySelector("#fetch-section > h1");
let p = document.querySelector("#fetch-section > p");
fetchButton.addEventListener("click", cleanAndFetch);

// Handles the event
function cleanAndFetch() {
    let userInput = pokeInput.value;
    pokeInput.value = "";
    passCleanedInput(userInput, fetchPoke);
}

// Decorator
function passCleanedInput(input, funcToRun) {
    if (typeof funcToRun !== "function") {
        throw "Error: Must input a function.";
    }

    let cleanedInput = clean(input);
    funcToRun(cleanedInput);
}

// Fetch request for pokemon
async function fetchPoke(pokemon) {
    let req = new Request("https://pokeapi.co/api/v2/pokemon/" + pokemon);
    let response = await fetch(req);
    if (!response.ok) {
        console.error(response.error);
        return;
    }
    let payload = await response.json();
    h1.innerText = payload.name;
    p.innerText = payload.stats[0].base_stat;
}

// Utility method to clean input
function clean(input) {
    input = input.toLowerCase();
    input = megaConversion(input);
    input = input.replace(" ", "-");
    return input;
}

// Starts the conversion for a mega pokemon
function megaConversion(input) {
    if (input.indexOf("mega") == -1) return input;

    // Don't skip Meganium
    if (input.indexOf("megan") != -1 || input == "mega") return input;

    return megaToKebab(input);
}

// Converts a normal readable mega name to a kebab pokeApi name
function megaToKebab(input) {
    input = input.replace("mega ", "");
    if (input.indexOf(" ") == -1) return input + "-mega";
    input = input.replace(" ", "-mega-");
    return input.replaceAll(" ", "-");
}