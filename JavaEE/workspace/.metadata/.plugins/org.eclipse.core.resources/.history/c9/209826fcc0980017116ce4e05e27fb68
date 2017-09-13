import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ProcessForm")
public class ApplicationServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws	ServletException, IOException {

		String nextPage = "/login.jsp";
		getServletContext().getRequestDispatcher(nextPage).forward(request,response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();

		String email = request.getParameter("email");
		String password = request.getParameter("password");

		String message = "";
		String nextPage = "/login.jsp";

		//check for null values then check for empty (blank) values... check null first!
		if(email!=null && !email.isEmpty()){
			//email contains data.... check the password
			if(password!=null && !password.isEmpty()){
				//check the database for the valid email and password
				//we'll learn about databases later, right now, just 
				//check the values to illustrate the concept
				if(email.equalsIgnoreCase("duke@java.com") && password.equals("java123"))
				{
					message = "Thank you, you are valid";  
					session.setAttribute("message", message);
					session.setAttribute("email",email);
					session.setAttribute("password",password);
					nextPage = "/output.jsp";
				}
				else
				{
					session.invalidate();
					nextPage = "/login.jsp";
				}
			}
		}

		//Redirect to next page as indicated by the value of the nextPage variable
		getServletContext().getRequestDispatcher(nextPage).forward(request,response);
	}
}