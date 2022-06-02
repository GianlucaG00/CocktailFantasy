$(document).ready(function() {
    $("#search").on("click", function() {
        value = $("#text-field").text(); 
        if(value == ""){
            alert("Inserisci un cocktail da cercare!"); 
            return; 
        }
    });
});
