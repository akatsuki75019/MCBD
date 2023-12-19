// Pour gérer l'affichage de la font Dyslexique
document.addEventListener('DOMContentLoaded', function() {
  // Fonction pour vérifier si l'option dyslexique est activée dans le stockage local
  function isDyslexicFontEnabled() {
    return localStorage.getItem('dyslexicFont') === 'true';
  }

  // Fonction pour activer ou désactiver l'option dyslexique dans le stockage local
  function setDyslexicFontPreference(enabled) {
    localStorage.setItem('dyslexicFont', enabled ? 'true' : 'false');
  }

  // Appliquer la classe avec la police dyslexique si activée
  if (isDyslexicFontEnabled()) {
    addClassToElements('body', 'dyslexic-font');
    addClassToElements('p', 'dyslexic-font');
    addClassToElements('h6', 'dyslexic-font');
    addClassToElements('.section-title h5', 'dyslexic-font');
    addClassToElements('.section-title .selector', 'dyslexic-font');
    addClassToElements('.hero__text h2', 'dyslexic-font');
    addClassToElements('.product__sidebar .section-title h5', 'dyslexic-font');
    addClassToElements('.breadcrumb__links a:after', 'dyslexic-font');
    addClassToElements('.normal__breadcrumb__text h2', 'dyslexic-font');
    addClassToElements('.login__form h3', 'dyslexic-font');
    addClassToElements('.login__register h3', 'dyslexic-font');
    addClassToElements('.signup .login__social__links h3', 'dyslexic-font')
  }
});

// Fonction pour ajouter une classe à un élément
function addClassToElements(selector, className) {
  var elements = document.querySelectorAll(selector);
  for (var i = 0; i < elements.length; i++) {
    elements[i].classList.add(className);
  }
}