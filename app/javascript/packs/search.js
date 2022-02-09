function textEntered(field) {
  if (!field) {
    field = document.getElementById("search");
  }
  localStorage.setItem('query', field.value ?? '');
  const btn = document.getElementById("cancel");
  if (field.value === "") {
    btn.style.visibility = "hidden";
  } else {
    btn.style.visibility = "visible";
  }
}

window.textEntered = textEntered
