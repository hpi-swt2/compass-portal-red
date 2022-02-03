function textEntered(field) {
    if (!field) {
        field = document.getElementById("search");
    }
    const btn = document.getElementById("cancel");
    if (field.value === "") {
        btn.style.visibility = "hidden";
    } else {
        btn.style.visibility = "visible";
    }
}

function linkToSearch(path) {
    const query = document.getElementById('search').value
    const url = path + '?query=' + query
    window.location.href = url;
  }

window.textEntered = textEntered
window.linkToSearch = linkToSearch