document.addEventListener("turbo:load", () => {
    const flashWindow = document.getElementsByClassName("flash-window")[0];
    if (flashWindow) {
      flashWindowToggle();
      setTimeout(flashWindowToggle, 3000); // 3秒後にフラッシュメッセージを自動で非表示にする
      const deleteButton = document.getElementsByClassName("flash-window--delete")[0];
      if (deleteButton) {
        deleteButton.addEventListener('click', flashWindowToggle); // バツボタンがクリックされた時の処理
      }
    }
  
    function flashWindowToggle() {
      flashWindow.classList.toggle("hidden");
    }
  });