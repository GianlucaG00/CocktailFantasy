$(document).ready(function() {
    $("#submit").click(function(){
        if($("#msg").val().length < 5){
           alert("Il messaggio deve contenere almeno 5 caratteri");
           return false;
        }
     }); 
}); 
