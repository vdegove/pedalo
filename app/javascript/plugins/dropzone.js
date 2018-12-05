import Dropzone from "dropzone";

const initDropzone = () => {
  Dropzone.options.myAwesomeDropzone = {
    init: function() {
      this.on("success", function(file) {
       window.location.href = "/deliveries";
      });
      this.on("error", function(file) {
        alert("Oups ! Ce n'est pas le bon format de fichier.")
      })
    }
  };
}

export { initDropzone }
