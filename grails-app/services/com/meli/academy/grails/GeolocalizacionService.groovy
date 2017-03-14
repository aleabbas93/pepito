package com.meli.academy.grails

import grails.transaction.Transactional
import groovy.json.JsonSlurper

@Transactional
class GeolocalizacionService {
	def site = "MLA";
	def peticionCualquierLugarCerca = ""
    def serviceMethod() {

    }
	
	def getMediosOff(String latitud, String longitud, String radio, String cantResultados, String medio){
		if(medio.equals("")){
			return this.getCualquierMedioOffCerca(latitud, longitud, radio, cantResultados)
		}
		return null;
	}
	
	def getCualquierMedioOffCerca(latitud, longitud, radio, cantResultados){
		String strUrl = "https://api.mercadolibre.com/sites/MLA/payment_methods/agencies/search?near_to="+latitud+","+longitud+","+radio+"&limit="+cantResultados;
		def lugares = realizarPeticion(strUrl);
		return lugares.results;
	}
	
	def obtenerGeolocalizacion(calle, nro, ciudad){
		String ciudadFormateada = this.formatearStringParaGeolocalizacion(ciudad);
		String calleFormateada = this.formatearStringParaGeolocalizacion(calle);
		String strUrl = "https://maps.googleapis.com/maps/api/geocode/json?address="+nro+"+"+calleFormateada+",+"+ciudadFormateada+",Argentina&key=AIzaSyBg2CP1nI3C2sHkugpAcdd6qgGez5pWZ60"
		def geolocalizacion = realizarPeticion(strUrl);
		def objetoCoordenadas = geolocalizacion.geometry;
		return objetoCoordenadas;
	}
	
	def formatearStringParaGeolocalizacion(String cadena){
		String cadenaFormateada = "";
		cadenaFormateada = cadena.trim();
		cadenaFormateada = cadenaFormateada.replace(" ", "+");
		return cadenaFormateada;
	}
	
	def realizarPeticion(String strUrl){
		JsonSlurper json = new JsonSlurper();
		def url = new URL(strUrl)
		println strUrl;
		def connection = (HttpURLConnection)url.openConnection()
		connection.setRequestMethod("GET")
		connection.setRequestProperty("Accept", "application/json")
		connection.setRequestProperty("User-Agent", "Mozilla/5.0")
		def respuesta =json.parse(connection.getInputStream())
		return respuesta;
	}
}
