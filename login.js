window.onload = function(){
  document.getElementById('btnLogin').onclick = function(){
      var url = 'https://dev.imaicloud.com/couchdb/_session';
      var xhr = new XMLHttpRequest();
      if (!('withCredentials' in xhr)) {
          xhr = XDomainRequest();
      }
      xhr.open('POST', url, true);
      xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded");
      xhr.onreadystatchanged = function(){
        if (xhr.readyState == 4){
          console.log(xhr.responseText)
        }
      };
      var name = document.getElementByName('name'), pwd = document.getElementByName('password');
      xhr.send('name='+name+'&password='+pwd);
      xhr.onload = function(){
          console.log(xhr.responseText);
      };
  }
}
