// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "jquery";  // jQueryを先にインポート
import "@hotwired/turbo-rails";
import "controllers";
import Rails from '@rails/ujs';
Rails.start();

document.addEventListener("turbo:load", function() {  
    const sidebarToggle = document.getElementById("sidebar-toggle");
    const sidebarClose = document.getElementById("sidebar-close");
    const sidebar = document.getElementById("sidebar");

    if (sidebarToggle) {
        sidebarToggle.addEventListener("click", function() {
            sidebar.classList.toggle("sidebar-open");
        });
    }

    if (sidebarClose) {
        sidebarClose.addEventListener("click", function() {
            sidebar.classList.remove("sidebar-open");
        });
    }

  const prosthesisTypeInsuranceSelect = document.getElementById("patient_prosthesis_type_insurance");
  const prosthesisTypeCrownSelect = document.getElementById("patient_prosthesis_type_crown");
  const prosthesisTypeDentureSelect = document.getElementById("patient_prosthesis_type_denture");
  const metalTypeSelect = document.getElementById("patient_metal_type");

  function updateMetalType(prosthesisType) {
    if (prosthesisType === "In" || prosthesisType === "FMC" || prosthesisType === "Br" || prosthesisType === "前装冠" || prosthesisType === "前装Br" || prosthesisType === "キーパー" || prosthesisType === "コーピング") {
      metalTypeSelect.value = "Pd";
    } else if (prosthesisType === "GIn" || prosthesisType === "GFMC" || prosthesisType === "GBr" || prosthesisType === "G装冠" || prosthesisType === "G装冠Br" || prosthesisType === "コア(Au)") {
      metalTypeSelect.value = "Au";
    } else if (prosthesisType === "コア(Ag)") {
      metalTypeSelect.value = "Ag";
    } else {
      metalTypeSelect.value = "";
    }
  }

  // イベントリスナーの設定
  if (prosthesisTypeInsuranceSelect) {
    prosthesisTypeInsuranceSelect.addEventListener("change", function() {
      updateMetalType(this.value);
    });
  }

  if (prosthesisTypeCrownSelect) {
    prosthesisTypeCrownSelect.addEventListener("change", function() {
      updateMetalType(this.value);
    });
  }

  if (prosthesisTypeDentureSelect) {
    prosthesisTypeDentureSelect.addEventListener("change", function() {
      updateMetalType(this.value);
    });
  }

  
 
  
});



