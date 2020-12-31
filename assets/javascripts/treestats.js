(function () {
  const burgerEl = document.querySelectorAll(".burger");

  burgerEl[0].addEventListener("click", function(e) {
    const navEls = document.querySelectorAll(".navitems");

    if (navEls.length != 1) {
      return;
    }

    const el = navEls[0];

    if (el.classList.contains("visible")) {
      el.classList.remove("visible");
    } else {
      el.classList.add("visible");
    }
  });
})();
