$().ready(() => {
  // Open picker on click
  $(".image-edit-btn").on("click", () => {
    $(".image-field").click();
  });

  // Update preview
  $(".image-field").on("change", (e) => {
    const file = e.target.files[0];
    if (!file) return;
    const reader = new FileReader();
    reader.onload = function (e) {
      $(".image-preview img").attr("src", e.target.result);
    };
    reader.readAsDataURL(file);
    $(".image-edit-btn").blur();
  });
});
