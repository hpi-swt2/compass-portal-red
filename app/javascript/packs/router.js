Router = L.Routing.OSRMv1.extend({
    buildRouteUrl: function (waypoints, options) {
        waypoints.forEach(v => {
            v.latLng.lat = String(v.latLng.lat).replaceAll('.', 'p')
            v.latLng.lng = String(v.latLng.lng).replaceAll('.', 'p')
        });
        url = L.Routing.OSRMv1.prototype.buildRouteUrl.call(this, waypoints, options);
        url = url.replaceAll(',', '%2C')
        return url
    }
})