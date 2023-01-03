import java.sql.*;

public class Transform {
    static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://127.0.0.1:3306/sparsedb?allowPublicKeyRetrieval=true&useUnicode=true&characterEncoding=UTF8&useSSL=false&serverTimezone=UTC";
    static final String USER = "root";
    static final String PASS = "123123";

    /**
     * 向sc表中插入数据
     *
     */
    public static int insertSC(Connection connection, int sno, String col_name, int col_value){
        String sql = "insert into sc values(?, ?, ?)";
        try {
            PreparedStatement pps = connection.prepareStatement(sql);
            pps.setInt(1, sno);
            pps.setString(2, col_name);
            pps.setInt(3, col_value);
            return pps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public static void main(String[] args) throws Exception {
        Class.forName(JDBC_DRIVER);
        Connection connection = DriverManager.getConnection(DB_URL, USER, PASS);
        ResultSet resultSet = null;
        String[] Subject = {"chinese", "math", "english", "physics", "chemistry", "biology", "history", "geography", "politics"};
        try {
            resultSet = connection.createStatement().executeQuery("select * from entrance_exam");
            while (resultSet.next()) {
                int sno = resultSet.getInt("sno"), score;
                for (String subject : Subject) {
                    score = resultSet.getInt(subject);
                    if (!resultSet.wasNull())
                        insertSC(connection, sno, subject, score);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}