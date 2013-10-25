<html>
  <head>
    <script type="text/javascript"
            src="../scripts/prototype.js"></script>
    <script type="text/javascript"
            src="../scripts/scriptaculous.js"></script>
    <script type="text/javascript">
      window.onload = function() {
        new Ajax.InPlaceEditor(
          'phoneField',
          '${pageContext.request.contextPath}/checkPhoneNumber', {
            okText: 'Validate',
            cancelLink: false,
            onComplete: function(req,element) {
              if (req.getResponseHeader('x-valid')=='false') {
                $('phoneField').addClassName('fieldInError');
              }
            },
            callback: function(form,entry) {
              $('phoneField').removeClassName('fieldInError');
              return 'value=' + entry;
            }
          }
        );
      }
    </script>
    <style type="text/css">
      .fieldInError {
        border: 1px solid maroon;
        color: maroon;
        background-color: blue;
      }
      .inplaceeditor-form {
        display: inline;
      }
    </style>
  </head>

  <body>

    <p>
      <label>Phone:</label> <span id="phoneField">unspecified</span>
    </p>

  </body>

</html>
