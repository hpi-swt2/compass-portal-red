function textEntered(field) {
    clearTimeout(this.timeout)
    let search = true;
    if (!field) {
        field = document.getElementById("search");
        search = false;
    }
    localStorage.setItem('query', field.value ?? '');
    const btn = document.getElementById("cancel");
    if (field.value === "") {
        btn.style.visibility = "hidden";
    } else {
        btn.style.visibility = "visible";
    }
    if (search) {
        this.timeout = setTimeout(() => {
            sendRequest(field);
        }, 500)
    }
}

function clearText(btn) {
    let field = document.getElementById("search");
    field.value = "";
    localStorage.setItem('query', '');
    sendRequest(field);
    btn.style.visibility = "hidden";
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
        }
    });
}

window.textEntered = textEntered
window.clearText = clearText
window.sendRequest = sendRequest
