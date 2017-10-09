package model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the employee database table.
 * 
 */
@Entity
@Table(name="employee")
@NamedQuery(name="Employee.findAll", query="SELECT e FROM Employee e")
public class Employee implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private int id;

	@Column(name="employee_name")
	private String employeeName;

	//bi-directional one-to-one association to Laptop
	@OneToOne
	@JoinColumn(name="laptop_id")
	private Laptop laptop;

	public Employee() {
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getEmployeeName() {
		return this.employeeName;
	}

	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}

	public Laptop getLaptop() {
		return this.laptop;
	}

	public void setLaptop(Laptop laptop) {
		this.laptop = laptop;
	}

}