package com.payroll;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
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

    private void writeEmployeePayrollData(String path) {
       try(BufferedWriter writer=new BufferedWriter(new FileWriter(path))){
        for(EmpPayroll data : payrollList){
            writer.write(data.toString()+"\n");
        }
        System.out.println("Data Written to file");
       }catch(IOException e){
        e.printStackTrace();
       }
    }

    public int countEntries(String path){
        int entryCount = 0;
        try (BufferedReader reader = new BufferedReader(new FileReader(path))) {
            while (reader.readLine() != null) 
            entryCount++;
        } catch (IOException e) {
            e.printStackTrace();
        }
        return entryCount;
    }

    public static void main(String[] args) {
        EmpPayrollService service = new EmpPayrollService();
        service.readEmployeePayrollData();
        service.readEmployeePayrollData();
        service.readEmployeePayrollData();
        String path="PayrollData.txt";
        service.writeEmployeePayrollData(path);
        System.out.println("-------------------------- following data -------------------------------");
        System.out.println(service.payrollList);
        System.out.println("-------------------------------------------------------------------------");
        int entryCount=service.countEntries(path);
        System.out.println("Number of Employee payroll entries : "+entryCount);
    }
}