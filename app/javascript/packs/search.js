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
            sendRequest(field);
        }, 500)
    }
}

function clearText(btn) {
    let field = document.getElementById("search");
    field.value = "";
    sendRequest(field);
    btn.style.visibility = "hidden";
}

function sendRequest(field){
    $.ajax({
        url: '/search?ajax=&query=' + field.value,
        type: 'get',
        beforeSend: function() {
        },
        complete: function() {
        },
        success: function(json) {
            $("#results")[0].innerHTML = json.html;
            if (json.search === ""){
                document.title = "Search –" + document.title.split("–")[1];
                document.url = "/search"
            } else {
                document.title = "Results for " + json.search + " –" + document.title.split("–")[1];
                document.url = "/search?query=" + json.search
            }
            window.history.pushState({"html":document.html, "pageTitle":document.title}, "", document.url);
        },
        error: function(xhr, ajaxOptions, thrownError) {
        }
    });
}

window.textEntered = textEntered
window.clearText = clearText
window.sendRequest = sendRequest