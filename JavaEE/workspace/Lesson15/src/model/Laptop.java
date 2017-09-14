package model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the laptop database table.
 * 
 */
@Entity
@Table(name="laptop")
@NamedQuery(name="Laptop.findAll", query="SELECT l FROM Laptop l")
public class Laptop implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private int id;

	@Column(name="laptop_name")
	private String laptopName;

	@Column(name="laptop_os")
	private String laptopOs;

	//bi-directional one-to-one association to Employee
	@OneToOne(mappedBy="laptop")
	private Employee employee;

	public Laptop() {
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getLaptopName() {
		return this.laptopName;
	}

	public void setLaptopName(String laptopName) {
		this.laptopName = laptopName;
	}

	public String getLaptopOs() {
		return this.laptopOs;
	}

	public void setLaptopOs(String laptopOs) {
		this.laptopOs = laptopOs;
	}

	public Employee getEmployee() {
		return this.employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

}