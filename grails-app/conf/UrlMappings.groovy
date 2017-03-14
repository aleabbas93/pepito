class UrlMappings {

	static mappings = {
//        "/$controller/$action?/$id?(.$format)?"{
//            constraints {
//                // apply constraints here
//            }
//        }
		"/configuracion"(controller:"geolocalizacion", action:"index")
		"/lugares"(controller:"geolocalizacion", action:"lugares")
		"/geolocalizarDireccion"(controller:"geolocalizacion", action:"geolocalizarDireccion")
        "/"(view:"/index")
        "500"(view:'/error')
	}
}
