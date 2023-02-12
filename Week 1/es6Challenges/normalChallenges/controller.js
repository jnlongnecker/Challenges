
/* === Solution to Challenge I === */
let workingButton = document.querySelector("#working-section > button");
let workingHeading = document.querySelector("#working-section > h1");

workingButton.addEventListener("click", () => {
    workingHeading.innerText = "Working, Please Wait";
    setTimeout(() => {
        workingHeading.innerText = "Waiting";
    }, 5000);
})

/* === Solution to Challenge II === */
let fetchButton = document.querySelector("#fetch-section > button");
fetchButton.addEventListener("click", fetchPoke);

function fetchPoke() {
    let req = new Request("https://pokeapi.co/api/v2/pokemon/ditto");
    fetch(req).then(response => {
        response.json().then(payload => {
            alert(JSON.stringify(payload));
        })
    }).catch(error => {
        console.log(error.message);
    })
}


/* === Solution to Challenge III and IV === */
let h1 = document.querySelector("#fetch-section > h1");
let p = document.querySelector("#fetch-section > p");
fetchButton.addEventListener("click", fetchNido);

// Used only so I can keep the previous event listener and code in for your reference
fetchButton.removeEventListener("click", fetchPoke);

async function fetchNido() {
    let req = new Request("https://pokeapi.co/api/v2/pokemon/nidoking");
    let response = await fetch(req);
    if (!response.ok) {
        console.error(response.error);
        return;
    }
    let payload = await response.json();
    h1.innerText = payload.name;
    p.innerText = payload.stats[0].base_stat;
}

/* === Solution to Challenge V === */
let pokeInput = document.querySelector("#fetch-section > input");
fetchButton.addEventListener("click", fetchPoke);

// Used only so I can keep previous event listener and code in for your reference
fetchButton.removeEventListener("click", fetchNido);

async function fetchPoke() {
    let pokemon = pokeInput.value.toLowerCase();
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