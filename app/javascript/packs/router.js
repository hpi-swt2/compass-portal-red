Router = L.Routing.OSRMv1.extend({
    buildRouteUrl: function (waypoints, options) {
        const waypointsCopy = waypoints.map(v => {
            return {
                latLng: {
                    lat: String(v.latLng.lat).replaceAll('.', 'p'),
                    lng: String(v.latLng.lng).replaceAll('.', 'p')
                }
            }
        });
        url = L.Routing.OSRMv1.prototype.buildRouteUrl.call(this, waypointsCopy, options);
        return url.replaceAll(',', '%2C')
    }
})