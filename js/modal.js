let modal = document.querySelector('.modal');
let activate = document.querySelector('.activate');
let closeBtn = document.querySelector('.closeBtn');

function toggleModal() {
  modal.classList.toggle('active');
}

function windowOnClick(event) {
  if (event.target === modal) {
    toggleModal;
  }
}

activate.addEventListener("click", toggleModal);
closeBtn.addEventListener("click", toggleModal);
window.addEventListener("click", windowOnClick);