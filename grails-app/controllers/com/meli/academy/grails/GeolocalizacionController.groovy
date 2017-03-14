package com.meli.academy.grails

import grails.converters.JSON

class GeolocalizacionController {
	
	def geolocalizacionService;

    def index(params) {
		
	}
	
	def lugares(params){
		def resLugares = [];
		if(params.lat && params.longi && params.radio && params.cantResultados){
			resLugares =  geolocalizacionService.getMediosOff(params.lat, params.longi, params.radio,params.cantResultados, "");
		}
		[lugares : resLugares];
	}
	
	def geolocalizarDireccion(params){
		def coordenadas = {};
		if(params.calle && params.nro && params.ciudad){
			coordenadas = geolocalizacionService.obtenerGeolocalizacion(params.calle, params.nro, params.ciudad)
		}
		println coordenadas;
		render coordenadas as JSON;
	}
	
	
}
