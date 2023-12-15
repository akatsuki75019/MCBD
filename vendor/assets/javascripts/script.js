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

  
// Script pour changer les catégories

  const selectCategory = document.querySelector('#category_id')
  if (selectCategory){
    selectCategory.addEventListener('change',(e) => {
      e.preventDefault();
      selectCategory.form.submit();
    });
  };
