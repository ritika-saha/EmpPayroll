package com.payroll;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class DBops {
     // method to connect with the database
     public static Connection getConnection() {
        Connection connection;
        try {
            connection = DriverManager.getConnection(DBcred.URL.getValue(), DBcred.USER.getValue(), DBcred.PASS.getValue());
            System.out.println("Connection success !");
        } catch (SQLException exception) {
            System.out.println(exception.getMessage());
            exception.printStackTrace();
            connection = null;
        }
        return connection;
    }

    public static ArrayList<EmpPayroll> getAllData(){
        ArrayList<EmpPayroll> dataList=new ArrayList<>();
        String query="select  ep.emp_id, ep.name, ep.salary, ep.start_date, ep.gender, ep.phone, ep.address, ep.deductions, ep.taxable_pay, ep.income_tax, ep.net_pay, dep.department from employee_payroll ep inner join employee_departments ed on ep.emp_id = ed.emp_id inner join departments dep on ed.dep_id = dep.dep_id;";

        try(Connection connection=getConnection();
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(query)
        ){
            while(resultSet.next()){
                 int id=resultSet.getInt("emp_id");
                 String name=resultSet.getString("name");
                 double salary=resultSet.getDouble("salary");
                 String start_date=resultSet.getString("start_date");
                 String gender=resultSet.getString("gender");
                 String phone=resultSet.getString("phone");
                 String address=resultSet.getString("address");     
                 double deductions=resultSet.getDouble("deductions");
                 double taxable_pay=resultSet.getDouble("taxable_pay");
                 double income_tax=resultSet.getDouble("income_tax");
                 double net_pay=resultSet.getDouble("net_pay");
                 String department=resultSet.getString("department");
                 EmpPayroll employee=new EmpPayroll(id,  name,  start_date,  gender,  phone,  address, salary, deductions, taxable_pay, income_tax, net_pay, department);
                 dataList.add(employee);
            }
        }catch(SQLException exception) {
            System.out.println(exception.getMessage());
            exception.printStackTrace();
        }

        return dataList;
    }

     public static void updateSalary(int salary, String name,String updateDisplayQuery) {
        String sqlQuery = "update employee_payroll set salary = ? where name = ?;";
        
        try (
                Connection connection = getConnection();
                PreparedStatement statement = connection.prepareStatement(sqlQuery)) {
            statement.setInt(1, salary);
            statement.setString(2, name);
            statement.executeUpdate();
            System.out.println("Salary Updated for employee "+name+" --------------------->\n");
            PreparedStatement statement2=connection.prepareStatement(updateDisplayQuery);
            ResultSet resultSet=statement2.executeQuery(updateDisplayQuery);
            while(resultSet.next()){
                 int id=resultSet.getInt("emp_id");
                 String name1=resultSet.getString("name");
                 double salary1=resultSet.getDouble("salary");
                 String start_date=resultSet.getString("start_date");
                 String gender=resultSet.getString("gender");
                 String phone=resultSet.getString("phone");
                 String address=resultSet.getString("address");     
                 double deductions=resultSet.getDouble("deductions");
                 double taxable_pay=resultSet.getDouble("taxable_pay");
                 double income_tax=resultSet.getDouble("income_tax");
                 double net_pay=resultSet.getDouble("net_pay");
                 String department=resultSet.getString("department");
                 System.out.println("Employee Payroll{" +
                 "emp_id=" + id +
                 ", name='" + name1 + '\'' +
                 ", start_date="+start_date+ '\'' +
                 ", gender="+gender+ '\'' +
                 ", phone="+phone+ '\'' +
                 ", address="+address+ '\'' +
                 ", salary="+salary1+ '\'' +
                 ", deductions="+deductions+ '\'' +
                 ", taxable pay="+taxable_pay+ '\'' +
                 ", income tax="+income_tax+ '\'' +
                 ", net pay="+net_pay+ '\'' +
                 ", department="+department+ '\'' +
                 '}'+'\n');
            }

        } catch (SQLException exception) {
            System.out.println(exception.getMessage());
            exception.printStackTrace();
        }
    }

     // to get employees joined between particular dates
     public static ArrayList<String> getDataByDate(String sqlQuery) {
        ArrayList<String> data = new ArrayList<>();
        try (
                Connection connection = getConnection();
                Statement statement = connection.createStatement();
                ResultSet resultSet = statement.executeQuery(sqlQuery)) {
            while (resultSet.next()) {
                 int id=resultSet.getInt("emp_id");
                 String name1=resultSet.getString("name");
                 double salary1=resultSet.getDouble("salary");
                 String start_date=resultSet.getString("start_date");
                 String gender=resultSet.getString("gender");
                 String phone=resultSet.getString("phone");
                 String address=resultSet.getString("address");     
                 double deductions=resultSet.getDouble("deductions");
                 double taxable_pay=resultSet.getDouble("taxable_pay");
                 double income_tax=resultSet.getDouble("income_tax");
                 double net_pay=resultSet.getDouble("net_pay");
                 String department=resultSet.getString("department");
                 String totalData="Employee Payroll{" +
                 "emp_id=" + id +
                 ", name='" + name1 + '\'' +
                 ", start_date="+start_date+ '\'' +
                 ", gender="+gender+ '\'' +
                 ", phone="+phone+ '\'' +
                 ", address="+address+ '\'' +
                 ", salary="+salary1+ '\'' +
                 ", deductions="+deductions+ '\'' +
                 ", taxable pay="+taxable_pay+ '\'' +
                 ", income tax="+income_tax+ '\'' +
                 ", net pay="+net_pay+ '\'' +
                 ", department="+department+ '\'' +
                 '}'+'\n';
                 data.add(totalData);
            }
        } catch (SQLException exception) {
            System.out.println(exception.getMessage());
            exception.printStackTrace();
        }
        return data;
    }

    public static ArrayList<String> getStats(String query){
         ArrayList<String> data = new ArrayList<>();
        try (
                Connection connection = getConnection();
                Statement statement = connection.createStatement();
                ResultSet resultSet = statement.executeQuery(query)) {
            while (resultSet.next()) {  
                int MaleCount=resultSet.getInt("MaleCount");
                int FemaleCount=resultSet.getInt("FemaleCount");
                int AverageMaleSalary=resultSet.getInt("AverageMaleSalary");
                int AverageFemaleSalary=resultSet.getInt("AverageFemaleSalary");
                int MinMaleSalary=resultSet.getInt("MinMaleSalary");
                int MinFemaleSalary=resultSet.getInt("MinFemaleSalary");
                int MaxMaleSalary=resultSet.getInt("MaxMaleSalary");
                int MaxFemaleSalary=resultSet.getInt("MaxFemaleSalary");
                 String totalData="Stats by gender{" +
                 "male count=" + MaleCount +
                 ", female count='" + FemaleCount + '\'' +
                 ", average male salary='" + AverageMaleSalary + '\'' +
                 ", average female salary='" + AverageFemaleSalary + '\'' +
                 ", min male salary='" + MinMaleSalary + '\'' +
                 ", min female salary='" + MinFemaleSalary + '\'' +
                 ", max male salary='" + MaxMaleSalary + '\'' +
                 ", max female salary='" + MaxFemaleSalary + '\'' +
                  '}'+'\n';
                  data.add(totalData);
            }
        } catch (SQLException exception) {
            System.out.println(exception.getMessage());
            exception.printStackTrace();
        }
        return data;
    }
}
