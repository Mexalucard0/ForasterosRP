
jQuery.noConflict();
jQuery(document).ready(function($) {
	$(function() {
		$("#dateofbirth").datepicker();
		$('.input--style-5 input[type=text]').keyup(function(event) {
			var textBox = event.target;
			var start = textBox.selectionStart;
			var end = textBox.selectionEnd;
			textBox.value = textBox.value.charAt(0).toUpperCase() + textBox.value.slice(1).toLowerCase();
			textBox.setSelectionRange(start, end);
		});
		$('input[type="checkbox"]').on('change', function() {
			$('input[type="checkbox"]').not(this).prop('checked', false);
			});


		window.addEventListener('message', function(event) {
			if (event.data.type == "enableui") {
				document.body.style.display = event.data.enable ? "block" : "none";
			}
		});
		
		$("#register").submit(function(event) {
			event.preventDefault(); // Prevent form from submitting
			console.log(event);
			// Verify date
			var date = $("#dateofbirth").val();
			var dateCheck = new Date($("#dateofbirth").val());
	
			if (dateCheck == "Invalid Date") {
				date == "invalid";
				console.log('fecha invalida')
			}
			else {
				const ye = new Intl.DateTimeFormat('en', { year: 'numeric' }).format(dateCheck)
				const mo = new Intl.DateTimeFormat('en', { month: '2-digit' }).format(dateCheck)
				const da = new Intl.DateTimeFormat('en', { day: '2-digit' }).format(dateCheck)
				
				var formattedDate = `${mo}/${da}/${ye}`;

				console.log('Todo deberia jalar al 100');
				console.log($("#firstname").val());
				console.log($("#lastname").val());
				console.log(formattedDate);
				console.log($(".sex:checked").val());
				console.log($("#height").val());

				$.post('http://esx_identity/register', JSON.stringify({
					firstname: $("#firstname").val(),
					lastname: $("#lastname").val(),
					dateofbirth: formattedDate,
					sex: $(".sex:checked").val(),
					height: $("#height").val()
				}));
			}
		});
	});
	
})