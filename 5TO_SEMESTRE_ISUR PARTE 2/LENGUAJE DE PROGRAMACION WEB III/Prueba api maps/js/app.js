let map;
let marcador1;

function initMap() {
  map = new google.maps.Map(document.getElementById("map"), {
    center: { lat: -34.397, lng: 150.644 },
    zoom: 8,
  });
  marcador1=new google.maps.Marker({
      position: { lat: -16.4339759, lng: -71.4893011 },
      title:'casa paucarpata'
  })
  marcador1.setMap(map)
}

initMap()