$(document)
  .ajaxStart(function () {
    $("#search").html('<i class="fa fa-spinner fa-lg fa-spin"></i>');
  })
  .ajaxStop(function () {
    $("#search").html("Search");
    $("#repo_url").val("");
    $("#search").attr("disabled", "disabled");
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
        if (xhr.responseJSON) {
          $("#contributors").html("");
          $("#error").html(xhr.responseJSON.error);
        } else {
          $("#error").html("");
          $("#contributors").html(data);
        }
      }
    });
  });
});
