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
      var name = document.getElementsByName('name')[0], pwd = document.getElementsByName('password')[0];
      xhr.send('name='+name+'&password='+pwd);
      xhr.onload = function(){
          console.log(xhr.responseText);
      };
  }
}
