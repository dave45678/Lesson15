import java.io.IOException;

import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ProcessForm")
public class ApplicationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

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
		if(email!=null && !email.isEmpty() && isValidEmailAddress(email)){
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
				}else{
					message += "Email or Password is invalid. Try again!<br/>";
					session.invalidate();
					nextPage = "/login.jsp";
				}
			}else{
				message += "Null or blank values are not permitted!<br/>";
			}
		}else{
			message += "Null or blank values are not permitted!<br/>";
		}

		//Redirect to next page as indicated by the value of the nextPage variable
		getServletContext().getRequestDispatcher(nextPage).forward(request,response);
	}
	public static boolean isValidEmailAddress(String email) {
		   boolean result = true;
		   try {
		      InternetAddress emailAddr = new InternetAddress(email);
		      emailAddr.validate();
		   } catch (AddressException ex) {
		      result = false;
		   }
		   return result;
		}
}