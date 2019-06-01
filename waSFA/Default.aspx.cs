using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace waSFA
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public void Login(object sender, EventArgs e)
        {
            String user = usr.Value;
            String pass = pwd.Value;

            ArrayList parametros = new ArrayList();
            ArrayList valores = new ArrayList();

            parametros.Add("@LOGIN");
            valores.Add(user);
            parametros.Add("@PASSWORD");
            valores.Add(pass);

            ConnectionDB cn = new ConnectionDB();
            DataTable u = cn.executeSP("spc_USUARIO_LOGIN", parametros, valores);

            if (u.Rows.Count > 0)
            {
                Session["user"] = u.Rows[0][0].ToString();
                Response.Redirect("Pedido");
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('Credenciales incorrectas');", true);
            }          
        }
    }
}