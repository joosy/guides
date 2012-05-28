var fixGistRules = [
".gist .gist-highlight {  border-left: 3ex solid #eee;  position: relative;}",
".gist .gist-highlight pre { counter-reset: linenumbers;}",
".gist .gist-highlight pre div:before { color: #aaa; content: counter(linenumbers); counter-increment: linenumbers;  left: -3ex; position: absolute; text-align: right; width: 2.5ex;}" ];

var head = document.getElementsByTagName('head')[0],
    style = document.createElement('style');

rules = new Array();
var i=0;
for ( i=0; i< fixGistRules.length; i++ ){
  var fullrule = document.createTextNode(fixGistRules[i]);
  rules.push(fullrule);
}

style.type = 'text/css';

for ( var i=0; i< rules.length; i++ ){
  if(style.styleSheet){
    style.styleSheet.cssText = rules[i].nodeValue;
  }else {
    style.appendChild(rules[i]);
    head.appendChild(style);
  }
}