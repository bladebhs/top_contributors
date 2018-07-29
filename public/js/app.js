//var $loading = $('#loading').hide();
$(document)
  .ajaxStart(function () {
    //$loading.show();
    console.log("ajax started");
    $("#search").html('<i class="fa fa-spinner fa-lg fa-spin"></i>');
  })
  .ajaxStop(function () {
    //$loading.hide();
    $("#search").html("Search");
  });

$(document).ready(function() {

  $("#search").attr("disabled", "disabled");

  $("#repo_url").on("keyup", function() {
    if($(this).val() != "") {
      $("#search").removeAttr("disabled");
    } else {
      $("#search").attr("disabled", "disabled");
    }
  });

  $('#search').click(function(e) {
    e.preventDefault();
    $.ajax({
      url: "search?repo_url=" + $('#repo_url').val(),
      success: function(data, status, xhr) {
        $("#repo_url").val("");
        
        if (xhr.responseJSON) {
          $("#error").html(xhr.responseJSON.error);
        } else {
          $("#error").html("");
          $("#contributors").html(data);
        }
      }
    });
  });

});
