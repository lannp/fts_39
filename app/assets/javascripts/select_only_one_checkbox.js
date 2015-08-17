$(document).on("change", "input[type=checkbox]", function(){
  $("input[type=checkbox]").not(this).each(function(){
    $(this).removeAttr("checked");
    this.checked  = false;
  });
});
