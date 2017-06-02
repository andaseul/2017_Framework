package com.team1.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class HanbitDB {
	private static Connection conn;
	private static String driver = "com.mysql.jdbc.Driver";
	private static String url = "jdbc:mysql://localhost:3306/database?useSSL=false";
	private static String user = "root";
	private static String pw = "mysql";
	
	private HanbitDB() {
		
	}
	
	public static Connection getConnection() throws SQLException, ClassNotFoundException{
		if(conn==null || conn.isClosed()) {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, user, pw);
		}
		return conn;
	}
}
