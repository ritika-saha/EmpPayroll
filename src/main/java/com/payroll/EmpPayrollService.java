package com.payroll;

import java.util.Scanner;

public class EmpPayrollService {
      private EmpPayroll readEmployeePayrollData() {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter Employee ID: ");
        int id = scanner.nextInt();
        System.out.print("Enter Employee Name: ");
        String name = scanner.next();
        System.out.print("Enter Employee Salary: ");
        double salary = scanner.nextDouble();
        scanner.close();
        return new EmpPayroll(id, name, salary);
    }

    private void writeEmployeePayrollData(EmpPayroll employeePayroll) {
        System.out.println("Employee Payroll Data: " + employeePayroll);
    }

    public static void main(String[] args) {
        EmpPayrollService service = new EmpPayrollService();
        EmpPayroll payroll = service.readEmployeePayrollData();
        service.writeEmployeePayrollData(payroll);
    }
}