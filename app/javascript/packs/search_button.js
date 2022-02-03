function redirectWithQuery(path) {
    const query = localStorage.getItem('query')
    const url = path + '?query=' + query
    window.location.href = url;
  }

window.redirectWithQuery = redirectWithQuery