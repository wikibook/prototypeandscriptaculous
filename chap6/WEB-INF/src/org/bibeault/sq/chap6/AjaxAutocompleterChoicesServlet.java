package org.bibeault.sq.chap6;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class AjaxAutocompleterChoicesServlet extends HttpServlet {

    public static final String KEY_VALUE = "value";
    public static final String KEY_DELAY = "delay";

    public static final String VAR_LIST = "list";

    public void doGet( HttpServletRequest request,
                       HttpServletResponse response )
            throws IOException, ServletException {
        if (request.getParameter( KEY_DELAY ) != null) {
            delay(request.getParameter( KEY_DELAY ));
        }
        String prefix = request.getParameter( KEY_VALUE );
        List<String> matches = new ArrayList<String>();
        for (String choice : MoviesList.getMovies()) {
            if (choice.startsWith( prefix )) matches.add( choice );
        }
        request.setAttribute( VAR_LIST, matches );
        request.getRequestDispatcher( "/autocompleter-ajax/choice-list.jsp" )
            .forward( request, response );
    }

    public void doPost( HttpServletRequest request,
                        HttpServletResponse response )
            throws IOException, ServletException {
        doGet( request, response );
    }

    private void delay( String delayValue ) {
        try {
            Thread.sleep( Integer.parseInt( delayValue ) );
        }
        catch (Exception e) {
            //On failure, perform no delay
        }
    }

}
