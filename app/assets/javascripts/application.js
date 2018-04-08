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
const aboutText = document.querySelector('.about-div .hidden')
const register = document.querySelector('.register p')
const registerForm = document.querySelector('.register .hidden')
const login = document.querySelector('.login p')
const loginField = document.querySelector('.login .hidden')
var open = false;

function openNav() {
    document.getElementById("userCard").style.width = "300px";
    document.getElementById("main").style.marginLeft = "300px";
    open = true
}

function closeNav() {
    document.getElementById("userCard").style.width = "0";
    document.getElementById("main").style.marginLeft= "0";
    open = false
}

function toggleNav() {
  if(open == true) {
    closeNav()
  }else{
    openNav()
  }
}

function hide(element, cl) {
  if(element.classList.contains(cl)) {
    element.classList.toggle('hidden')
    element.classList.toggle(cl)
  }else {
    false
  }
}

about.addEventListener('click', function() {
  aboutText.classList.toggle('about-text')
  aboutText.classList.toggle('hidden')
  hide(registerForm, 'drop')
  hide(loginField, 'drop')
})

register.addEventListener('click', function() {
  registerForm.classList.toggle('drop')
  registerForm.classList.toggle('hidden')
  hide(aboutText, 'about-text')
  hide(loginField, 'drop')
})

login.addEventListener('click', function() {
  loginField.classList.toggle('drop')
  loginField.classList.toggle('hidden')
  hide(aboutText, 'about-text')
  hide(registerForm, 'drop')
})
