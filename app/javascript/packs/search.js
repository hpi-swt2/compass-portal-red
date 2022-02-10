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

function toggleCenterClass(flag) {
  searchDiv = document.getElementById("search-div");
  search = document.getElementById("search")
  platypus = document.getElementById("platypus");

  if (flag) {
    searchDiv.classList.remove("center");
    platypus.style.display = "none";
  } else {
    if (!search.value) {
      searchDiv.classList.add("center");
      platypus.style.display = "block";
    }
  }
  
}

window.textEntered = textEntered;
window.toggleCenterClass = toggleCenterClass;