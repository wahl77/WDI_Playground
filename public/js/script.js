$(document).ready(function(){
  $("#submit_movie").on("click", submit_movie);
  $("#submit_stock").on("click", submit_stock);

	function submit_movie(event){
		if ($("#movie_name").val() == "") { 
			event.preventDefault();
			$("#movie_error").show();
		}	
	}

	function submit_stock(event){
		if ($("#stock_name").val() == "") { 
			event.preventDefault();
			$("#stock_error").show();
		}	
	}



});


















