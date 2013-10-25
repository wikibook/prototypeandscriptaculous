<html>
  <head>
    <title>Scriptaculous Local Autocompleter Lab</title>
    <link rel="stylesheet" type="text/css" href="../styles.css"/>
    <link rel="stylesheet" type="text/css" href="../styles-autocompleter.css"/>
    <script type="text/javascript" src="../scripts/prototype.js"></script>
    <script type="text/javascript" src="../scripts/scriptaculous.js"></script>
    <script type="text/javascript" src="../scripts/lab-support.js"></script>
    <script type="text/javascript">
      function onApply() {
        var form = document.optionsForm;
        var options = LabSupport.collectOptions(form);
        var choicesList = new Array();
        $F('choicesList').split('\n').each(
          function(item) {
            if (item.length != 0) choicesList.push(item);
          }
        );
        $('optionsDisplay').innerHTML = LabSupport.optionsAsText(options);
        $('autocompleterContainer').show();
        new Autocompleter.Local(
          "autocompleteField",
          "autocompleteMenu",
          choicesList,
          options
        );
        $('autocompleteField').focus();
        return false;
      }

      function onPreload() {
        new Ajax.Request(
          '${pageContext.request.contextPath}/getMoviesList',
          {
            onSuccess: function(transport) { $('choicesList').value = transport.responseText; }
          }
        );
      }
    </script>
  </head>

  <body>

    <form name="optionsForm" onsubmit="return onApply()">

      <div class="optionsDisplay">
        <fieldset>
          <legend>Applied Options</legend>
          <div id="optionsDisplay"></div>
        </fieldset>
      </div>

      <div style="float:left">
        <fieldset>
          <legend>Autocompleter.Local Options</legend>

          <div>
            <label>minChars:</label>
            <input type="text" name="minChars" class="numeric"/>
          </div>

          <div>
            <label>frequency:</label>
            <input type="text" name="frequency" class="numeric"/>
          </div>

          <div>
            <label>choices:</label>
            <input type="text" name="choices" class="numeric"/>
          </div>

          <div>
            <label>partialSearch:</label>
            <input type="radio" name="partialSearch" value="true" class="boolean"/>Yes
            <input type="radio" name="partialSearch" value="false" class="boolean"/>No
          </div>

          <div>
            <label>partialChars:</label>
            <input type="text" name="partialChars" class="numeric"/>
          </div>

          <div>
            <label>fullSearch:</label>
            <input type="radio" name="fullSearch" value="true" class="boolean"/>Yes
            <input type="radio" name="fullSearch" value="false" class="boolean"/>No
          </div>

          <div>
            <label>ignoreCase:</label>
            <input type="radio" name="ignoreCase" value="true" class="boolean"/>Yes
            <input type="radio" name="ignoreCase" value="false" class="boolean"/>No
          </div>

        </fieldset>

        <fieldset>
          <legend>Choices list</legend>

          <div>
            <div><label>List choices, one per line:</label></div>
            <div><textarea id="choicesList" rows="8" cols="44"></textarea></div>
            <div><button type="button" onclick="onPreload()" style="margin-top:8px">Preload with Movie Titles</button></div>
          </div>

        </fieldset>

        <div style="margin-top:12px">
          <input type="submit" value="Create Autocompleter"/>
          <input type="reset"/>
        </div>

      </div>

    </form>


    <div id="autocompleterContainer" style="clear:both;display:none;padding-top:18px">
      <label>Text field:</label>
      <input type="text" id="autocompleteField" name="autocompleteParameter" style="width:300px"/>
      <div id="autocompleteMenu" class="autocomplete"></div>
      <div id="animatedIndicator" style="display:none"><img src="bear.gif"/></div>
    </div>

  </body>

</html>
