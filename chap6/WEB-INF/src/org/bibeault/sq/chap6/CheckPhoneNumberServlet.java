package org.bibeault.sq.chap6;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class CheckPhoneNumberServlet extends HttpServlet {

    private static final String KEY_VALUE = "value";
    private static final String HEADER_VALID = "x-valid";

    public void doGet( HttpServletRequest request, HttpServletResponse response ) throws IOException {
        String value = request.getParameter( KEY_VALUE );
        StringBuilder digits = new StringBuilder();
        for (int n = 0; n < value.length(); n++) {
          if (Character.isDigit( value.charAt( n ) )) {
            digits.append( value.charAt( n ) );
          }
        }
        if (digits.length() == 10) {
          value = new StringBuilder()
              .append( '(' )
              .append( digits.substring( 0, 3 ) )
              .append( ')' )
              .append( digits.substring( 3, 6 ) )
              .append( '-' )
              .append( digits.substring( 6 ) )
              .toString();
        }
        else {
          response.setHeader( HEADER_VALID, Boolean.FALSE.toString() );
        }
        response.getWriter().write( value );
    }

    public void doPost( HttpServletRequest request, HttpServletResponse response ) throws IOException {
        doGet( request, response );
    }

}
