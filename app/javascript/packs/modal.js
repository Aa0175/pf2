var btn = document.getElementById("btn");
var modal = document.getElementById('modal');
var closeBtn = document.getElementById('closeBtn');

btn.addEventListener('click', function() {
  modal.style.display = 'flex';
});
closeBtn.addEventListener('click', function() {
  modal.style.display = 'none';
});
window.addEventListener('click', function(e) {
  if (e.target == modal) {
    modal.style.display = 'none';
  }
})
