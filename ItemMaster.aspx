<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ItemMaster.aspx.cs" Inherits="ItemMaster" %>
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
         <div class="form-group">
            <div class="container">
        <h1>Item details</h1>
            <div class="form-row">
                <div class="form-group">
                  
                     <div class="form-input">
                        <asp:Label ID="lblid" runat="server" Font-Bold="true"  Text="Id "></asp:Label>
                        <asp:TextBox ID="txtid" Width="250px" onKeyPress="return isNumber(evt);" Enabled="false"  runat="server"  ></asp:TextBox> 
                   
                    
                </div>
                      
                      
                    <div class="form-input">
                        <asp:Label ID="lblItem" runat="server" Font-Bold="true"  Text="Item "></asp:Label>
                        <asp:TextBox ID="txtItemName" Width="250px"   runat="server" onKeyPress="return ValidateAlpha(event);" ></asp:TextBox> 
                   
                    
                </div>
                     
                    
                    <div class="form-input">
                         <asp:Label ID="lblQuantity" runat="server" Font-Bold="true" Text="Quantity "></asp:Label>
                         <asp:TextBox ID="txtQuantity"  onkeypress="return isNumber(event)" Width="250px" runat="server"></asp:TextBox>
                       
                    </div>
                    
                    
                     
             
            </div>
                
            <div class="form-group">
               
                <div class="form-input">
                         <asp:Label ID="lblPrice" runat="server" Font-Bold="true" Text="Price "></asp:Label>
                        <asp:TextBox ID="txtPrice" Width="250px" runat="server"></asp:TextBox>
    
                    </div>
               <div class="form-input">
                         <asp:Label ID="lblDiscount" runat="server" Font-Bold="true" Text="Discount  "></asp:Label>
                         <asp:TextBox ID="txtDiscount" onKeyPress="return isNumber(evt);" Width="250px" runat="server" OnTextChanged="txtDiscount_TextChanged" AutoPostBack="true"></asp:TextBox>
                       
                    </div>
                      
                <div class="form-input">
                         <asp:Label ID="lblTotalAmount" runat="server" Font-Bold="true" Text="Total Amount "></asp:Label>
                         <asp:TextBox ID="txtTotalAmount" onKeyPress="return isNumber(evt);"  Width="250px" runat="server"></asp:TextBox>
                       
                    </div>      
                    
                     
       

    </div>
        </div>
               
                
               
                 <div class="form-submit">
                <%--<input type="submit" value="Submit" class="submit" id="submit" name="submit" />--%>
               <asp:Button ID="btnAdd" class="submit" BackColor="#009933"   runat="server" Text="Add" OnClick="btnAdd_Click"  />
                     <asp:Button ID="btnUpdate" class="submit" BackColor="#3399ff"   runat="server" Text="Update"  OnClick="btnUpdate_Click" />
                     <asp:Button ID="btnDelete" class="submit" BackColor="#ff0066"  runat="server" Text="Delete" OnClick="btnDelete_Click"  />
            </div>
                <div>

                </div>
                <div class="form-group">
                 <asp:GridView ID="GridView1" runat="server" BorderWidth="1px" Class= "table table-striped table-bordered table-condensed"  AutoGenerateColumns="false"   DataKeyNames="id">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:CheckBox ID="CheckBox1" AutoPostBack="true" OnCheckedChanged="CheckBox1_CheckedChanged" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Name" HeaderText="T Name" />
                        <asp:BoundField DataField="Price" HeaderText="Price " />
                        <asp:BoundField DataField="Quantity" HeaderText="Quantity " />
                        <asp:BoundField DataField="Discount" HeaderText="Discount " />
                        <asp:BoundField DataField="TotalAmount" HeaderText="Total Amount " />
                       
                        
                        
                    </Columns>
                </asp:GridView>
                    </div>

    

    </div>
    <!-- Trigger the modal with a button -->
   
    <!-- Modal -->
    </div>
    </form>
</body>
</html>

