// Script sur card event pour la description

document.addEventListener('DOMContentLoaded', function() {
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
});

