package database;

import java.sql.SQLException;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.DriverManager;

public class DB{
	
	public final static String DRIVER_MYSQL = "com.mysql.jdbc.Driver";
        public final static String DRIVERMGRCONN_MYSQL = "jdbc:mysql:";

	private Connection conn;
	private ResultSet rs;
	private Statement statement;
	private String db;
	private String user;
	private String pwd;
	private String driver;
	private String driverMgrConn;

      public DB(){
      rs = null;
      statement = null;
      
      db = "//localhost:3306/hostel";  
      user = "root";
      pwd = "";

      driver = DRIVER_MYSQL;
      driverMgrConn = DRIVERMGRCONN_MYSQL;
   }

   public boolean connect(){
		try{
                    
			Class.forName(driver);
			conn = DriverManager.getConnection(driverMgrConn + db , user, pwd);

			//conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/ipproject?autoReconnect=true");

			//conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/TFMSbd?user=root&password=&autoReconnect=true");

			conn.setAutoCommit(false);
                        System.out.println("okey");
			return true;
		}
		catch(SQLException sqlEx){
			System.out.println("sqlEx : "+sqlEx.getMessage());

			return false;
		}
		catch(ClassNotFoundException classEx){
			System.out.println("classNotFound : "+classEx.getMessage());

			return false;
		}
   }

   public boolean query(String sql){
		try{
			if(sql.substring(0, 6).toLowerCase().equals("select")){
				statement = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
				rs = statement.executeQuery(sql);
                                System.out.println("sql "+sql+ "done");
                                
			}
			else{
				statement = conn.createStatement();
                                System.out.println("sql:"+sql);
                                statement.executeUpdate(sql);
                                System.out.println("Done");
			}

			return true;
		}
		catch(SQLException sqlEx){
			System.out.println("error:"+sqlEx.getMessage());

			return false;
		}
	}

	public void rollback(){
   	try{
   		conn.rollback();
   	}
   	catch(SQLException sqlEx){
			System.out.println(sqlEx.getMessage());
		}
   }

   public int getNumberOfRows(){
		try{
			rs.last();

			return rs.getRow();
		}
		catch(SQLException sqlEx){
			System.out.println(sqlEx.getMessage());

			return 0;
		}
	}
	public String getDataAt(int row, String columnName){
		try{
			rs.absolute(row+1);

			return rs.getString(columnName);
		}
		catch(SQLException sqlEx){
			System.out.println(sqlEx.getMessage());

			return null;
		}
	}
	public void close(){
		try{
			statement.close();
			conn.commit();
			conn.close();
		}
		catch(SQLException sqlEx){
			System.out.println(sqlEx.getMessage());
		}
	}
}
