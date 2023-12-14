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

  document.addEventListener('DOMContentLoaded', () => {
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
            showMoreBtn.style.transition = '1s ease-in';
            description.innerText = fullText;
            showMoreBtn.innerText = 'Voir Moins';
          } else {
            showMoreBtn.style.transition = '1s ease-out';
            description.innerText = truncatedText;
            showMoreBtn.innerText = 'Voir Plus';
          }
        });
  
        book.appendChild(showMoreBtn);
      }
    });
  });
  
// Script pour changer les catégories

  const selectCategory = document.querySelector('#category_id')
  if (selectCategory){
    selectCategory.addEventListener('change',(e) => {
      e.preventDefault();
      selectCategory.form.submit();
    });
  };


// Script pour la mise à jour des quantités du panier
document.addEventListener('DOMContentLoaded', function () {
  const updateCartButton = document.querySelector('.btn-update-cart');

  if (updateCartButton) {
    updateCartButton.addEventListener('click', function () {
      const cartItems = document.querySelectorAll('.cart-item-form');

      // Collectez les données pour la mise à jour du panier et envoyez-les au backend
      const formData = new FormData();
      cartItems.forEach(function (cartItem) {
        const quantityInput = cartItem.querySelector('.cart-quantity-input');
        formData.append(`cart_items[${quantityInput.dataset.cart_book_id}]`, quantityInput.value);

        // Mettez à jour la quantité affichée dans la ligne du panier
        const cartQuantityElement = cartItem.closest('.cart-book').querySelector('.cart-quantity');
        cartQuantityElement.textContent = quantityInput.value;
      });

      // Utilisez une requête AJAX pour mettre à jour le panier
      fetch('/carts/update_cart', {
        method: 'PATCH',
        body: formData,
        headers: {
          'X-CSRF-Token': Rails.csrfToken(),
        },
      })
        .then(response => response.json())
        .then(data => {
          // Mettez à jour les éléments de l'interface utilisateur en fonction de la réponse
          const totalCartPriceElement = document.querySelector('.total-cart-price');
          totalCartPriceElement.textContent = data.total_price;
        })
        .catch(error => console.error('Error updating cart:', error));
    });
  }
});
