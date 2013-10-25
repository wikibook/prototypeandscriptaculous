if (document.all) Node = { ELEMENT_NODE: 1 };

function TogglePane( fieldset, useDefaultStyling ) {
  //
  // Get references to the fieldset and its legend
  //
  this.fieldset = $(fieldset);
  if (!this.fieldset)
    throw new Error('cannot locate fieldset ' + fieldset);
  if (this.fieldset.tagName != 'FIELDSET')
    throw new Error('passed element must be a fieldset');
  this.legend = this.fieldset.getElementsByTagName('legend')[0];
  if (!this.legend)
    throw new Error('cannot locate fieldset\'s legend');
  //
  // Add the tooglePane class to the fieldset
  //
  Element.addClassName(this.fieldset,'togglePane');
  //
  // Set up the onclick handler for the legend
  //
  var fieldsetElement = this.fieldset;
  this.legend.onclick = function() {
    $A(fieldsetElement.childNodes).each(
      function(child) {
        if (child.nodeType == Node.ELEMENT_NODE &&
            child.tagName != 'LEGEND') {
          Effect.toggle(child);
        }
      }
    );
  }
  //
  // Apply default styling to the legend if enabled
  //
  if (useDefaultStyling == true) this.applyDefaultStyling();
}

TogglePane.prototype.applyDefaultStyling = function() {
  this.legend.style.borderWidth = '3px';
  this.legend.style.borderStyle = 'outset';
  this.legend.style.borderColor = '#888888';
  this.legend.style.backgroundColor = '#bbbbbb';
  this.legend.style.cursor = 'pointer';
  this.legend.style.paddingTop = '1px';
  this.legend.style.paddingBottom = '1px';
  this.legend.style.paddingLeft = '18px';
  this.legend.style.paddingRight = '18px';
  this.legend.style.fontSize = '0.8em';
}
