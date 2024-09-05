# Pin npm packages by running ./bin/importmap

pin "application", to: "application.js"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@rails/ujs", to: "https://ga.jspm.io/npm:@rails/ujs@7.0.0/lib/assets/compiled/rails-ujs.js"
pin "controllers", to: "controllers", preload: true
pin "controllers/metal_controller", to: "metal_controller.js"
pin "stimulus", to: "stimulus.min.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "jquery", to: "https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
pin "lightbox2", to: "https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.3/js/lightbox.min.js"
pin "fullcalendar", to: "https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"
pin "fullcalendar-scheduler", to: "https://cdn.jsdelivr.net/npm/fullcalendar-scheduler@6.1.15/index.global.min.js"
