using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace waSFA
{
    public class ConnectionDB
    {
        string ConnectionString = "Data Source=CIQ-R90AF5WZ\\LOCAL;Initial Catalog=PROYECTO_FINAL_BD;Integrated Security=True";
        SqlConnection con;

        public void OpenConnection()
        {
            con = new SqlConnection(ConnectionString);
            con.Open();
        }


        public void CloseConnection()
        {
            con.Close();
        }


        public void ExecuteQueries(string Query_)
        {
            SqlCommand cmd = new SqlCommand(Query_, con);
            cmd.ExecuteNonQuery();
        }


        public SqlDataReader DataReader(string Query_)
        {
            SqlCommand cmd = new SqlCommand(Query_, con);
            SqlDataReader dr = cmd.ExecuteReader();
            return dr;
        }


        public DataTable execute(string Query_)
        {
            OpenConnection();
            SqlDataAdapter dr = new SqlDataAdapter(Query_, ConnectionString);
            DataSet ds = new DataSet();
            dr.Fill(ds);
            DataTable dt = ds.Tables[0];
            CloseConnection();
            return dt;
        }

        public DataTable executeSP(string spName, ArrayList parametros = null, ArrayList valores = null) {

            OpenConnection();
            SqlCommand command = new SqlCommand(spName, con);
            command.CommandType = System.Data.CommandType.StoredProcedure;
            if (parametros != null)
            {
                for (int i = 0; i < parametros.Count; i++)
                {
                    command.Parameters.Add(parametros[i].ToString(), SqlDbType.VarChar).Value = valores[i];
                }
            }
            DataTable dt = new DataTable();
            dt.Load(command.ExecuteReader());
            return dt;
        }
    }
}

