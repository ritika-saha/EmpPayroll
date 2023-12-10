package com.payroll;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

public class DBmain {
    public static void main(String[] args) throws SQLException{
        Connection c=DBops.getConnection();
        ArrayList<EmpPayroll> emp=DBops.getAllData();
        System.out.println(emp);
        String updateDisplayQuery="select  ep.emp_id, ep.name, ep.salary, ep.start_date, ep.gender, ep.phone, ep.address, ep.deductions, ep.taxable_pay, ep.income_tax, ep.net_pay, dep.department from employee_payroll ep inner join employee_departments ed on ep.emp_id = ed.emp_id inner join departments dep on ed.dep_id = dep.dep_id where name='Terissa';";
        DBops.updateSalary(3000000, "Terissa",updateDisplayQuery);
        String dateQuery="select  ep.emp_id, ep.name, ep.salary, ep.start_date, ep.gender, ep.phone, ep.address, ep.deductions, ep.taxable_pay, ep.income_tax, ep.net_pay, dep.department from employee_payroll ep inner join employee_departments ed on ep.emp_id = ed.emp_id inner join departments dep on ed.dep_id = dep.dep_id where start_date between cast('2021-01-01' as date) and current_date();";
        ArrayList<String>data=DBops.getDataByDate(dateQuery);
        System.out.println("data by date --------------------->");
        for(String s:data){
            System.out.println(s);
        }
        String statsByGenderQuery="SELECT SUM(CASE WHEN gender = 'M' THEN 1 ELSE 0 END) AS MaleCount, SUM(CASE WHEN gender = 'F' THEN 1 ELSE 0 END) AS FemaleCount, AVG(CASE WHEN gender = 'M' THEN Salary ELSE 0 END) AS AverageMaleSalary, AVG(CASE WHEN gender = 'F' THEN Salary ELSE 0 END) AS AverageFemaleSalary, MIN(CASE WHEN gender = 'M' THEN Salary ELSE NULL END) AS MinMaleSalary, MIN(CASE WHEN gender = 'F' THEN Salary ELSE NULL END) AS MinFemaleSalary, MAX(CASE WHEN gender = 'M' THEN Salary ELSE NULL END) AS MaxMaleSalary, MAX(CASE WHEN gender = 'F' THEN Salary ELSE NULL END) AS MaxFemaleSalary FROM employee_payroll;";
        ArrayList<String> statsData=DBops.getStats(statsByGenderQuery);
        System.out.println("Stats data ------------------------------>");
        for(String s:statsData){
            System.out.println(s);
        }
        c.close();
    }
}


