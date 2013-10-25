<html>
  <head>
    <title>Scriptaculous Ajax Autocompleter Lab</title>
    <link rel="stylesheet" type="text/css" href="../styles.css"/>
    <link rel="stylesheet" type="text/css" href="../styles-autocompleter.css"/>
    <script type="text/javascript" src="../scripts/prototype.js"></script>
    <script type="text/javascript" src="../scripts/scriptaculous.js"></script>
    <script type="text/javascript" src="../scripts/lab-support.js"></script>
    <script type="text/javascript">
      function onApply() {
        var form = document.optionsForm;
        var options = LabSupport.collectOptions(form);
        if ($F('serverDelay')!='') options.parameters = 'delay=' + $F('serverDelay');
        $('optionsDisplay').innerHTML = LabSupport.optionsAsText(options);
        $('autocompleterContainer').show();
        new Ajax.Autocompleter(
          "autocompleteField",
          "autocompleteMenu",
          "${pageContext.request.contextPath}/getAutocompleterChoices",
          options
        );
        $('autocompleteField').focus();
        return false;
      }
    </script>
  </head>

  <body class="labPage">

    <form name="optionsForm" onsubmit="return onApply()">

      <div class="optionsDisplay">
        <fieldset>
          <legend>Applied Options</legend>
          <div id="optionsDisplay"></div>
        </fieldset>
      </div>

      <div style="float:left">
        <fieldset>
          <legend>Ajax.Autocompleter Options</legend>

          <div>
            <label>paramName:</label>
            <input type="text" name="paramName" readonly="readonly" value="value"/>
          </div>

          <div>
            <label>minChars:</label>
            <input type="text" name="minChars" class="numeric"/>
          </div>

          <div>
            <label>frequency:</label>
            <input type="text" name="frequency" class="numeric"/>
          </div>

          <div>
            <label>indicator:</label>
            <input type="radio" name="indicator" value="animatedIndicator" class="booleanValue"/>Yes
            <input type="radio" name="indicator" value="" class="booleanValue"/>No
          </div>

          <div>
            <label>token:</label>
            <input type="text" name="tokens"/> (single character only)
          </div>

        </fieldset>

        <fieldset>
          <legend>Other stuff</legend>

          <div>
            <label>server delay:</label>
            <input type="text" id="serverDelay" class="numeric"/> (in milliseconds)
          </div>

        </fieldset>

        <div style="margin-top:12px">
          <input type="submit" value="Create Autocompleter"/>
          <input type="reset"/>
        </div>

      </div>

    </form>


    <div id="autocompleterContainer" style="clear:both;display:none;padding-top:18px">
      <label>Movie title: </label>
      <input type="text" id="autocompleteField" name="autocompleteParameter" style="width:300px"/>
      <div id="autocompleteMenu" class="autocomplete"></div>
      <div id="animatedIndicator" style="display:none"><img src="bear.gif"/></div>
    </div>

  </body>

</html>
