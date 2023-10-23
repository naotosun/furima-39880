const pay = () => {
  const payjp = Payjp('pk_test_7c4cc10210bbde3371d5a6f0')// PAY.JPテスト公開鍵
  // elementsインスタンスを作成
  const elements = payjp.elements();
  const form = document.getElementById("charge-form")
  form.addEventListener("submit", (e) => {
    console.log("フォーム送信時にイベント発火")
    e.preventDefault();
  });
};

window.addEventListener("turbo:load", pay);