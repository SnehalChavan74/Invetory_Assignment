<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Inventory.aspx.cs" Inherits="Inventory" %>
<!<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script>
        function isNumber(evt) {
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                alert("Please enter only Numbers.");
                return false;
            }

            return true;
        }

        function isNumber(evt) {
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
        }
       
    </script>
    <script type="text/javascript">

       function numbersonly() {
           if (confirm('Are you sure you want to Submit Data? because once you submit its can not be edit .')) {
               return true;
           } else {
               return false;
           } 
       }
    </script>
    </script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title></title>

    <!-- Font Icon -->
    <link rel="stylesheet" href="fonts/material-icon/css/material-design-iconic-font.min.css">
    <link rel="stylesheet" href="vendor/nouislider/nouislider.min.css">

    <!-- Main css -->
    <link rel="stylesheet" href="css/style.css">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>

    <form id="form1" runat="server">
        <ajax:ToolkitScriptManager ID="toolScriptManageer1" runat="server"></ajax:ToolkitScriptManager> 
         <div class="form-group">
            <div class="container">
        <h1>Inventory details</h1>
   <div class="form-row">
        <div class="form-group">
            <div class="form-input">
                        <asp:Label ID="Label1"   runat="server" Font-Bold="true" Text="Search Id Wise Modify  "></asp:Label>
                        <asp:TextBox ID="txtid" Width="250px" onKeyPress="return isNumber(evt);"   runat="server"  ></asp:TextBox> 
                   
                    
                </div>
            </div>
       <div class="form-group">
            <div class="form-input">
                        
                   
                    <div class="form-submit">
               
               <asp:Button ID="btnSearch" class="submit" BackColor="#ccff66"   runat="server" Text="Search" OnClick="btnSearch_Click"   />
                    
            </div>
                </div>
            </div>
       </div>
            <div class="form-row">
                <div class="form-group">
 
                     <div class="form-input">
                        <asp:Label ID="lblItem" runat="server" Font-Bold="true"  Text="Name Of the Invetory "></asp:Label>
                        <asp:TextBox ID="txtInventoryName" Width="250px"   runat="server" onKeyPress="return ValidateAlpha(event);" ></asp:TextBox> 
     
                </div>
 
            </div>
                
            <div class="form-group">   
               <div class="form-input">
                         <asp:Label ID="lblDate" runat="server" Font-Bold="true" Text="Date "></asp:Label>
                         <asp:TextBox ID="txtDate"  Text='<%# Eval("NgaySinh", "{0:dd/mm/yyyy}") %>' onkeypress="return isNumber(event)" Width="250px" runat="server"></asp:TextBox>
                   <ajax:CalendarExtender ID="Calendar1"  runat="server" TargetControlID="txtDate"
                             Format="dd/MM/yyyy"> </ajax:CalendarExtender>  
                       
                    </div>
                    
   
    </div>
                <div class="form-group">   
               <div class="form-input">
                         <asp:Label ID="Label5" runat="server" Font-Bold="true"  Text="HSN Code "></asp:Label>
                         <asp:TextBox ID="tstHsnCode"  onkeypress="return isNumber(event)" Width="250px" runat="server"></asp:TextBox>
                     
                       
                    </div>
                    
   
    </div>
        </div>
               
           <div class="form-row">
        <div class="form-group">
            <div class="form-input">
                        <asp:Label ID="Label2" runat="server" Font-Bold="true" Text="Item Name "></asp:Label>
                        <div class="select-list">
                        <asp:DropDownList ID="ddlItem" DataTextField="Name"  Height="50" Width="250px"  DataValueField="id" runat="server">
                                                    <asp:ListItem Value="0">--SELECT--</asp:ListItem>
                                       </asp:DropDownList>
                             </div>
                   
                    
                </div>
            </div>
       <div class="form-group">
            <div class="form-input">     
                   <asp:Label ID="Label3" runat="server" Font-Bold="true"  Text="Quantity "></asp:Label>
                        <asp:TextBox ID="txtQty" Width="250px" onKeyPress="return isNumber(evt);"   runat="server"  ></asp:TextBox> 
                    
                </div>
            </div>
               <div class="form-group">
            <div class="form-input">     
                   <asp:Label ID="Label4" runat="server" Font-Bold="true" Text="Price "></asp:Label>
                        <asp:TextBox ID="txtprice" Width="250px" onKeyPress="return isNumber(evt);"   runat="server"  ></asp:TextBox> 
                    
                </div>
                    <div class="form-submit">
                
               <asp:Button ID="btnAdd" class="submit" BackColor="#009933"  runat="server" Text="Add" OnClick="btnAdd_Click"   />
                     
            </div>
                 

            </div>
       </div>  
                <div class="col-md-6">   
               <asp:GridView ID="GridView1" runat="server" Class= "table table-striped table-bordered table-condensed" BackColor="White" BorderColor="#3366CC" BorderWidth="1px"  AutoGenerateColumns="false"  OnRowDeleting="GridView1_RowDeleting"  >
                    <Columns>
                         <asp:BoundField DataField="InventroyId" HeaderText=" id" />
                        <asp:BoundField DataField="Name" HeaderText=" Name" />
                        <asp:BoundField DataField="Quantity" HeaderText="Price " />
                        <asp:BoundField DataField="Price" HeaderText="Quantity " />
                       
                        <asp:CommandField ControlStyle-BorderStyle="None" ControlStyle-ForeColor="red"
                            HeaderText="Delete" ShowDeleteButton="true" />
                        
                        
                        
                    </Columns>
                </asp:GridView>
                    </div>
                 <div class="form-submit">
                
               <asp:Button ID="btnSave" class="submit" BackColor="#009933"   runat="server" Text="Save"  OnClick="btnSave_Click"  />
                     <asp:Button ID="btnUpdate" class="submit" BackColor="#3399ff"   runat="server" Text="Update"  OnClick="btnUpdate_Click"  />
                    
            </div>
                 


    

    </div>
    
    </div>
    </form>
</body>
</html>


   
