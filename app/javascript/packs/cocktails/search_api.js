$(document).ready(function() {
    $("#search-cocktail").on("click", function() {
        text = $("#text-field").val(); 
        if(text.length === 0){
            alert("Inserisci il nome di un cocktail da cercare!"); 
            return false; 
        }
    });

    $("#add-button").on("click", function() {
        drink_name = $("#drink-name-api").text();
        drink_id = $("#drink-id-api").text(); 
        drink_preparation = $("#drink-preparation-api").text(); 
         
        $("#cocktail-name").val(drink_name); 
        $("#cocktail-preparation").val(drink_preparation); 
    }); 
});


