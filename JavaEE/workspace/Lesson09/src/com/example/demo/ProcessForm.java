package com.example.demo;

import java.io.IOException;
import java.util.ArrayList;

import javax.persistence.EntityManager;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import customTools.DbUtil;
import model.Customer;
import model.DbCustomer;


@WebServlet("/ProcessForm")
public class ProcessForm extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String message = "";
		HttpSession session = request.getSession();
		
		EntityManager em = DbUtil.getEmFactory().createEntityManager();
		ArrayList<Customer> customers = new ArrayList<Customer>();
		customers = (ArrayList<Customer>) DbCustomer.getAllCustomers();
		session.setAttribute("customers",customers);
		request.getRequestDispatcher("/output.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		doGet(request, response);
	}

}
