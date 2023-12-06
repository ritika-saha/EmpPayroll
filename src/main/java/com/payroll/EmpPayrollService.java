package com.payroll;

import java.util.ArrayList;
import java.util.Scanner;

public class EmpPayrollService {
    public ArrayList<EmpPayroll> payrollList;

    public EmpPayrollService(){
        payrollList=new ArrayList<>();
    }
      private void readEmployeePayrollData() {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter Employee ID: ");
        int id = scanner.nextInt();
        System.out.print("Enter Employee Name: ");
        String name = scanner.next();
        System.out.print("Enter Employee Salary: ");
        double salary = scanner.nextDouble();
        payrollList.add(new EmpPayroll(id, name, salary));
    }

    private void writeEmployeePayrollData(EmpPayroll employeePayroll) {
        System.out.println("Employee Payroll Data: " + employeePayroll);
    }

    public static void main(String[] args) {
        EmpPayrollService service = new EmpPayrollService();
        service.readEmployeePayrollData();
        service.readEmployeePayrollData();
        service.readEmployeePayrollData();
        
    }
}