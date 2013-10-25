<html>
  <head>
    <script type="text/javascript"
            src="../scripts/prototype.js"></script>
    <script type="text/javascript"
            src="../scripts/scriptaculous.js"></script>
    <script type="text/javascript">
      window.onload = function() {
        new Ajax.InPlaceEditor(
          'emailField',
          '${pageContext.request.contextPath}/checkEmailAddress',
          {
            okText: 'Validate',
            cancelLink: false,
            onComplete: function(req,element) {
              if (req.getResponseHeader('x-valid')=='false') {
                $('emailField').addClassName('fieldInError');
              }
            },
            callback: function(form,entry) {
              $('emailField').removeClassName('fieldInError');
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
      <label>Email address:</label> <span id="emailField">Click to edit</span>
    </p>

  </body>

</html>
