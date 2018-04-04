// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require_tree .

// $(document).ready(function() {
//     $('.about a').click(function() {
//       alert("hey")
//     })
// });

const aboutLink = document.querySelector('.about p')

aboutLink.addEventListener('click', function() {
  const aboutText = document.querySelector('.about .hidden')
  aboutText.style.display = "block"
  aboutLink.style.display = "none"
  aboutText.addEventListener('click', function() {
    aboutText.style.display = "none"
    aboutLink.style.display = "block"
  })
})
