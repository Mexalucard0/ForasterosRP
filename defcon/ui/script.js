$(function(){
	window.onload = function(e){
		window.addEventListener('message', function(event){

			var item = event.data;
			if (item !== undefined && item.type === "logo") {
			
				if (item.display === "tac0") {
					
					document.getElementById('Alerta').src='img/tac0.png'
				} else if (item.display === "tac1") {
					document.getElementById('Alerta').src='img/Tac1.png'
				} else if (item.display === "tac2") {
					document.getElementById('Alerta').src='img/tac2.png'
				} else if (item.display === "tac3") {
					document.getElementById('Alerta').src='img/tac3.png'
				} else if (item.display === "tac4") {
					document.getElementById('Alerta').src='img/tac4.png'
				} else if (item.display === "tac5") {
					document.getElementById('Alerta').src='img/tac5.png'
					
				}
			}
		});
	};
});