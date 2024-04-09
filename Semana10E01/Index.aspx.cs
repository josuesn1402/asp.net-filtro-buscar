using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Semana10E01
{
  public partial class WebForm1 : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      if (!IsPostBack)
      {
        gvResult.PageSize = 10;
        CargarDatos();
      }
    }

    private readonly string con = ConfigurationManager.ConnectionStrings["conexion"].ConnectionString;

    private void CargarDatos()
    {
      using (SqlConnection connection = new SqlConnection(con))
      {
        SqlCommand cmd = new SqlCommand("CalcularSubtotal", connection);
        cmd.CommandType = CommandType.StoredProcedure;

        SqlDataAdapter adapter = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();

        connection.Open();
        adapter.Fill(dt);

        connection.Close();

        gvResult.DataSource = dt;
        gvResult.DataBind();

        if (dt.Rows.Count == 0)
        {
          lblNoResult.Visible = true;
          gvResult.Visible = false;
        }
        else
        {
          lblNoResult.Visible = false;
          gvResult.Visible = true;
        }
      }
    }

    protected void btnBuscar_Click(object sender, EventArgs e)
    {
      string buscar = txtTerminoBusqueda.Text.Trim();

      using (SqlConnection connection = new SqlConnection(con))
      {
        SqlCommand cmd = new SqlCommand("BuscarProductosPorTexto", connection);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@TerminoBusqueda", "%" + buscar + "%");

        SqlDataAdapter adapter = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();

        connection.Open();
        adapter.Fill(dt);

        connection.Close();

        gvResult.DataSource = dt;
        gvResult.DataBind();

        if (dt.Rows.Count == 0)
        {
          lblNoResult.Visible = true;
          gvResult.Visible = false;
        }
        else
        {
          lblNoResult.Visible = false;
          gvResult.Visible = true;
        }
      }
    }


    protected void gvResult_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void gvResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
      gvResult.PageIndex = e.NewPageIndex;
      CargarDatos();
    }

    protected void btnBuscarId_Click(object sender, EventArgs e)
    {
      string buscar = txtTerminoBusqueda.Text.Trim();

      if (string.IsNullOrEmpty(buscar))
      {
        CargarDatos();
        return;
      }

      int id;
      if (!int.TryParse(buscar, out id))
      {
        lblNoResult.Visible = true;
        gvResult.Visible = false;
        return;
      }

      using (SqlConnection connection = new SqlConnection(con))
      {
        SqlCommand cmd = new SqlCommand("BuscarProductosPorId", connection);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@IdProducto", id);

        SqlDataAdapter adapter = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();

        connection.Open();
        adapter.Fill(dt);

        connection.Close();

        gvResult.DataSource = dt;
        gvResult.DataBind();

        if (dt.Rows.Count == 0)
        {
          lblNoResult.Visible = true;
          gvResult.Visible = false;
        }
        else
        {
          lblNoResult.Visible = false;
          gvResult.Visible = true;
        }
      }
    }
  }
}