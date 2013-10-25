package org.bibeault.sq.chap6;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.regex.Pattern;
import java.io.IOException;

public class CheckEmailAddressServlet extends HttpServlet {

    private static final String KEY_VALUE = "value";
    private static final String REGEX_EMAIL = "(\\w)+@(\\w)+\\.(\\w)+";
    private static final String HEADER_VALID = "x-valid";

    public void doGet( HttpServletRequest request, HttpServletResponse response ) throws IOException {
        String value = request.getParameter( KEY_VALUE );
        boolean ok = Pattern.compile( REGEX_EMAIL ).matcher( value ).matches();
        response.setHeader( HEADER_VALID, String.valueOf( ok ) );
        response.getWriter().write( value );
    }

    public void doPost( HttpServletRequest request, HttpServletResponse response ) throws IOException {
        doGet( request, response );
    }

}
