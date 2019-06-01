using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;

namespace waSFA
{
    public partial class Pedido : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["user"] = 1;
            if (Session["user"] != null)
            {
                if (IsPostBack)
                {

                }
                else
                {
                    llenarData();
                }
            }
            else
            {
                Response.Redirect("Default");
            }
            
        }
        private void llenarSucursales() {
            ConnectionDB cn = new ConnectionDB();
            DataTable sucursal = cn.executeSP("spg_SUCURSAL");
            ddlSucursal.DataSource = sucursal;
            ddlSucursal.DataTextField = "NOMBRE_SUCURSAL";
            ddlSucursal.DataValueField = "ID_SUCURSAL";
            ddlSucursal.DataBind();
        }
        private void llenarClientes()
        {
            ArrayList parametros = new ArrayList();
            ArrayList valores = new ArrayList();

            parametros.Add("@IDSUCURSAL");
            valores.Add(ddlSucursal.SelectedItem.Value);

            ConnectionDB cn = new ConnectionDB();
            DataTable clientes = cn.executeSP("spc_CLIENTE_X_SUCURSAL",parametros,valores);
            ddlCliente.DataSource = clientes;

            ddlCliente.DataTextField = "NOMBRE";
            ddlCliente.DataValueField = "ID_CLIENTE";
            ddlCliente.DataBind();
        }
        private void llenarGrid()
        {
            ConnectionDB cn = new ConnectionDB();
            DataTable dt = cn.executeSP("spg_ARTICULO");
            gvProductos.DataSource = dt;
            gvProductos.DataBind();
        }
        private void llenarData()
        {
            llenarSucursales();
            llenarClientes();
            llenarGrid();
        }

        protected void ddlSucursal_SelectedIndexChanged(object sender, EventArgs e)
        {
            llenarClientes();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            ArrayList parametros = new ArrayList();
            ArrayList valores = new ArrayList();

            parametros.Add("@IDCLIENTE");
            valores.Add(ddlCliente.SelectedItem.Value);

            parametros.Add("@IDEMPLEADO");
            valores.Add(Session["user"].ToString());

            parametros.Add("@FECHACREACION");
            valores.Add(DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss"));

            ConnectionDB cn = new ConnectionDB();
            DataTable u = cn.executeSP("spi_FACTURA_ENCABEZADO", parametros, valores);

            if (u.Rows.Count > 0)
            {
                for (int i = 0; i < gvProductos.Rows.Count; i++)
                {
                    String id = gvProductos.Rows[i].Cells[0].Text;
                    String precio = gvProductos.Rows[i].Cells[2].Text;
                    System.Web.UI.WebControls.TextBox tbx = (System.Web.UI.WebControls.TextBox)gvProductos.Rows[i].FindControl("tbxCantidad");
                    String cantidad = tbx.Text;
                    //int c = Int32.Parse(cantidad);
                    if (!cantidad.Equals("")) {
                        parametros = new ArrayList();
                        valores = new ArrayList();

                        parametros.Add("@IDENCABEZADO");
                        valores.Add(u.Rows[0][0].ToString());
                        parametros.Add("@IDARTICULO");
                        valores.Add(id);
                        parametros.Add("@V_PRECIOVENTA");
                        valores.Add(precio);
                        parametros.Add("@V_DESCUENTO");
                        valores.Add("0");
                        parametros.Add("@V_CANTIDAD");
                        valores.Add(cantidad);

                        cn = new ConnectionDB();
                        DataTable t = cn.executeSP("spi_FACTURA_DETALLE", parametros, valores);
                    }
                    ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('Orden "+ u.Rows[0][0].ToString() + " generada exitosamente');", true);
                }
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('ERROR');", true);
            }



            
        }
        protected void btnClear_Click(object sender, EventArgs e)
        {

        }
    }
}