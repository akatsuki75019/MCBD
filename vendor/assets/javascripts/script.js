// Script sur card event pour la description
const cardDescriptions = document.querySelectorAll('.card-description');

cardDescriptions.forEach(description => {
  const originalHeight = description.scrollHeight;

  description.addEventListener('mouseenter', function() {
    description.style.transition = 'max-height 0.3s ease-in-out';
    description.classList.add('truncated');
    description.style.maxHeight = originalHeight + 'px';
  });

  description.addEventListener('mouseleave', function() {
    description.style.transition = 'max-height 0.3s ease-in-out';
    description.classList.remove('truncated');
    description.style.maxHeight = '80px'; 
  });
});

  // Script sur book show pour le synopsis

const books = document.querySelectorAll(".book");

books.forEach(book => {
  const description = book.querySelector("#synopsis");
  const fullText = description.innerText;
  
  if (fullText.length > 200) {
    const truncatedText = fullText.substring(0, 200) + '...';
    description.innerText = truncatedText;

    const showMoreBtn = document.createElement('span');
    showMoreBtn.innerText = 'Voir Plus';
    showMoreBtn.className = 'show-more';
    showMoreBtn.style.cursor = 'pointer';
    showMoreBtn.addEventListener('click', () => {
      if (showMoreBtn.innerText === 'Voir Plus') {
        description.style.transition = '0.3s ease-in';
        description.innerText = fullText;
        showMoreBtn.innerText = 'Voir Moins';
      } else {
        description.style.transition = '0.3s ease-out';
        description.innerText = truncatedText;
        showMoreBtn.innerText = 'Voir Plus';
      }
    });

    book.appendChild(showMoreBtn);
  }
});

  
// Script pour changer les catégories

  const selectCategory = document.querySelector('#category_id')
  if (selectCategory){
    selectCategory.addEventListener('change',(event) => {
      event.preventDefault();
      selectCategory.form.submit();
    });
  };


// Script pour afficher la flèche du page up ou non si pas de scroll

window.addEventListener('scroll', function() {
  var scrollToTopButton = document.getElementById('scrollToTopButton');
  if (window.scrollY > 0) {
    scrollToTopButton.classList.add('show');
  } else {
    scrollToTopButton.classList.remove('show');
  }
});


document.getElementById('search-link').addEventListener('click', function(event) {
  event.preventDefault();
  document.getElementById('search-form').classList.toggle('d-none');
});



// Script mise à jour des quantités dans le panier
const cartItems = document.querySelectorAll('.cart-quantity-input');
[...cartItems].forEach((cartItem) => {
  cartItem.addEventListener('change', (e) => {
    const target = e.target
    target.form?.submit();
    const bookNumber = parseInt(target.value.replace('€', ''));
    updateCartIcon()
    updateTotalPrice(target, bookNumber)
  })
})

const updateTotalCart = () => {
  let sum = 0
  const cartTotal = document.querySelector('.cart-total')
  const allTotalPrice = document.querySelectorAll('.total-price');
  if (cartTotal == null || allTotalPrice ==null) return;

  [...allTotalPrice].forEach((totalPrice) => {
    sum += parseFloat(totalPrice.textContent.replace(',', '.').replace('€', ''))
  })
  cartTotal.textContent = sum.toFixed(2) + '€'
  cartTotal.textContent = cartTotal.textContent.replace('.', ',')
}

const updateTotalPrice = (target, number) => {
    let totalPrice = target.closest('tr')?.querySelector('.total-price');
    const bookPrice = target.closest('tr')?.querySelector('.book-price');
    if (bookPrice == null && totalPrice == null) return;

    const newTotalPrice = parseFloat(bookPrice.textContent.replace(',', '.').replace('€', '')) * number;
    totalPrice.textContent = newTotalPrice.toFixed(2) + '€'
    totalPrice.textContent = totalPrice.textContent.replace('.', ',')
    updateTotalCart()
}

const updateCartIcon = () => {
  const icon = document.querySelector('.cart-item-number')
  if(icon == null) return;

  let cartItemsNumber = 0;
  cartItems.forEach(item => {
      cartItemsNumber += parseFloat(item.value.replace('€', ''));
  });
  icon.textContent = cartItemsNumber
}


// Show des livres achetés dans le profil User
document.querySelectorAll('.view-more').forEach(function(link) {
  link.addEventListener('click', function(event) {
    event.preventDefault();
    this.previousElementSibling.querySelectorAll('.hidden').forEach(function(item) {
      item.classList.remove('hidden');
    });
    this.style.display = 'none';
  });
});