package org.bibeault.sq.chap6;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import java.io.IOException;

public class MoviesListServlet extends HttpServlet {

    public void doGet( HttpServletRequest request,
                       HttpServletResponse response )
            throws IOException, ServletException {
        for (String movie : MoviesList.getMovies()) {
            response.getWriter().println( movie );
        }
    }

    public void doPost( HttpServletRequest request,
                        HttpServletResponse response )
            throws IOException, ServletException {
        doGet( request, response );
    }

}
