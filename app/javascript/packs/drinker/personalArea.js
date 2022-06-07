const { ABSOLUTE_RESOURCE_PATH } = require("webpack/lib/ModuleFilenameHelpers");

$(document).ready(function() {
    $("#subscribe-btn").click(function(){
        if($("#select-bar option:selected").val() === ""){
           alert("Seleziona il nome di un Bar!");
           return false;
        }
     }); 
}); 
