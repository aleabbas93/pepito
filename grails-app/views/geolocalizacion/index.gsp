<!DOCTYPE html>
<html>
	<head>
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<!-- Latest compiled and minified CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
	
		<!-- Optional theme -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
	
		<!-- Latest compiled and minified JavaScript -->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
		
		<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
   		<meta charset="utf-8">
		<style>
	      html, body{
	      		margin: 0;
			  padding: 0;
			  height: 100%;
	      }
	      #map {
	      	height: 400px;
	      	
	      }
	    </style>
	</head>
	<body bgcolor="#ffffff"> 
		<div class="">
			<div class="col-sm-6">
				<div class="panel panel-primary" id="pnlFiltros">
				    <div class="panel-heading">
				    	<span class="glyphicon glyphicon-filter"></span> &nbsp Filtros
				    </div>
				    <div class="panel-body form-group" id="bodyFiltros">
				    	<label for="calle" class="col-sm-4">Calle</label>
			    		<input type="text" class="col-sm-8 form-group" id="calle" placeholder="Ingrese una calle" value="Buenos Aires">
			    		<label for="altura" class="col-sm-4">Altura</label>
			    		<input type="text" class="col-sm-8 form-group" id="altura" placeholder="Ingrese un nro de calle" value="1060">
			    		<label for="ciudad" class="col-sm-4">Ciudad</label>
			    		<input type="text" class="col-sm-8 form-group" id="ciudad" placeholder="Ingrese una ciudad" value="Cordoba">
				    	<label for="radio" class="col-sm-4">Radio</label>
			    		<input type="text" class="col-sm-8 form-group" id="radio" placeholder="Ingrese el radio en metros" value="1000">
			    		<label for="cantidadResultados" class="col-sm-4">Cantidad Resultados</label>
			    		<input type="text" class="col-sm-8 form-group" id="cantidadResultados" placeholder="Ingrese cantidad" value="5">
				    	<label for="medioSelect" class="col-sm-4">Medios</label>
				    	<select class="form-control col-sm-8" id="medioSelect">
				    		<g:each in="${medios}" var="medio">
				    			<option value="${medio}">${medio}</option>
				    		</g:each>
					    </select>
				    </div>
				    
				    <div class="panel-footer" id="footerFiltros">
				    	<div class="row">
					    	<button class="btn btn-primary col-sm-offset-1 col-sm-4" onclick="obtenerMiUbicacion()">
					    		<span class="glyphicon glyphicon-map-marker"></span>Usar mi ubicación!
					    	</button>
					    	<button class="btn btn-primary col-sm-offset-2 col-sm-4" onclick="geolocalizarDireccion()">
					    		<span class="glyphicon glyphicon-home"></span>Usar dirección
					    	</button>
				    	</div>
				    	
				    </div>
				</div>
			</div>
			<div class="col-sm-6">
				<div class="panel panel-primary">
					<div class="panel-heading">
				    	<span class="glyphicon glyphicon-globe"></span> &nbsp Mapa
				    </div>		
				    <div class="panel-body">
						<div id="map"></div>
				    </div>
				</div>
			</div>
		</div>
		
		<div class="col-sm-6 col-sm-offset-3" id="pnlMsj">
			<div class="progress col-sm-8 col-sm-offset-2">
			  <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: 100%">
			  </div>
			</div>
			<center><h2 id="msj">Buscando ...</h2></center>
		</div>
		<div id="divLugares" class="row">
		</div>

		 
		
		<script type="text/javascript">
			
			
			function mostrarCargando(){
				$("#pnlMsj").show();
			}

			function ocultarCargando(){
				$("#pnlMsj").hide();
			}

			function setMensajeCargando(msj){
				$("#msj").text(msj);
			}
			
			function obtenerMiUbicacion(){
				if(navigator.geolocation){
					setMensajeCargando("Obteniendo su geolocalización.");
					mostrarCargando();
					navigator.geolocation.getCurrentPosition(funcionSi, funcionNo);
				}
				else{
			    	console.log("No soporta geolocalización");
			    	ocultarCargando();
				}
			}
			
		
			function funcionSi(res) {
				//console.log(res);
				var lat = res.coords.latitude;
				var longi = res.coords.longitude;
				var radio = $("#radio").val();
				var cantResultados = $("#cantidadResultados").val();
				var medio = $( "#medioSelect option:selected" ).text();
				localizarEnMapa(lat, longi, 'Usted esta aquí.');
				getMediosOff(lat, longi, radio, cantResultados, medio);
			}
		
			function funcionNo(err) {
				console.log("error");
				console.log(err);
			}

			function getMediosOff(lat, longi, radio, cantResultados, medio){
				<g:remoteFunction action="lugares" 
					controller="geolocalizacion"
					params= "\'lat=\'+ lat +\'&longi=\'+ longi +\'&radio=\'+ radio +\'&cantResultados=\'+ cantResultados +\'&medio=\'+ medio"
					update="divLugares" 
					onLoading="funcionCargandoLugares()"
					onSuccess="funcionExitoBusqueda(data)"
					onFailure="funcionErrorBusqueda()"/>
			}

			function funcionExitoBusqueda(res){
				//console.log(res);
				ocultarCargando();
			}

			function funcionErrorBusqueda(){
				alert("Algo salió mal.");
				ocultarCargando();
			}

			function funcionCargandoLugares(){
				ocultarCargando();
				setMensajeCargando("Buscando lugares de pagos cercanos.");
				mostrarCargando();
			}

			function geolocalizarDireccion(){
				var nro = $("#altura").val();
				var calle = $("#calle").val();
				var ciudad = $("#ciudad").val();
				<g:remoteFunction action="geolocalizarDireccion" 
					controller="geolocalizacion"
					params= "\'nro=\'+ nro +\'&calle=\'+ calle +\'&ciudad=\'+ ciudad"
					update="divLugares" 
					onLoading="funcionCargandoCoordenadas()"
					onSuccess="funcionExitoCoordenadas(data)"
					onFailure="funcionErrorBusqueda()"/>
			}

			function funcionExitoCoordenadas(res){
				ocultarCargando();
				var radio = $("#radio").val();
				var cantResultados = $("#cantidadResultados").val();
				var medio = $( "#medioSelect option:selected" ).text();
				var nro = $("#altura").val();
				var calle = $("#calle").val();
				var ciudad = $("#ciudad").val();
				var dir = calle+' '+nro+', '+ciudad;
				localizarEnMapa(res.lat, res.lng, dir);
				getMediosOff(res.lat, res.lng, radio, cantResultados, medio);
			}

			function funcionCargandoCoordenadas(){
				ocultarCargando();
				setMensajeCargando("Geolocalizando dirección.");
				mostrarCargando();
			}

			function initMap() {
			  var map = new google.maps.Map(document.getElementById('map'), {
			    zoom: 8,
			    center: {lat: -31.4199093, lng: -64.1900787}
			  });
			}
							
			function localizarEnMapa(lati, longi, msj){
				var map = new google.maps.Map(document.getElementById('map'), {
				    center: {lat: lati, lng: longi},
				    zoom: 17
				  });	
			  	var infoWindow = new google.maps.InfoWindow({map: map});	
				var pos = {
				  lat: lati,
				  lng: longi
				};
				
				infoWindow.setPosition(pos);
				infoWindow.setContent(msj);
			}

			function setearAltoMapa(){
				var altoBodyFiltros = $("#bodyFiltros").height();
				var altoFooterFiltros = $("#footerFiltros").height();
				var alto = altoBodyFiltros + altoFooterFiltros + 30;
				console.log(alto);
				$("#map").height(alto);
			}
			
			setearAltoMapa();
			ocultarCargando();
		</script>
		<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDiYFCZ306D5W15nfSSqYbQdBTZ5nA5fZc&callback=initMap"
	        async defer>
	    </script>
	</body>

</html>