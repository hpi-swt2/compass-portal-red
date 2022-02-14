function redirectWithQuery(path) {
    const query = localStorage.getItem('query');
    window.location.href = path + ((query) ? '?query=' + query : '');
  }

window.redirectWithQuery = redirectWithQuery