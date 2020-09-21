var modal = document.getElementById('modal_users');
var closeBtn = document.getElementById('closeBtn_users');

closeBtn.addEventListener('click', function() {
  modal.style.display = 'none';
});
window.addEventListener('click', function(e) {
  if (e.target == modal) {
    modal.style.display = 'none';
  }
})
