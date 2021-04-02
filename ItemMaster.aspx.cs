using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

public partial class ItemMaster : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["con"].ConnectionString);
    SqlCommand cmd;
    SqlDataAdapter da;
    SqlDataReader dr;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
            cmd = new SqlCommand("select * from Item_Master", con);
            da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();

        }

    }

    public void clear()
    {
        txtid.Text = "";
        txtDiscount.Text = "";
        txtItemName.Text = "";
        txtPrice.Text = "";
        txtQuantity.Text = "";
        txtTotalAmount.Text = "";
        //GridView1.DataSource = "";
        //GridView1.DataBind();

    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        try
        {
            // con.Close();
            con.Open();
            cmd = new SqlCommand("SaveItem", con);
            //SqlParameter outPutVal = new SqlParameter("@IdReturn", SqlDbType.Int);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Name", txtItemName.Text);
            cmd.Parameters.AddWithValue("@Price", txtPrice.Text);
            cmd.Parameters.AddWithValue("@Quantity", txtQuantity.Text);
            cmd.Parameters.AddWithValue("@Discount", txtDiscount.Text);
            cmd.Parameters.AddWithValue("@TotalAmount", txtTotalAmount.Text);
            int i = cmd.ExecuteNonQuery();
            if (i > 0)
            {


                Response.Write("<Script>alert('Save record successfully')</Script>");

            }

            else
            {
                Response.Write("<Script>alert(' Not save')</Script>");
            }
            clear();

        }
        catch (Exception ex)
        {


        }

    }

    protected void txtDiscount_TextChanged(object sender, EventArgs e)
    {
        try
        {


            double besic = Convert.ToDouble(txtPrice.Text);
            double discount = Convert.ToDouble(txtDiscount.Text);
            double total = besic * discount;
            txtTotalAmount.Text = total.ToString();


        }
        catch (Exception ex)
        {

        }

    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            // con.Close();
            con.Open();

            cmd = new SqlCommand("updateitem", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@id", txtid.Text);
            cmd.Parameters.AddWithValue("@Name", txtItemName.Text);
            cmd.Parameters.AddWithValue("@Price", txtPrice.Text);
            cmd.Parameters.AddWithValue("@Quantity", txtQuantity.Text);
            cmd.Parameters.AddWithValue("@Discount", txtDiscount.Text);
            cmd.Parameters.AddWithValue("@TotalAmount", txtTotalAmount.Text);
            int i = cmd.ExecuteNonQuery();
            if (i > 0)
            {


                Response.Write("<Script>alert('Update record successfully')</Script>");

            }

            else
            {
                Response.Write("<Script>alert(' Not Update')</Script>");
            }
            clear();

        }
        catch (Exception ex)
        {


        }

    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        try
        {
            con.Open();
            cmd = new SqlCommand("Delete from Item_Master where id='" + txtid.Text + "'", con);
            int id = cmd.ExecuteNonQuery();
            if (id > 0)
            {
                Response.Write("<Script>alert('Delete record Success')</Script>");
            }
            con.Close();
        }
        catch (Exception ex)
        {

            
        }
    }

    protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox ch = (CheckBox)sender;
        GridViewRow chk = (GridViewRow)ch.Parent.Parent;
        int rowindex = 0;
        rowindex = chk.RowIndex;
        int id = Convert.ToInt32(GridView1.DataKeys[rowindex].Value);
        con.Open();
        cmd = new SqlCommand("select id, Name,price,Quantity,Discount,TotalAmount from Item_Master where id='" + id + "'", con);
        dr = cmd.ExecuteReader();
        if (dr.Read())
        {

           txtid.Text = id.ToString();
            txtItemName.Text = dr[1].ToString();
            txtPrice.Text = dr[2].ToString();
            txtQuantity.Text = dr[3].ToString();
            txtDiscount.Text = dr[4].ToString();
            txtTotalAmount.Text = dr[5].ToString();

        }
    }
}