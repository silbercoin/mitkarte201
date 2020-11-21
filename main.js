

//console.log(icon)

//Event
/*document.querySelectorAll('.btn-light').forEach(function(e) {
  
  e.addEventListener('click', function() {
    this.style.backgroundColor = "#1c3fa8";
    this.style.color = 'white'
  })
});*/

function setColor(e) {
  var target = e.target.tagName,
      status = e.target.classList.contains('btn-light');
      
    e.target.classList.add(status ? 'btn-icon' : 'btn-light');
    e.target.classList.remove(status ? 'btn-light' : 'btn-icon');
}