let userId = document.getElementsByClassName("userId");
// declear request it's an object from XMLHttpRequest
let request = new XMLHttpRequest();
// request has open function take 2 params the method and url
request.open("GET", "https://jsonplaceholder.typicode.com/posts");
// response type by default it's text i chaned to json
request.responseType = "json";
// after set all setting send the request
request.send();
// after i recive response do something
request.onload = function () {
  console.log(request.response);
  let posts = request.response;
  for (post of posts) {
    console.log(post.userId);
  }
};
