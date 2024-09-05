document.addEventListener('turbo:load', function() {
    document.body.addEventListener('change', function(event) {
      if (event.target.matches('.check-column input[type="checkbox"], .delivery-column input[type="checkbox"]')) {
        event.preventDefault();
        const checkbox = event.target;
        const form = checkbox.closest('form');
        const formData = new FormData(form);
        const url = form.action;
  
        fetch(url, {
          method: 'PATCH',
          body: formData,
          headers: {
            'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
            'Accept': 'application/json'
          }
        })
        .then(response => {
          if (!response.ok) {
            throw new Error('Network response was not ok');
          }
        })
        .catch(error => {
          console.error('Error:', error);
        });
      }
    });
  });
  
  
  