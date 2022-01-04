Router = L.Routing.OSRMv1.extend({
    buildRouteUrl: function(waypoints, options){
        console.log(this)
        url = L.Routing.OSRMv1.prototype.buildRouteUrl.call(this, waypoints, options);
        return url.replaceAll(',','%2C').replaceAll('.','%2E')
    }
})