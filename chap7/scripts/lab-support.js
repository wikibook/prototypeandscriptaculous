var LabSupport = {};

LabSupport.collectOptions = function(form) {
  var options = {};
  $A(form.getElementsByTagName('input')).each(
    function(element) {
      if (element.name !='' && element.value != '') {
        if (element.className == 'numeric') {
          options[element.name] = new Number(element.value);
        }
        else if (element.className == 'boolean') {
          if (element.checked) options[element.name] = element.value == 'true';
        }
        else if (element.className == 'booleanValue') {
          if (element.checked) options[element.name] = element.value;
        }
        else if (element.className == 'ignore') {
        }
        else {
          options[element.name] = element.value;
        }
      }
    }
  );
  return options;
}

LabSupport.optionsAsText = function(options) {
  var text = '<pre>{<br/>';
  for (p in options) text += ('  ' + p + ': ' + LabSupport.valueAsText(options[p]) + '<br/>')
  text += '}<br/></pre>';
  return text;
}

LabSupport.valueAsText = function(data) {
  if (typeof data == 'string') {
    return "'" + data + "'";
  }
  else if (data instanceof ObjectRange) {
    return '$R(' + data.start + ',' + data.end + ')';
  }
  else if (data instanceof Array) {
    return '[' + data + ']';
  }
  else {
    return data;
  }
}

LabSupport.say = function(what) {
  $('messagesDisplay').innerHTML = what;
}
