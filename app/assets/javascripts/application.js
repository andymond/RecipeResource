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
//= require jquery
//= require jquery_ujs
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
var ingredient_counter = 0;
var instruction_counter = 0;

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

function addIngredient(divName){
  var newdiv = document.createElement('div');
  newdiv.id = "ingSet" + (ingredient_counter + 1)
  newdiv.className = "ingredient-row"
  newdiv.innerHTML = "<input type='text' placeholder='ingredient name' name='ingredients[" + (ingredient_counter + 1) + "]' class='ingredient-data' id=ingredient" + (ingredient_counter + 1) + " required>";
  newdiv.innerHTML += "<input type='number' placeholder='qty' step='0.1' name='qty[" + (ingredient_counter + 1) + "]' class='qty ingredient-data' id=quantity" + (ingredient_counter + 1) + ">";
  newdiv.innerHTML += "<input type='text' placeholder='unit' name='unit[" + (ingredient_counter + 1) + "]' class='unit ingredient-data' id=unit" + (ingredient_counter + 1) + ">";
  newdiv.innerHTML += "<button type='button' onClick='removeField(\"ingSet" + (ingredient_counter + 1) + "\");' class='rounded' id=remove-ingredient'" + (ingredient_counter + 1) + ">Remove</button>"
  document.getElementById(divName).appendChild(newdiv);
  ingredient_counter++;
}

function addInstruction(divName){
  var newdiv = document.createElement('div');
  newdiv.id = "instSet" + (instruction_counter + 1)
  newdiv.innerHTML = "<input type='text' plac-dataeholder='step " + (instruction_counter + 1) + "' name='instructions[" + (instruction_counter + 1) + "]' class='instruction' id=instruction" + (instruction_counter + 1) + " required>";
  newdiv.innerHTML += "<button type='button' onClick='removeField(\"instSet" + (instruction_counter + 1) + "\");' class='rounded' id='remove-ingredient'" + (instruction_counter + 1) + ">Remove</button>"
  document.getElementById(divName).appendChild(newdiv);
  instruction_counter++;
}

function removeField(divName){
  document.getElementById(divName).remove();
  instruction_counter--;
}

function updateRecipe(event){
  const {recslug, resslug} = {...event.target.dataset}
  const recipeName         = document.querySelector('.recipe-header').innerText
  const recipeStation      = document.querySelector('.recipe-station').innerText
  const recipeIngredients  = document.querySelector('.recipe-ingredients')
  const ingredients        = [...recipeIngredients.querySelectorAll('.ingredient-row')]
  const recipeInstructions = document.querySelector('.instructions')
  const instructions       = [...recipeInstructions.querySelectorAll('.instruction')]
  const ingredientList = ingredients.map(row => {
    let rowData = row.querySelectorAll('.ingredient-data')
    return {
      ingredient: rowData[0].innerText || rowData[0].value,
      qty: rowData[1].innerText || rowData[1].value,
      unit: rowData[2].innerText || rowData[2].value
    }
  })
  const instructionList = instructions.map(row => row.innerText || row.value)
  putUpdateRecipe({recipeName, recipeStation, ingredientList, instructionList}, resslug, recslug)
}

function putUpdateRecipe(recipe, resSlug, recSlug) {
  const url = `/chef/restaurants/${resSlug}/recipes/${recSlug}`
  console.log(url)
  return jQuery.ajax({
    type: 'PUT',
    url: url,
    contentType: 'application/json',
    data: JSON.stringify({recipe})
  })
}
