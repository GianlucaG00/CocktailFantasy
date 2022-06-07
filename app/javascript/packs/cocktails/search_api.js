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
        drink_pic = $("#drink-pic-api").text();
         
        $("#cocktail-name").val(drink_name); 
        $("#cocktail-preparation").val(drink_preparation);
        $("#drink-pic").val(drink_pic);
        $("#drink-signature").val(0); 
    }); 

    $("#cocktail-name").on("change", setSignature);
    $("#cocktail-preparation").on("change", setSignature);

    function setSignature() { 
        $("#drink-signature").val(1);  // signature => true
    }
     
});


