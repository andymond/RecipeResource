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

const about = document.querySelector('.about p')
const register = document.querySelector('.register p')
const login = document.querySelector('.login p')

function openNav() {
    document.getElementById("userCard").style.width = "300px";
    document.getElementById("main").style.marginLeft = "300px";
}

function closeNav() {
    document.getElementById("userCard").style.width = "0";
    document.getElementById("main").style.marginLeft= "0";
}

about.addEventListener('click', function() {
  const aboutText = document.querySelector('.about .hidden')
  aboutText.style.display = "flex"
  about.style.display = "none"
  aboutText.addEventListener('click', function() {
    aboutText.style.display = "none"
    about.style.display = "block"
  })
})

register.addEventListener('click', function() {
  const registerForm = document.querySelector('.register .hidden')
  registerForm.classList.toggle('drop')
})

login.addEventListener('click', function() {
  const loginField = document.querySelector('.login .hidden')
  loginField.classList.toggle('drop')
})
