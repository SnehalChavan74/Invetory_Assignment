using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Globalization;

public partial class Inventory : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["con"].ConnectionString);
    SqlCommand cmd;
    SqlDataAdapter da;
    SqlDataReader dr;
    int ItemId = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
            //cmd = new SqlCommand("select * from Item_Master", con);
            //da = new SqlDataAdapter(cmd);
            //DataTable dt = new DataTable();
            //da.Fill(dt);
            //GridView1.DataSource = dt;
            //GridView1.DataBind();
            BindItem();

        }
    }
    public void BindItem()
    {
        string com = "Select * from Item_Master";
        SqlDataAdapter da = new SqlDataAdapter(com, con);
        DataTable dt = new DataTable();
        da.Fill(dt);

        ddlItem.DataBind();
        ddlItem.DataTextField = "Name";
        ddlItem.DataValueField = "id";
        ddlItem.DataSource = dt;
        ddlItem.DataBind();
    }

    public void clearItem()
    {
        txtQty.Text = "";
        txtprice.Text = "";
        ddlItem.Items.Insert(0, new ListItem("--Select--", "0"));
        GridView1.DataSource = "";
        GridView1.DataBind();
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        if (ddlItem.Text == "")
        {

            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('  please select Item Name ');", true);

            return;
        }
        if (txtQty.Text == "")
        {

            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('   please Enter Quantity  ');", true);

            return;
        }
        if (txtprice.Text == "")
        {

            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('   please Enter  Price ');", true);

            return;
        }


        DataTable temp = new DataTable();
        if (!(ViewState["datatable"] == null))
        {
            temp = ((DataTable)(ViewState["datatable"]));
        }
        else
        {
            temp.Columns.Add("InventroyId");
            temp.Columns.Add("Name");
            temp.Columns.Add("Quantity");
            temp.Columns.Add("Price");


        }
        if ((temp != null))
        {

            DataRow row;
            row = temp.NewRow();
            ItemId = ItemId + 1;
            row["InventroyId"] = ItemId;
            row["Name"] = ddlItem.SelectedItem.Text;
            row["Quantity"] = txtQty.Text;
            row["Price"] = txtprice.Text;

            temp.Rows.Add(row);
            ViewState["datatable"] = temp;
            GridView1.DataSource = ViewState["datatable"];
            GridView1.DataBind();

           
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            con.Close();
            con.Open();



            if (txtInventoryName.Text == "")
            {

                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('Please Enter Inventory Name ');", true);

                return;
            }
            if (txtDate.Text == "")
            {

                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('Please Select Date ');", true);

                return;
            }
            if (tstHsnCode.Text == "")
            {

                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('Please Enter HSN Code ');", true);

                return;
            }




            string dt = txtDate.Text;
            DateTime date = DateTime.ParseExact(dt, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            cmd = new SqlCommand("InventoryInsert", con);
            SqlParameter outPutVal = new SqlParameter("@IdReturn", SqlDbType.Int);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Name", txtInventoryName.Text);
            cmd.Parameters.AddWithValue("@Date", date);
            cmd.Parameters.AddWithValue("@HSNCode", tstHsnCode.Text);


            SqlDataReader dr = cmd.ExecuteReader();
            int InventoryId = 0;
            if (dr.HasRows)
            {
                while (dr.Read())
                {
                    InventoryId = dr.GetInt32(0);

                    Response.Write("<Script>alert('Save Record successfully')</Script>");
                }
            }



            if (GridView1.Rows.Count > 0)
            {
                con.Close();
                con.Open();

                foreach (GridViewRow gr in GridView1.Rows)
                {
                    string Name = gr.Cells[1].Text;
                    string Quantity = gr.Cells[2].Text;
                    string Price = gr.Cells[3].Text;

                    cmd = new SqlCommand("InventoryDetailsItemInsert", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlParameter outputparameter = new SqlParameter();
                    outputparameter.ParameterName = "@IdReturn";
                    cmd.Parameters.AddWithValue("@InventroyId", InventoryId);
                    cmd.Parameters.AddWithValue("@Name", Name);

                    cmd.Parameters.AddWithValue("@Quantity", Quantity);
                    cmd.Parameters.AddWithValue("@price", Price);
                    int cont = cmd.ExecuteNonQuery();

                }

                clearItem();
                clear();

            }

        }
        catch (Exception ex)
        {


        }
    }

    private void clear()
    {
        txtDate.Text = "";
        txtInventoryName.Text = "";
        tstHsnCode.Text = "";
        txtid.Text = "";
    }

    protected void BindGrid1()
    {
        GridView1.DataSource = ViewState["datatable"] as DataTable;
        GridView1.DataBind();
    }




    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            DataTable dt = (DataTable)ViewState["datatable"];

            DataRow dr = dt.Rows[e.RowIndex];
            dt.Rows.Remove(dr);
            GridView1.EditIndex = -1;

            if (GridView1.Rows.Count <= 1)
            {
                BindGrid1();

            }
            else
            {
                BindGrid1();
            }


        }

        catch (Exception ex)
        {
        }

    }


    protected void btnSearch_Click(object sender, EventArgs e)
    {

        try
        {
            using (SqlCommand cmd = new SqlCommand("select  InventoryId,Name,Date,HSNCode from Inventory where  InventoryId= '" + txtid.Text + "'"))
            {
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                con.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    sdr.Read();
                    txtInventoryName.Text = sdr["Name"].ToString();
                    txtDate.Text = sdr["Date"].ToString();
                    tstHsnCode.Text = sdr["HSNCode"].ToString();
                }


                da = new SqlDataAdapter("select InvnetoryDetailsId,InventroyId,Name,Quantity,price from  InventoryDetails where InventroyId='" + txtid.Text + "'", con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                GridView1.DataSource = dt;
                GridView1.DataBind();
                con.Close();
            }
        }
        catch (Exception ex)
        {


        }

    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {

        try
        {
            con.Close();
            con.Open();
            string dt = txtDate.Text;
            DateTime date = DateTime.ParseExact(dt, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            cmd = new SqlCommand("InventoryUpdate", con);
            SqlParameter outPutVal = new SqlParameter("@IdReturn", SqlDbType.Int);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@InventoryId", txtid.Text);
            cmd.Parameters.AddWithValue("@Name", txtInventoryName.Text);
            cmd.Parameters.AddWithValue("@Date", date);
            cmd.Parameters.AddWithValue("@HSNCode", tstHsnCode.Text);


            SqlDataReader dr = cmd.ExecuteReader();
            int InventoryId = Convert.ToInt32(txtid.Text);
            if (dr.HasRows)
            {
                while (dr.Read())
                {
                    InventoryId = Convert.ToInt32(txtid.Text);

                    Response.Write("<Script>alert('Updated Record successfully')</Script>");
                }
            }



            if (GridView1.Rows.Count > 0)
            {
                con.Close();
                con.Open();

                foreach (GridViewRow gr in GridView1.Rows)
                {
                    string Name = gr.Cells[1].Text;
                    string Quantity = gr.Cells[2].Text;
                    string Price = gr.Cells[3].Text;

                    cmd = new SqlCommand("InventoryDetailsItemUpdate", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlParameter outputparameter = new SqlParameter();
                    outputparameter.ParameterName = "@IdReturn";
                    cmd.Parameters.AddWithValue("@InventroyId", InventoryId);
                    cmd.Parameters.AddWithValue("@Name", Name);

                    cmd.Parameters.AddWithValue("@Quantity", Quantity);
                    cmd.Parameters.AddWithValue("@price", Price);
                    int cont = cmd.ExecuteNonQuery();

                }

                clearItem();
                clear();
            }


        }
        catch (Exception ex)
        {


        }


    }

    
}