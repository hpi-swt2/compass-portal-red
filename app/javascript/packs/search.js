function textEntered(field) {
    clearTimeout(this.timeout)
    let search = true;
    if (!field) {
        field = document.getElementById("search");
        search = false;
    }
    const btn = document.getElementById("cancel");
    if (field.value === "") {
        btn.style.visibility = "hidden";
    } else {
        btn.style.visibility = "visible";
    }
    if (search) {
        this.timeout = setTimeout(() => {
            document.getElementById("search-form").submit();
        }, 600)
    }
}

function clearText() {
    let field = document.getElementById("search");
    field.value = "";
    field.dispatchEvent(new Event("input"))
}

window.textEntered = textEntered
window.clearText = clearText