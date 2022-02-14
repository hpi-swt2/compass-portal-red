function textEntered(field) {
  clearTimeout(this.timeout)
  let search = true;
  if (!field) {
    field = document.getElementById("search");
    search = false;
  }
  localStorage.setItem('query', field.value ?? '');
  updateClearButtonStyle(field.value)
  if (search) {
    this.timeout = setTimeout(() => {
      sendRequest(field);
    }, 450)
  }
}

function updateClearButtonStyle(value){
    const btn = document.getElementById("cancel");
    if (value === "") {
        btn.style.visibility = "hidden";
    } else {
        btn.style.visibility = "visible";
    }
}

function clearText(btn) {
  let field = document.getElementById("search");
  field.value = "";
  localStorage.setItem('query', '');
  sendRequest(field);
  btn.style.visibility = "hidden";
}

function toggleCenterClass(flag) {
  let searchDiv = document.getElementById("search-div");
  let platypus = document.getElementById("platypus");

  if (flag) {
    searchDiv.classList.remove("center");
    platypus.style.display = "none";
  } else {
    let search = document.getElementById("search");
    if (!search.value) {
      searchDiv.classList.add("center");
      platypus.style.display = "block";
    }
  }
}

function sendRequest(field) {
  let page = window.location.href.split("/")[3].split("?")[0]
  $.ajax({
    url: "/search?ajax=" + page + "&query=" + encodeURIComponent(field.value),
    type: "get",
    beforeSend: function () {
    },
    complete: function () {
    },
    success: function (json) {
      $("#results").html(json.html);
      if (page === "map") {
        window.buildSearchResultMarkers()
        document.url = "/map?query=" + encodeURIComponent(json.search)
      } else {
        if (json.search === "") {
          document.title = page.charAt(0).toUpperCase() + page.slice(1) + " –" + document.title.split("–")[1];
          document.url = "/" + page
        } else {
          document.title = "Results for " + json.search + " –" + document.title.split("–")[1];
          document.url = "/" + page + "?query=" + encodeURIComponent(json.search)
        }
      }
      window.history.pushState({"html": document.html, "pageTitle": document.title}, "", document.url);
    },
    error: function (xhr, ajaxOptions, thrownError) {
      window.alert("Sorry, your request could not be processed, please contact an administrator if the problem persists.\n" + thrownError)
      console.log("further Ajax Error Information:")
      console.log(ajaxOptions)
      console.log(xhr)
    }
  });
}

window.textEntered = textEntered;
window.toggleCenterClass = toggleCenterClass;
window.clearText = clearText;
window.sendRequest = sendRequest;

