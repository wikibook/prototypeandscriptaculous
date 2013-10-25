package org.bibeault.sq.chap6;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class MoviesAutocompleterServlet extends HttpServlet {

    public static final String KEY_VALUE = "value";
    public static final String KEY_DELAY = "delay";

    public static final String VAR_LIST = "list";

    public static final String VIEW_RESOURCE =
            "/autocompleter-ajax/unordered-list.jsp";

    public void doPost( HttpServletRequest request,
                        HttpServletResponse response )
            throws IOException, ServletException {
        doGet( request, response );
    }

    public void doGet( HttpServletRequest request,
                       HttpServletResponse response )
            throws IOException, ServletException {
        //
        // If a delay was requested, cuase the delay to occur
        //
        if (request.getParameter( KEY_DELAY ) != null) {
            delay(request.getParameter( KEY_DELAY ));
        }
        //
        // Get the passed prefix and obtain the list of matches
        //
        String prefix = request.getParameter( KEY_VALUE );
        List<String> matches = findMatches( prefix );
        //
        // Set the matches as a scoped variable on the request
        // and shuffle off to the JSP
        //
        request.setAttribute( VAR_LIST, matches );
        request.getRequestDispatcher( VIEW_RESOURCE  )
            .forward( request, response );
    }

    private void delay( String delayValue ) {
        try {
            Thread.sleep( Integer.parseInt( delayValue ) );
        }
        catch (Exception e) {
            //On failure, perform no delay
        }
    }

    private List<String> findMatches( String prefix ) {
        List<String> matches = new ArrayList<String>();
        for (String choice : MoviesList.getMovies()) {
            if (choice.startsWith( prefix )) matches.add( choice );
        }
        return matches;
    }

}
