export function closeMapPopups() {
  [...document.getElementsByClassName('map-popup')].forEach((item) => {
      item.style.display = "None";
  });
}

export function showPopup(popup_id, element_id) {
  closeMapPopups();

  if (popup_id == 'poi_popup') {
    openPointOfInterest(element_id);
  }
}

function openPointOfInterest(element_id) {
  const poi_popup = document.getElementById('poi_popup');
  const name = document.getElementById('poi_popup_name');
  const description = document.getElementById('poi_popup_description');
  const detailPageLink = document.getElementById('details_btn').parentNode;
  fetch('/point_of_interests/' + element_id + '.json').then (function (response) {
    return response.json();
  }).then (function (data) {
    name.textContent = data.name;
    description.textContent = data.description;
    detailPageLink.setAttribute('href', '/point_of_interests/' + element_id)
    poi_popup.style.display = 'block';
  }).catch (function (error) {
    console.log ("error: " + error);
  });
}